using IntervalArithmetic

"""
    truncated_supports(udata::AbstractUncertainValueDataset; quantiles = [0.001, 0.999])

Truncate the furnishing distribution of each uncertain value in the dataset
to the provided `quantiles` range. Returns a vector of Interval{Float64}, one 
for each value.
""" 
function truncated_supports(udata::AbstractUncertainValueDataset; 
            quantiles = [0.001, 0.999])
    n_vals = length(udata)
    
    # Using the provided quantiles, find the parts of the supports of the furnishing 
    # distributions from which we're going to sample.
    supports = Vector{Interval{Float64}}(undef, n_vals)
    
    for i = 1:n_vals
        lowerbound = quantile(udata[i], minimum(quantiles))
        upperbound = quantile(udata[i], maximum(quantiles))
        
        supports[i] = interval(lowerbound, upperbound)
    end
    
    return supports
end
    

""" 
    strictly_increasing_sequence_exists(udata::AbstractUncertainValueDataset; 
        quantiles = [0.0001, 0.9999]) 

Does a path through the dataset exist? I.e, check that a strictly 
increasing sequence can be found after first 
constraining each distribution to the provided quantile range (this 
is necessary because some distributions may have infinite support).
""" 
function strictly_increasing_sequence_exists(udata, quantiles = [0.0001, 0.9999])
    n_vals = length(udata)
    sample = Vector{Float64}(undef, n_vals)
    
    # First, constrain all data such that the supports are all finite
    constrained_data = constrain(udata, TruncateQuantiles(quantiles...,))

    # Sample the first value in a way that ensures a strictly 
    # increasing sequence from indices 2:end will exist.
    minima = minimum.(constrained_data)
    maxima = maximum.(constrained_data)
    
    increasing_sequence_exists = true
    
    for i = 2:n_vals - 1
        # Find the lower and upper bounds of the support from which 
        # we can draw values while still ensuring an increasing 
        # sequence of values.
        
        lo = minima[i]
        hi = minimum(maxima[i:end])
        if lo > hi
            increasing_sequence_exists = false
        end
    end
    
    return increasing_sequence_exists 
end

"""
    strictly_decreasing_sequence_exists(udata::AbstractUncertainValueDataset;
        quantiles = [0.0001, 0.9999]) 

Does a path through the dataset exist? I.e,  check that a strictly 
decreasing sequence can be found after first 
constraining each distribution to the provided quantile range (this 
is necessary because some distributions may have infinite support).
""" 
function strictly_decreasing_sequence_exists(udata; quantiles = [0.0001, 0.9999])
    # If a strictly increasing sequence exists for the reversed dataset, then a strictly 
    # decreasing sequence exists for the original dataset.
    strictly_increasing_sequence_exists(udata[end:-1:1], quantiles = quantiles)
end



export 
strictly_increasing_sequence_exists,
strictly_decreasing_sequence_exists