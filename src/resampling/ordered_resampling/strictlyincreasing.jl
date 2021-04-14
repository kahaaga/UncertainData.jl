import ..SamplingConstraints: 
    SamplingConstraint,
    SequentialSamplingConstraint,
    OrderedSamplingAlgorithm,
    StartToEnd,
    StrictlyIncreasing,
    sequence_exists,
    TruncateMinimum, 
    TruncateRange,
    TruncateQuantiles,
    constrain

export resample

import IntervalArithmetic:
    interval

function sample_increasing!(s, x, c::StrictlyIncreasing{StartToEnd}, mins, maxs)
    L = length(x)
    
    # TODO: add slight margin?
    for i = 1:L
        if i == 1
            hi = minimum(maxs[2:end])
            truncated_distribution = truncate(x[i], TruncateMaximum(hi))
            s[i] = resample(truncated_distribution)
        end
        
        if 1 < i < L
            lo = max(s[i - 1], mins[i])
            hi = min(maxs[i], minimum(maxs[i+1:end]))
            
            lo < hi || error("Truncation range invalid for point $i. Got lo < hi ($lo < $hi), which should be impossible.")
            
            truncated_distribution = truncate(x[i], TruncateRange(lo, hi))
            s[i] = resample(truncated_distribution)
        end
        
        if i == L
            lo = max(s[i - 1], mins[i])
            truncated_distribution = truncate(x[i], TruncateMinimum(lo))
            s[i] = resample(truncated_distribution)

        end
    end
    
    return s
end

"""
    sample_increasing(x, c::StrictlyIncreasing{StartToEnd}, mins, maxs)

Sample `x` in a strictly increasing manner, given pre-computed minimum and maximum 
values for each distribution in `c`.

Implicitly assumes a strictly increasing sequence exists, but does not check that condition.
"""
function sample_increasing(x, c::StrictlyIncreasing{StartToEnd}, mins, maxs)    
    L = length(x)
    samples = zeros(Float64, L) # a vector to hold the element-wise samples
    
    sample_increasing!(samples, x)
end

"""
    resample(x, c::StrictlyIncreasing{T}) where T<:OrderedSamplingAlgorithm

Sample `x` element-wise such that the samples form a strictly increasing sequence.

A check is performed before sampling to ensure that such a sequence exists.
Before the check is performed, the distributions in `x` are truncated element-wise
to the quantiles provided by `c` to ensure they have finite supports.

    resample!(s, x, c::StrictlyIncreasing{T}, lqs, uqs) where T<:OrderedSamplingAlgorithm

The same as above, but store the sampled values a pre-allocated vector `s`, where 
`length(x) == length(s)`. This avoids excessive memory allocations during repeated
resampling. This requires pre-computing the element-wise lower and upper quantiles 
`lqs` and `uqs` for the initial truncation step.

This method *does not* check for the existence of a strictly increasing sequence in `x`.
To check that, use [`sequence_exists`](@ref).

See also: [`sequence_exists`](@ref), [`StrictlyIncreasing`](@ref), [`StartToEnd`](@ref).

## Examples

```julia
N = 100
t = [UncertainValue(Normal, i, 2) for i in 1:N];
resample(t, StrictlyIncreasing(StartToEnd()))
```

```julia
N = 100
t = [UncertainValue(Normal, i, 2) for i in 1:N];

# Verify that an increasing sequence through `t` exists
c = StrictlyIncreasing(StartToEnd())
exists, lqs, uqs = sequence_exists(t, c)

# Pre-allocate sample vector
s = zeros(Float64, N)

if exists
    for i = 1:100
        resample!(s, t, c)
        # Do something with s
        # ...
    end
end
```
"""
function resample(x, c::StrictlyIncreasing{StartToEnd})
    sequence_exists, lqs, uqs = increasing_sequence_exists(x, c)
    sequence_exists || error("Increasing sequence does not exist")
    sample_increasing(x, c, lqs, uqs)
end

function resample!(s, x, c::StrictlyIncreasing{StartToEnd}, lqs, uqs)
    sample_increasing!(s, x, c, lqs, uqs)
end

# function resample(udata::DT, constraint::SCT, 
#         sequential_constraint::StrictlyDecreasing{T}) where {SCT <: SamplingConstraint, 
#             DT <: AbstractUncertainValueDataset, 
#             T <: StartToEnd}

#     resample(constrain(udata, constraint), sequential_constraint)
# end


# function resample(udata::DT, 
#         constraint::SCT,
#         sequential_constraint::StrictlyIncreasing{T};
#         quantiles = [0.0001, 0.9999]) where {SCT <: SamplingConstraint, 
#                 DT <: AbstractUncertainValueDataset, 
#                 T <: StartToEnd}

#     # Truncate the support of each value in the dataset according to the provided 
#     # constraint(s) and then resample

#     resample(constrain(udata, constraint), sequential_constraint)
# end


# function resample(udata::DT, 
#     constraint::Vector{SCT},
#     sequential_constraint::StrictlyIncreasing{T};
#     quantiles = [0.0001, 0.9999]) where {SCT <: SamplingConstraint, 
#         DT <: AbstractUncertainValueDataset,
#          T <: StartToEnd}

#     # Truncate the support of each value in the dataset according to the provided 
#     # constraint(s) and then resample
#     resample(constrain(udata, constraint), sequential_constraint)
# end


# export resample



# """ 
#     resample(udata::AbstractUncertainValueDataset, 
#         constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
#         sequential_constraint::StrictlyIncreasing{OrderedSamplingAlgorithm})

# Draw a sequence of values strictly increasing in magnitude from the dataset, sampling 
# each of the furnishing distributions once each, after first truncating the supports 
# of the values in the dataset using the provided `constraint`s.

# ## Arguments: 

# - **`udata`**: An uncertain dataset.
# - **`constraint`**: Sampling constraint(s) to apply to each of the values in the dataset 
#     before drawing the sequence of increasing values.
# - **`sequential_constraint`**: An instance of a `StrictlyIncreasing` sequential 
#     sampling constraint. For example, `StrictlyIncreasing(StartToEnd())` indicates 
#     that a strictly increasing sequence should be created in one go from start to 
#     finish (as opposed to chunking the data set first, then gluing partial sequences 
#     together afterwards).
# """ 
# resample(udata::AbstractUncertainValueDataset, 
#     constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
#     sequential_constraint::StrictlyIncreasing{OrderedSamplingAlgorithm})


# """
# function resample(udata::UncertainIndexValueDataset,
#     sequential_constraint::StrictlyIncreasing, 
#     quantiles = [0.0001, 0.9999])

# Resample an uncertain index-value dataset by enforcing strictly increasing indices. 
# """ 
# function resample(udata::UncertainIndexValueDataset,
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})
#     resample(udata.indices, sequential_constraint), resample(udata.values)
# end


# function resample(udata::UncertainIndexValueDataset, 
#         constraint::SamplingConstraint,
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, constraint))

#     inds, vals
# end

# function resample(udata::UncertainIndexValueDataset, 
#         constraint::Vector{SamplingConstraint},
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, constraint))

#     inds, vals
# end


# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::SamplingConstraint,
#         value_constraint::SamplingConstraint,
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})
    
#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end


# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::Vector{<:SamplingConstraint},
#         value_constraint::SamplingConstraint,
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end


# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::SamplingConstraint,
#         value_constraint::Vector{<:SamplingConstraint},
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end

# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::Vector{<:SamplingConstraint},
#         value_constraint::Vector{<:SamplingConstraint},
#         sequential_constraint::StrictlyIncreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end