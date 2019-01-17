import ..SamplingConstraints: 
    SamplingConstraint,
    SequentialSamplingConstraint,
    OrderedSamplingAlgorithm,
    StartToEnd,
    StrictlyIncreasing,
    strictly_increasing_sequence_exists,
    TruncateMinimum, 
    TruncateRange,
    TruncateQuantiles,
    constrain

import IntervalArithmetic:
    interval


""" 
    resample(udata::DT, sequential_constraint::StrictlyIncreasing{T};
        quantiles = [0.0001, 0.9999]) where {DT <: AbstractUncertainValueDataset, T <: StartToEnd}

Element-wise resample the uncertain values in the dataset such that each preceding value 
is strictly less in magnitude than the next one. 

## Arguments: 

- **`udata`**: An uncertain dataset.
- **`sequential_constraint`**: An instance of a `StrictlyIncreasing` sequential 
    sampling constraint. 
- **`ordered_sampling_alg`**: An instance of a `StartToEnd` ordered 
    sampling constraint, indicating that the sequence of increasing values should 
    be created in one go from start to finish (as opposed to chunking the data set 
    first, then gluing partial sequences together afterwards).
- **`quantiles`**: A two-element vector representing a quantile range which is used 
    to truncate the supports values in the dataset before drawing the sequence of 
    increasing values. This deals with distributions with infinite support.
""" 
function resample(udata::DT, 
        sequential_constraint::StrictlyIncreasing{T};
        quantiles = [0.0001, 0.9999]) where {DT <: AbstractUncertainValueDataset, T <: StartToEnd}
    n_vals = length(udata)
    
    # First, constrain all data such that the supports of all furnishing distributions 
    # are finite.
    constrained_data = constrain(udata, TruncateQuantiles(quantiles...,))

    if !strictly_increasing_sequence_exists(udata, quantiles)
        throw(ArgumentError("No strictly increasing sequence through dataset exists."))
    end
    
    # Pre-allocate a sample 
    sample = Vector{Float64}(undef, n_vals)
    
    # Sample the first value in a way that ensures a strictly 
    # increasing sequence from indices 2:end will exist.
    lo = minimum(constrained_data[1])
    hi = minimum(maximum.(constrained_data[1:end]))
    sample[1] = resample(udata[1], TruncateRange(lo, hi))
    
    for i = 2:n_vals - 1
        # Find the lower and upper bounds of the support from which we can draw values 
        # while still ensuring an increasing sequence of values.
        lo = sample[i - 1]
        hi = minimum([maximum(constrained_data[i]); 
                        maximum.(constrained_data[(i + 1):end])])
        
        # Constrain the support of the furnishing distribution according 
        # to the bounds and sample a value from it.
        constrained_val = constrain(constrained_data[i], TruncateRange(lo, hi))
        sample[i] = resample(constrained_val)
    end
    
    # The last value doesn't need an upper bound, because there's no 
    # value following it we need to consider.
    sample[n_vals] = resample(udata[n_vals], TruncateMinimum(sample[end - 1]))
    
    return sample
end


function resample(udata::DT, 
        constraint::SCT,
        sequential_constraint::StrictlyIncreasing{T};
        quantiles = [0.0001, 0.9999]) where {SCT <: SamplingConstraint, 
                DT <: AbstractUncertainValueDataset, 
                T <: StartToEnd}

    # Truncate the support of each value in the dataset according to the provided 
    # constraint(s) and then resample

    resample(constrain(udata, constraint), sequential_constraint, quantiles = quantiles)
end


function resample(udata::DT, 
    constraint::Vector{SCT},
    sequential_constraint::StrictlyIncreasing{T};
    quantiles = [0.0001, 0.9999]) where {SCT <: SamplingConstraint, 
        DT <: AbstractUncertainValueDataset,
         T <: StartToEnd}

    # Truncate the support of each value in the dataset according to the provided 
    # constraint(s) and then resample
    resample(constrain(udata, constraint), sequential_constraint, quantiles = quantiles)
end


export resample



""" 
    resample(udata::AbstractUncertainValueDataset, 
        constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
        sequential_constraint::StrictlyIncreasing{OrderedSamplingAlgorithm};
        quantiles = [0.0001, 0.9999])

Draw a sequence of values strictly increasing in magnitude from the dataset, sampling 
each of the furnishing distributions once each, after first truncating the supports 
of the values in the dataset using the provided `constraint`s.

## Arguments: 

- **`udata`**: An uncertain dataset.
- **`constraint`**: Sampling constraint(s) to apply to each of the values in the dataset 
    before drawing the sequence of increasing values.
- **`sequential_constraint`**: An instance of a `StrictlyIncreasing` sequential 
    sampling constraint. For example, `StrictlyIncreasing(StartToEnd())` indicates 
    that a strictly increasing sequence should be created in one go from start to 
    finish (as opposed to chunking the data set first, then gluing partial sequences 
    together afterwards).
- **`quantiles`**: A two-element vector representing a quantile range which is used 
    to truncate the supports values in the dataset before drawing the sequence of 
    increasing values. This deals with distributions with infinite support.
""" 
resample(udata::AbstractUncertainValueDataset, 
    constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
    sequential_constraint::StrictlyIncreasing{OrderedSamplingAlgorithm};
    quantiles = [0.0001, 0.9999])




"""
function resample(udata::UncertainIndexValueDataset,
    sequential_constraint::StrictlyIncreasing, 
    quantiles = [0.0001, 0.9999])

Resample an uncertain index-value dataset by enforcing strictly increasing indices. 
""" 
function resample(udata::UncertainIndexValueDataset,
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})
    resample(udata.indices, sequential_constraint), resample(udata.values)
end


function resample(udata::UncertainIndexValueDataset, 
        constraint::SamplingConstraint,
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

    inds = resample(constrain(udata.indices, constraint), sequential_constraint)
    vals = resample(constrain(udata.indices, constraint))

    inds, vals
end

function resample(udata::UncertainIndexValueDataset, 
        constraint::Vector{SamplingConstraint},
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

    inds = resample(constrain(udata.indices, constraint), sequential_constraint)
    vals = resample(constrain(udata.indices, constraint))

    inds, vals
end


function resample(udata::UncertainIndexValueDataset, 
        idx_constraint::SamplingConstraint,
        value_constraint::SamplingConstraint,
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})
    
    inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
    vals = resample(constrain(udata.indices, value_constraint))

    inds, vals
end


function resample(udata::UncertainIndexValueDataset, 
        idx_constraint::Vector{<:SamplingConstraint},
        value_constraint::SamplingConstraint,
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

    inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
    vals = resample(constrain(udata.indices, value_constraint))

    inds, vals
end


function resample(udata::UncertainIndexValueDataset, 
        idx_constraint::SamplingConstraint,
        value_constraint::Vector{<:SamplingConstraint},
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

    inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
    vals = resample(constrain(udata.indices, value_constraint))

    inds, vals
end

function resample(udata::UncertainIndexValueDataset, 
        idx_constraint::Vector{<:SamplingConstraint},
        value_constraint::Vector{<:SamplingConstraint},
        sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

    inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
    vals = resample(constrain(udata.indices, value_constraint))

    inds, vals
end