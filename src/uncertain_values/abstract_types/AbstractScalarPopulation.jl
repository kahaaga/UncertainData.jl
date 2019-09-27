
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

Base.minimum(p::AbstractScalarPopulation) = minimum(minimum(p.values))
Base.maximum(p::AbstractScalarPopulation) = maximum(maximum(p.values))
Distributions.support(p::AbstractScalarPopulation) = interval(minimum(p), maximum(p))

export AbstractScalarPopulation