import ..UncertainValues:
    AbstractScalarPopulation,
    UncertainScalarPopulation,
    UncertainValue


import Distributions
UVAL_TYPES = Union{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: Distributions.Distribution}
    

"""
    truncate(population::AbstractScalarPopulation, constraint::NoConstraint)

Get the elements and the associated sampling weights of the `population` members 
satisfying the sampling `constraint`.

- If `constraint` is a `NoConstraint` instance, then all members and weights are 
    returned unmodified.
"""
function Base.truncate(pop::AbstractScalarPopulation, constraint::NoConstraint, n::Int = 30000)
    ConstrainedUncertainScalarPopulation(pop.values, pop.probs)
end

############################################################
# Populations whose members are strictly real-valued scalars
############################################################
function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange, n::Int = 30000) where {T <: Number, PW}
    inds = findall(constraint.min .<= pop.values .<= constraint.max)

    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum, n::Int = 30000) where {T <: Number, PW}
    inds = findall(pop.values .<= constraint.max)

    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum, n::Int = 30000) where {T <: Number, PW}
    inds = findall(constraint.min .<= pop.values)

    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateLowerQuantile, n::Int = 30000) where {T <: Number, PW}
    lower_bound = quantile(pop, constraint.lower_quantile)

    inds = findall(lower_bound .<= pop.values)

    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateUpperQuantile, n::Int = 30000) where {T <: Number, PW}
    upper_bound = quantile(pop, constraint.upper_quantile)

    inds = findall(pop.values .<= upper_bound)

    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateQuantiles, n::Int = 30000) where {T <: Number, PW}
    lower_bound = quantile(pop, constraint.lower_quantile)
    upper_bound = quantile(pop, constraint.upper_quantile)

    inds = findall(lower_bound .<= pop.values .<= upper_bound)

    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateStd, n::Int = 30000) where {T <: Number, PW}
    # Draw a sample of size `n` of the member of `p` according to their weights.
    s = rand(pop, n)
    
    # Compute mean and standard deviation
    p_mean = mean(s)
    p_stdev = std(s)
    nσ  = constraint.nσ
    inds = findall(p_mean - p_stdev*nσ .<= pop.values .<= p_mean + p_stdev*nσ)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end

    ConstrainedUncertainScalarPopulation(pop.values[inds], pop.probs[inds])
end


############################################################
# Populations whose members are some sort of uncertain value
############################################################
TRUNCVAL_TYPES = Union{T1, T2} where {
    T1 <: AbstractUncertainValue, 
    T2 <: Distributions.Distribution}

export TRUNCVAL_TYPES

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum) where {
        T <: AbstractUncertainValue, PW}
    maxs = [maximum(uv) for uv in pop]

    # Find all distributions whose supports start *above or at* the minimum value imposed by the constraint.
    inds = findall(constraint.min .<= maxs)

    if length(inds) == 0 
        throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
    end

    # Constrain those distributions and match them with their respective probabilities
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, length(inds))

    for (i, val) in enumerate(pop[inds])
        truncated_vals[i] = constrain(val, constraint)
    end
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, 0)
    inds = Vector{Int}(undef, 0)

    for (i, val) in enumerate(pop.values)
        if maximum(val) >= constraint.min
            c = constrain(val, constraint)
            
            if !(c isa Nothing)
                push!(inds, i)
                push!(truncated_vals, c)
            end
        end
    end
        
    if length(inds) > 0
        ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
    else 
        nothing
    end
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMinimum, 
        n::Int) where {T <: AbstractUncertainValue, PW}
    Base.truncate(pop, constraint)
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum) where {
        T <: AbstractUncertainValue, PW}

    mins = [minimum(uv) for uv in pop]
    
    # Find all distributions whose supports start *below or at* the maximum value imposed by the constraint.
    inds = findall(mins .<= constraint.max)
    
    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end
    
    # Constrain those distributions and match them with their respective probabilities
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, 0)
    inds = Vector{Int}(undef, 0)

    for (i, val) in enumerate(pop.values)
        if minimum(val) < constraint.max
            c = constrain(val, constraint)
            
            if !(c isa Nothing)
                push!(inds, i)
                push!(truncated_vals, c)
            end
        end
    end
        
    if length(inds) > 0
        return ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
    else 
        return nothing
    end
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateMaximum, 
        n::Int) where {T <: AbstractUncertainValue, PW} 
    Base.truncate(pop, constraint)
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange) where {
        T <: AbstractUncertainValue, PW}
    
    mins = [minimum(uv) for uv in pop]
    maxs = [maximum(uv) for uv in pop]
    
    # Find all distributions whose supports start *above or at* the minimum value imposed by the constraint.
    satisfies_minconstraint = constraint.min .<= maxs
        
    # Find all distributions whose supports start *below or at* the maximum value imposed by the constraint.
    satisfies_maxconstraint = mins .<= constraint.max
    
    # Find all distributions that satisfy both the lower constraint and the upper constraint
    inds = findall(satisfies_minconstraint .& satisfies_maxconstraint)
    
    if length(inds) == 0 
        #throw(ArgumentError("$pop could not be truncated. No values left after truncation."))
        return nothing
    end
    
    # Constrain those distributions and match them with their respective probabilities
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, length(inds))

    for (i, val) in enumerate(pop[inds])
        truncated_vals[i] = constrain(val, constraint)
    end

    ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, constraint::TruncateRange, 
        n::Int) where {T <: AbstractUncertainValue, PW}
    Base.truncate(pop, constraint) 
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
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, 0)
    inds = Vector{Int}(undef, 0)

    for (i, val) in enumerate(pop.values)
        if maximum(val) > population_lower_quantile
            push!(inds, i)
            push!(truncated_vals, truncate(val, TruncateMinimum(population_lower_quantile)))
        end
    end
    
    #println("There were $(length(inds)) population members left after truncation")

    if length(inds) > 0
        return ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
    else 
        return nothing
    end
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, 
        constraint::TruncateUpperQuantile, 
        n::Int = 30000) where {T <: AbstractUncertainValue, PW}
    
    # We want to truncate each of the population members so that their furnishing distributions
    # cannot yield numbers larger than the overall quantile of the population. First 
    # find the overall lower quantile
    population_upper_quantile = quantile(pop, constraint.upper_quantile, n)
    #@show "Overall quantile", population_upper_quantile 

    # Now, truncate each of the population members above at the overall population upper
    # quantile. Probabilities are kept the same. We initialise an empty array, because 
    # some values of the population may be dropped during the truncation process.
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, 0)
    inds = Vector{Int}(undef, 0)

    for (i, val) in enumerate(pop.values)
        if minimum(val) < population_upper_quantile
            push!(inds, i)
            push!(truncated_vals, truncate(val, TruncateMaximum(population_upper_quantile)))
        end
    end
    #println("There were $(length(inds)) population members left after truncation")

    if length(inds) > 0
        return ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
    else 
        return nothing
    end
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
    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, 0)
    inds = Vector{Int}(undef, 0)

    for (i, val) in enumerate(pop.values)
        if maximum(val) > population_lower_quantile && minimum(val) < population_upper_quantile
            push!(inds, i)
            push!(truncated_vals, truncate(val, TruncateRange(population_lower_quantile, population_upper_quantile)))
        end
    end

    if length(inds) > 0
        return ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
    else 
        return nothing
    end
end

function Base.truncate(pop::UncertainScalarPopulation{T, PW}, 
        constraint::TruncateStd{TN}, 
        n::Int = 30000) where {T <: AbstractUncertainValue, PW, TN <: Number}
    
    # We want to truncate each of the population members so that their furnishing distributions
    # cannot yield numbers outside +- constraint.nσ*population_std.
    s = rand(pop, n)
    population_std = std(s)
    population_mean = mean(s)
    
    upper_bound = population_mean + (constraint.nσ*population_std)
    lower_bound = population_mean - (constraint.nσ*population_std)
    

    # Now, truncate each of the population members at the range given by the overall quantiles
    # Probabilities are kept the same.

    truncated_vals = Vector{TRUNCVAL_TYPES}(undef, 0)
    inds = Vector{Int}(undef, 0)

    for (i, val) in enumerate(pop.values)
        if maximum(val) > lower_bound && minimum(val) < upper_bound
            push!(inds, i)
            push!(truncated_vals, truncate(val, TruncateRange(lower_bound, upper_bound)))
        end
    end

    if length(inds) > 0
        return ConstrainedUncertainScalarPopulation(truncated_vals, pop.probs[inds])
    else 
        return nothing
    end

end

export truncate