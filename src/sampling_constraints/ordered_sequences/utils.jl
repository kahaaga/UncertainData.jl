
"""
    get_quantiles(x, c::SequentialSamplingConstraint{<:OrderedSamplingAlgorithm}) → Tuple{Vector{Float64}, Vector{Float64}}
    get_quantiles!(lqs, uqs, x, c::SequentialSamplingConstraint{<:OrderedSamplingAlgorithm}) → Tuple{Vector{Float64}, Vector{Float64}}

Get the element-wise lower and upper quantiles for `x` respecting the quantiles given by the constraint `c`.
The in-place `get_quantiles!` writes the quantiles to pre-allocated vectors `lqs` and `uqs`.
"""
function get_quantiles end

"""
    get_quantiles(x, c::SequentialSamplingConstraint{<:OrderedSamplingAlgorithm}) → Tuple{Vector{Float64}, Vector{Float64}}
    get_quantiles!(lqs, uqs, x, c::SequentialSamplingConstraint{<:OrderedSamplingAlgorithm}) → Tuple{Vector{Float64}, Vector{Float64}}

Get the element-wise lower and upper quantiles for `x` respecting the quantiles given by the constraint `c`.
The in-place `get_quantiles!` writes the quantiles to pre-allocated vectors `lqs` and `uqs`.
"""
function get_quantiles! end

const SSC = SequentialSamplingConstraint{<:OrderedSamplingAlgorithm}

# Generic case takes care of vectors of uncertain values
function get_quantiles(x, c::SSC)
    lqs = quantile.(x, c.lq, c.n)
    uqs = quantile.(x, c.uq, c.n)
    return lqs, uqs
end

function get_quantiles!(lqs, uqs, x, c::SSC)
    length(lqs) == length(uqs) == length(x) || error("Lengths of `lqs`, `uqs` and `x` do not match.")
    lqs .= quantile.(x, c.lq, c.n)
    uqs .= quantile.(x, c.uq, c.n)
end

# Be specific when it comes to concrete types with differently named data fields.
function get_quantiles(x::UncertainIndexDataset, c::SSC)
    lqs = quantile.(x.indices, c.lq, c.n)
    uqs = quantile.(x.indices, c.uq, c.n)
    return lqs, uqs
end

function get_quantiles!(lqs, uqs, x::UncertainIndexDataset, c::SSC)
    length(lqs) == length(uqs) == length(x) || error("Lengths of `lqs`, `uqs` and `x` do not match.")
    lqs .= quantile.(x.indices, c.lq, c.n)
    uqs .= quantile.(x.indices, c.uq, c.n)
end

function get_quantiles(x::UncertainValueDataset, c::SSC)
    lqs = quantile.(x.values, c.lq, c.n)
    uqs = quantile.(x.values, c.uq, c.n)
    return lqs, uqs
end

function get_quantiles!(x::UncertainValueDataset, c::SSC)
    length(lqs) == length(uqs) == length(x) || error("Lengths of `lqs`, `uqs` and `x` do not match.")
    lqs .= quantile.(x.values, c.lq, c.n)
    uqs .= quantile.(x.values, c.uq, c.n)
end


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
