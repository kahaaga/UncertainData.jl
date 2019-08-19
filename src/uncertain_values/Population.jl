
import IntervalArithmetic: interval
import Distributions 
import StatsBase

"""
    AbstractPopulation

An abstract type for population-based uncertain values.
"""
abstract type AbstractPopulation <: AbstractUncertainValue end 

"""
    AbstractScalarPopulation

An abstract type for population-based uncertain scalar values.
"""
abstract type AbstractScalarPopulation <: AbstractPopulation end

Base.length(p::AbstractScalarPopulation) = length(p.values)
Base.getindex(p::AbstractScalarPopulation, i) = p.values[i]

function summarise(p::AbstractScalarPopulation)
    _type = typeof(p)
    l = length(p.values)
    summary = "$_type containing $l values"
    return summary
end

Base.show(io::IO, p::AbstractScalarPopulation) = print(io, summarise(p))


Base.rand(p::AbstractScalarPopulation) = sample(p.values, p.probs)
Base.rand(p::AbstractScalarPopulation, n::Int) = sample(p.values, p.probs, n)


Base.minimum(p::AbstractScalarPopulation) = minimum(p.values)
Base.maximum(p::AbstractScalarPopulation) = maximum(p.values)
Distributions.support(p::AbstractScalarPopulation) = interval(minimum(p), maximum(p))

StatsBase.mean(p::AbstractScalarPopulation, n::Int = 30000) = mean(rand(p, n))
StatsBase.median(p::AbstractScalarPopulation, n::Int = 30000) = median(rand(p, n))
StatsBase.middle(p::AbstractScalarPopulation, n::Int = 30000) = middle(rand(p, n))
StatsBase.quantile(p::AbstractScalarPopulation, q, n::Int = 30000) = quantile(rand(p, n), q)
StatsBase.std(p::AbstractScalarPopulation, n::Int = 30000) = std(rand(p, n))



"""
    UncertainScalarPopulation

An uncertain value represented by a population for which the probabilities of the values 
are dictated by a set of weights. The weights are normalized by default.


## Examples 

The two following ways of constructing populations are equivalent. 

```julia 
values = rand(1:50, 100)
weights = rand(100)
population = UncertainValue(values, weights)
```

```julia 
values = rand(1:50, 100)
weights = rand(100)
population = UncertainScalarPopulation(values, weights)
```

"""
struct UncertainScalarPopulation{T} <: AbstractScalarPopulation
    values::Vector{T}
    probs::StatsBase.Weights
end

"""
    UncertainScalarPopulation(values::Vector{T}, probabilities::Vector{Float64})

Construct a population from a vector of values and a vector of probabilities associated 
to those values. The weights are normalized by default.
"""
function UncertainScalarPopulation(values::Vector{T1}, probabilities::Vector{T2}) where {T1, T2}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end

    UncertainScalarPopulation(values, StatsBase.weights(probabilities))
end



"""
    ConstrainedUncertainScalarPopulation

An constrained uncertain value represented by a population for which the probabilities of 
the values are dictated by a set of weights.

## Examples 

The two following ways of constructing populations are equivalent. 

```julia 
values = rand(1:50, 100)
weights = rand(100)
population = UncertainValue(values, weights)
```

```julia 
values = rand(1:50, 100)
weights = rand(100)
population = UncertainScalarPopulation(values, weights)
```

"""
struct ConstrainedUncertainScalarPopulation{T} <: AbstractScalarPopulation
    values::Vector{T}
    probs::StatsBase.Weights
end

"""
    ConstrainedUncertainScalarPopulation(values::Vector{T}, probabilities::Vector{Float64})

Construct a constrained population from a vector of values and a vector of probabilities 
associated to those values.
"""
function ConstrainedUncertainScalarPopulation(values::Vector{T1}, probabilities::Vector{T2}) where {T1, T2}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end

    ConstrainedUncertainScalarPopulation(values, StatsBase.weights(probabilities))
end

export 
AbstractPopulation,
AbstractScalarPopulation,
UncertainScalarPopulation,
ConstrainedUncertainScalarPopulation