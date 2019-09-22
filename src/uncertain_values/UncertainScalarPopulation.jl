
import IntervalArithmetic: interval
import Distributions 
import StatsBase

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
struct UncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation
    values::Vector{<:T}
    probs::PW
end

"""
    UncertainScalarPopulation(values::Vector, probabilities::Vector{Float64})

Construct a population from a vector of values and a vector of probabilities associated 
to those values. The weights are normalized by default.
"""
function UncertainScalarPopulation(values::Vector, probabilities::Vector) where {T2}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    UncertainScalarPopulation(UncertainValue.(values), StatsBase.weights(probabilities))
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
struct ConstrainedUncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation
    values::Vector{<:T}
    probs::PW
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

    ConstrainedUncertainScalarPopulation(UncertainValue.(values), StatsBase.weights(probabilities))
end

export 
UncertainScalarPopulation,
ConstrainedUncertainScalarPopulation