
import IntervalArithmetic: interval
import Distributions 
import StatsBase

"""
AbstractScalarPopulation

An abstract type for population-based uncertain scalar values.
"""
abstract type AbstractScalarPopulation{T, PW} <: AbstractPopulation end

Base.length(p::AbstractScalarPopulation) = length(p.values)
Base.getindex(p::AbstractScalarPopulation, i) = p.values[i]

Base.firstindex(p::AbstractScalarPopulation) = 1
Base.lastindex(p::AbstractScalarPopulation) = length(p.values)
Base.eachindex(p::AbstractScalarPopulation) = Base.OneTo(lastindex(p))
Base.iterate(p::AbstractScalarPopulation, state = 1) = iterate(p.values, state)

function summarise(p::AbstractScalarPopulation)
    _type = typeof(p)
    l = length(p.values)
    summary = "$_type containing $l values"
    return summary
end

Base.show(io::IO, p::AbstractScalarPopulation) = print(io, summarise(p))

Base.minimum(p::AbstractScalarPopulation) = minimum(p)
Base.maximum(p::AbstractScalarPopulation) = maximum(p)

Base.minimum(pop::AbstractScalarPopulation{T, PW} where {T <: Number, PW}) = 
    minimum(pop.values)

Base.maximum(pop::AbstractScalarPopulation{T, PW} where {T <: Number, PW}) = 
    maximum(pop.values)

Base.minimum(pop::AbstractScalarPopulation{T, PW} where {T <: AbstractUncertainValue, PW}) = 
    minimum([minimum(uv) for uv in pop])

Base.maximum(pop::AbstractScalarPopulation{T, PW} where {T <: AbstractUncertainValue, PW}) = 
    maximum([maximum(uv) for uv in pop])

Distributions.support(p::AbstractScalarPopulation) = interval(minimum(p), maximum(p))

function Base.rand(pop::AbstractScalarPopulation{T, PW}) where {T <: Number, PW}
    StatsBase.sample(pop.values, pop.probs)
end

function Base.rand(pop::AbstractScalarPopulation{T, PW}, n::Int) where {T <: Number, PW}
    StatsBase.sample(pop.values, pop.probs, n)
end

function Base.rand(pop::AbstractScalarPopulation{T, PW}) where {T <: AbstractUncertainValue, PW}
    # Sample one of the populations, then draw a random number from it
    popmember_idx = StatsBase.sample(1:length(pop), pop.probs)
    rand(pop[popmember_idx])
end
function Base.rand(pop::AbstractScalarPopulation{T, PW}, n::Int) where {T <: AbstractUncertainValue, PW}
    n_members = length(pop)
    draws = zeros(Float64, n)
    for i = 1:n
        # Sample one of the populations, then draw a random number from it
        sample_pop_idx = StatsBase.sample(1:n_members, pop.probs)
        draws[i] = rand(pop[sample_pop_idx])
    end
    return draws
end


function Base.rand(pop::AbstractScalarPopulation{T, PW}) where {T <: Any, PW}#{T <: AbstractUncertainValue, PW}
    # Sample one of the populations, then draw a random number from it
    popmember_idx = StatsBase.sample(1:length(pop), pop.probs)
    rand(pop[popmember_idx])
end
function Base.rand(pop::AbstractScalarPopulation{T, PW}, n::Int) where {T <: Any, PW}#{T <: AbstractUncertainValue, PW}
    n_members = length(pop)
    draws = zeros(Float64, n)
    for i = 1:n
        # Sample one of the populations, then draw a random number from it
        sample_pop_idx = StatsBase.sample(1:n_members, pop.probs)
        draws[i] = rand(pop[sample_pop_idx])
    end
    return draws
end

export AbstractScalarPopulation