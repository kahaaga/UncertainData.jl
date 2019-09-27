import ..UncertainValues:
    AbstractScalarPopulation,
    UncertainScalarPopulation

"""
    truncate(population::AbstractScalarPopulation, constraint::NoConstraint)

Get the elements and the associated sampling weights of the `population` members 
satisfying the sampling `constraint`.

- If `constraint` is a `NoConstraint` instance, then all members and weights are 
    returned unmodified.
"""
function Base.truncate(pop::AbstractScalarPopulation, constraint::NoConstraint)
    ConstrainedUncertainScalarPopulation(pop.values, pop.probs)
end

############################################################
# Populations whose members are strictly real-valued scalars
############################################################
function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange) where {T <: Number, PW}
    inds = findall(constraint.min .<= pop.values .<= constraint.max)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum) where {T <: Number, PW}
    inds = findall(pop.values .<= constraint.max)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum) where {T <: Number, PW}
    inds = findall(constraint.min .<= pop.values)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateLowerQuantile) where {T <: Number, PW}
    lower_bound = quantile(pop, constraint.lower_quantile)

    inds = findall(lower_bound .<= pop.values)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateUpperQuantile) where {T <: Number, PW}
    upper_bound = quantile(pop, constraint.upper_quantile)

    inds = findall(pop.values .<= upper_bound)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateQuantiles) where {T <: Number, PW}
    lower_bound = quantile(pop, constraint.lower_quantile)
    upper_bound = quantile(pop, constraint.upper_quantile)

    inds = findall(lower_bound .<= pop.values .<= upper_bound)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateStd; n::Int = 30000) where {T <: Number, PW}
    # Draw a sample of size `n` of the member of `p` according to their weights.
    s = resample(pop, n)
    
    # Compute mean and standard deviation
    p_mean = mean(s)
    p_stdev = std(s)
    
    nσ  = constraint.nσ
    inds = findall(p_mean - p_stdev*nσ .<= pop.values .<= p_mean + p_stdev*nσ)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


############################################################
# Populations whose members are some sort of uncertain value
############################################################

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum) where {T <: AbstractUncertainValue, PW}
    mins = [minimum(uv) for uv in pop]
    
    inds = findall(mins .>= constraint.min)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum, n::Int) where {T <: AbstractUncertainValue, PW}
    Base.truncate(pop, constraint)
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum) where {T <: AbstractUncertainValue, PW}
    maxs = [maximum(uv) for uv in pop]
    
    inds = findall(maxs .<= constraint.max)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum, n::Int) where {T <: AbstractUncertainValue, PW} 
    Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum)
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange) where {T <: AbstractUncertainValue, PW}
    maxs = [maximum(uv) for uv in pop]
    mins = [minimum(uv) for uv in pop]

    minb = maxs .<= constraint.max
    maxb = mins .>= constraint.min
    
    inds = findall(minb .& maxb)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange, n::Int) where {T <: AbstractUncertainValue, PW}
    Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange) 
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, 
        constraint::TruncateLowerQuantile, 
        n::Int = 30000) where {T <: AbstractUncertainValue, PW}
    
    # We want to truncate each of the population members so that their furnishing distributions
    # cannot yield numbers smaller than the overall quantile of the population. First 
    # find the overall lower quantile
    population_lower_quantile = quantile(pop, constraint.lower_quantile, n)
    
    # Now, truncate each of the population members below at the overall population lower
    # quantile. Probabilities are kept the same.
    truncated_vals = [truncate(uv, TruncateMinimum(population_lower_quantile)) for uv in pop]
    
    ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs)
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, 
        constraint::TruncateUpperQuantile, 
        n::Int = 30000) where {T <: AbstractUncertainValue, PW}
    
    # We want to truncate each of the population members so that their furnishing distributions
    # cannot yield numbers larger than the overall quantile of the population. First 
    # find the overall lower quantile
    population_upper_quantile = quantile(pop, constraint.upper_quantile, n)
    
    # Now, truncate each of the population members above at the overall population upper
    # quantile. Probabilities are kept the same.
    truncated_vals = [truncate(uv, TruncateMaximum(population_upper_quantile)) for uv in pop]
    
    ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs)
end



function Base.truncate(pop::UncertainScalarPopulation{T, PW}, 
        constraint::TruncateQuantiles, 
        n::Int = 30000) where {T <: AbstractUncertainValue, PW}
    
    # We want to truncate each of the population members so that their furnishing distributions
    # cannot yield numbers larger than the overall upper quantile of the population, nor 
    # numbers smaller than the overall lower quantile of the population. Find these. 
    population_upper_quantile = quantile(pop, constraint.upper_quantile, n)
    population_lower_quantile = quantile(pop, constraint.lower_quantile, n)

    # Now, truncate each of the population members at the range given by the overall quantiles
    # Probabilities are kept the same.
    truncated_vals = [truncate(uv, TruncateRange(population_lower_quantile, population_upper_quantile)) for uv in pop]
    
    ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs)
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, 
        constraint::TruncateStd{Number}, 
        n::Int = 30000) where {T <: AbstractUncertainValue, PW}
    
    # We want to truncate each of the population members so that their furnishing distributions
    # cannot yield numbers larger than the overall upper quantile of the population, nor 
    # numbers smaller than the overall lower quantile of the population. Find these.
    population_std = std(pop, n)
    population_mean = std(pop, n)
    
    upper_bound = population_mean + constraint.nσ*population_std
    lower_bound = population_mean - constraint.nσ*population_std
    
    # Now, truncate each of the population members at the range given by the overall quantiles
    # Probabilities are kept the same.
    truncated_vals = [truncate(uv, TruncateRange(lower_bound, upper_bound)) for uv in pop]
    
    ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs)
end





# function Base.truncate(pop::AbstractScalarPopulation, constraint::NoConstraint)
#     p.values, p.probs
# end

# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange) where {T <: Number, PW}
#     inds = findall(constraint.min .<= p.values .<= constraint.max)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum) where {T <: Number, PW}
#     inds = findall(p.values .<= constraint.max)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum) where {T <: Number, PW}
#     inds = findall(constraint.min .<= p.values)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateLowerQuantile) where {T <: Number, PW}
#     lower_bound = quantile(pop, constraint.lower_quantile)

#     inds = findall(lower_bound .<= p.values)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateUpperQuantile) where {T <: Number, PW}
#     upper_bound = quantile(pop, constraint.upper_quantile)

#     inds = findall(p.values .<= upper_bound)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateQuantiles) where {T <: Number, PW}
#     lower_bound = quantile(pop, constraint.lower_quantile)
#     upper_bound = quantile(pop, constraint.upper_quantile)

#     inds = findall(lower_bound .<= p.values .<= upper_bound)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateStd; n::Int = 30000) where {T <: Number, PW}
#     p_mean = mean(pop, n)
#     p_stdev = std(pop, n)
#     nσ  = constraint.nσ

#     inds = findall(p_mean - p_stdev*nσ .<= p.values .<= p_mean + p_stdev*nσ)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end
# OLD STUFF: the stuff above dispatches on numerical populations  explicitly
# function Base.truncate(pop::AbstractScalarPopulation, constraint::NoConstraint)
#     p.values, p.probs
# end

# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateRange)
#     inds = findall(constraint.min .<= p.values .<= constraint.max)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateMaximum)
#     inds = findall(p.values .<= constraint.max)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateMinimum)
#     inds = findall(constraint.min .<= p.values)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateLowerQuantile)
#     lower_bound = quantile(pop, constraint.lower_quantile)

#     inds = findall(lower_bound .<= p.values)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateUpperQuantile)
#     upper_bound = quantile(pop, constraint.upper_quantile)

#     inds = findall(p.values .<= upper_bound)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateQuantiles)
#     lower_bound = quantile(pop, constraint.lower_quantile)
#     upper_bound = quantile(pop, constraint.upper_quantile)

#     inds = findall(lower_bound .<= p.values .<= upper_bound)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end


# function Base.truncate(pop::AbstractScalarPopulation, constraint::TruncateStd; n::Int = 30000)
#     p_mean = mean(pop, n)
#     p_stdev = std(pop, n)
#     nσ  = constraint.nσ

#     inds = findall(p_mean - p_stdev*nσ .<= p.values .<= p_mean + p_stdev*nσ)

#     if length(inds) == 0 
#         throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
#     end

#     p.values[inds], p.probs[inds]
# end

export truncate