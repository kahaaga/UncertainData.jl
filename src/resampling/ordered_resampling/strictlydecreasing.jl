import ..SamplingConstraints: 
    StartToEnd,
    StrictlyDecreasing,
    sequence_exists,
    constrain,
    TruncateMaximum,
    TruncateRange, 
    TruncateQuantiles

import IntervalArithmetic: 
    interval




# function resample(udata::DT, constraint::Vector{SCT}, 
#         sequential_constraint::StrictlyDecreasing{T}) where {SCT <: SamplingConstraint, 
#                     DT <: AbstractUncertainValueDataset, 
#                     T <: StartToEnd}

#     resample(constrain(udata, constraint), sequential_constraint)
# end



# """ 
#     resample(udata::AbstractUncertainValueDataset, 
#         constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
#         sequential_constraint::StrictlyDecreasing{OrderedSamplingAlgorithm})

# Draw a sequence of values strictly decreasing in magnitude from the dataset, sampling 
# each of the furnishing distributions once each, after first truncating the supports 
# of the values in the dataset using the provided `constraint`s.

# ## Arguments: 

# - **`udata`**: An uncertain dataset.
# - **`constraint`**: Sampling constraint(s) to apply to each of the values in the dataset 
# before drawing the sequence of decreasing values.
# - **`sequential_constraint`**: An instance of a `StrictlyDecreasing` sequential 
# sampling constraint. For example, `StrictlyDecreasing(StartToEnd())` indicates 
# that a strictly decreasing sequence should be created in one go from start to 
# finish (as opposed to chunking the data set first, then gluing partial sequences 
# together afterwards).
# """ 
# resample(udata::AbstractUncertainValueDataset, 
#     constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
#     sequential_constraint::StrictlyDecreasing{OrderedSamplingAlgorithm})


# """
# function resample(udata::UncertainIndexValueDataset,
#     sequential_constraint::StrictlyDecreasing, 
#     quantiles = [0.0001, 0.9999])

# Resample an uncertain index-value dataset by enforcing strictly decreasing indices. 
# """ 
# function resample(udata::UncertainIndexValueDataset,
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})
#     resample(udata.indices, sequential_constraint), resample(udata.values)
# end

# function resample(udata::UncertainIndexValueDataset, 
#         constraint::SamplingConstraint,
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, constraint))

#     inds, vals
# end

# function resample(udata::UncertainIndexValueDataset, 
#         constraint::Vector{SamplingConstraint},
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, constraint))

#     inds, vals
# end

# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::SamplingConstraint,
#         value_constraint::SamplingConstraint,
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})
    
#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end


# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::Vector{<:SamplingConstraint},
#         value_constraint::SamplingConstraint,
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end


# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::SamplingConstraint,
#         value_constraint::Vector{<:SamplingConstraint},
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end

# function resample(udata::UncertainIndexValueDataset, 
#         idx_constraint::Vector{<:SamplingConstraint},
#         value_constraint::Vector{<:SamplingConstraint},
#         sequential_constraint::StrictlyDecreasing{<:OrderedSamplingAlgorithm})

#     inds = resample(constrain(udata.indices, idx_constraint), sequential_constraint)
#     vals = resample(constrain(udata.values, value_constraint))

#     inds, vals
# end

# export resample