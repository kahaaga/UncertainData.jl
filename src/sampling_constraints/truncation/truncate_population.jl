import ..UncertainValues:
    AbstractScalarPopulation,
    UncertainScalarPopulation

function Base.truncate(p::AbstractScalarPopulation, constraint::NoConstraint)
    p.values, p.probs
end

function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateRange) where {T <: Number, PW}
    inds = findall(constraint.min .<= p.values .<= constraint.max)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end

function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum) where {T <: Number, PW}
    inds = findall(p.values .<= constraint.max)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end


function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum) where {T <: Number, PW}
    inds = findall(constraint.min .<= p.values)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end


function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateLowerQuantile) where {T <: Number, PW}
    lower_bound = quantile(p, constraint.lower_quantile)

    inds = findall(lower_bound .<= p.values)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end

function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateUpperQuantile) where {T <: Number, PW}
    upper_bound = quantile(p, constraint.upper_quantile)

    inds = findall(p.values .<= upper_bound)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end


function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateQuantiles) where {T <: Number, PW}
    lower_bound = quantile(p, constraint.lower_quantile)
    upper_bound = quantile(p, constraint.upper_quantile)

    inds = findall(lower_bound .<= p.values .<= upper_bound)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end


function Base.truncate(p::UncertainScalarPopulation{T, PW}, constraint::TruncateStd; n::Int = 30000) where {T <: Number, PW}
    p_mean = mean(p, n)
    p_stdev = std(p, n)
    nσ  = constraint.nσ

    inds = findall(p_mean - p_stdev*nσ .<= p.values .<= p_mean + p_stdev*nσ)

    if length(inds) == 0 
        throw(ArgumentError("$p could not be truncated. No values left after truncation."))
    end

    p.values[inds], p.probs[inds]
end
# OLD STUFF: the stuff above dispatches on numerical populations  explicitly
# function Base.truncate(p::AbstractScalarPopulation, constraint::NoConstraint)
#     p.values, p.probs
# end

# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateRange)
#     inds = findall(constraint.min .<= p.values .<= constraint.max)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateMaximum)
#     inds = findall(p.values .<= constraint.max)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateMinimum)
#     inds = findall(constraint.min .<= p.values)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateLowerQuantile)
#     lower_bound = quantile(p, constraint.lower_quantile)

#     inds = findall(lower_bound .<= p.values)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateUpperQuantile)
#     upper_bound = quantile(p, constraint.upper_quantile)

#     inds = findall(p.values .<= upper_bound)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateQuantiles)
#     lower_bound = quantile(p, constraint.lower_quantile)
#     upper_bound = quantile(p, constraint.upper_quantile)

#     inds = findall(lower_bound .<= p.values .<= upper_bound)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(p::AbstractScalarPopulation, constraint::TruncateStd; n::Int = 30000)
#     p_mean = mean(p, n)
#     p_stdev = std(p, n)
#     nσ  = constraint.nσ

#     inds = findall(p_mean - p_stdev*nσ .<= p.values .<= p_mean + p_stdev*nσ)

#     if length(inds) == 0 
#         throw(ArgumentError("$p could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

export truncate