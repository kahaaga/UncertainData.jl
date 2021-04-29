
import IntervalArithmetic: interval
import Distributions 
import StatsBase

const POTENTIAL_UVAL_TYPES = Union{T1, T2} where {T1 <: Number, T2 <: AbstractUncertainValue}

convert_elwise(f::Function, x) = map(f, x);
convert_elwise(f::Function, x::T) where T <: AbstractUncertainValue = x
nested_convert_elwise(f::Function, x) = map(xᵢ -> convert_elwise(f, xᵢ), x)

function verify_pop_and_weights(pop, wts) 
    if length(pop) != length(wts)
        throw(ArgumentError("The number of population members and the number of weights do not match."))
    end
end

"""
    UncertainScalarPopulation(members, probs)
    UncertainScalarPopulation(members, probs::Vector{Number})
    UncertainScalarPopulation(members, probs::Statsbase.AbstractWeights)

An `UncertainScalarPopulation`, which consists of some population `members` 
with associated weights (`probs`) that indicate the relative importance of the 
population members (for example during resampling). 

Members can be either numerical values, any type of uncertain value defined 
in this package (including populations, so nested populations are possible).

## Examples

### Scalar populations

Weighted scalar populations are defined as follows.* Note: Weights must always be provided,
and scalars must be converted to uncertain values before creating the population.*

```julia
using UncertainData
members = UncertainValue.([1.0, 2.0, 3.0]); wts = rand(3)

# Treat elements of `members` as equiprobable  
p = UncertainScalarPopulation(members, [1, 1, 1]) 

# Treat elements of `members` as inequiprobable  
p = UncertainScalarPopulation(members, [2, 3, 1]) 
```

## Populations with mixed-type uncertain values 

Uncertain populations can also consist of a mixture of different types of uncertain values.
Here, we use a population consisting of a scalar, two theoretical distributions
with known parameters, and a theoretical uniform distribution whose parameters 
are estimated from a random sample `s`. We assign equal weights to the member 
of the population.

```julia
s = rand(1000)
members = [
    3.0, 
    UncertainValue(Normal, 0, 1), 
    UncertainValue(Gamma, 2, 3), 
    UncertainValue(Uniform, s)
]
wts = [0.5, 0.5, 0.5, 0.5]
p = UncertainScalarPopulation(members, wts)
```

## Nested populations 

Nested populations are also possible.

```julia
using UncertainData, Distributions 
s = rand(Normal(0.1, 2.0), 8000)
m1 = [UncertainValue(Normal, 0.5, 0.33), UncertainValue(Gamma, 0.6, 0.9)]

# If including scalars, these must be converted to `CertainScalar`s first,
# as follows.
m2 = [2.2, UncertainValue(Normal, s), UncertainValue(s)]

# Give m1 and m2 relative weights 0.1 and 0.5 (these are normalized, so 
# do not need to sum to 1).
p = UncertainScalarPopulation([m1, m2], [0.1, 0.5])
```
"""
struct UncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation{T, PW}
    members::T
    probs::PW

    function UncertainScalarPopulation(members, probs::AbstractVector{T}) where {T <: Number}
        verify_pop_and_weights(members, probs)
        m = nested_convert_elwise(UncertainValue, members); TT = typeof(m)
        wts = Weights(probs); PW = typeof(wts)
        new{TT, PW}(m, wts)
    end

    function UncertainScalarPopulation(members, probs::PW) where {PW <: StatsBase.AbstractWeights}
        verify_pop_and_weights(members, probs)
        m = nested_convert_elwise(UncertainValue, members); TT = typeof(m)
        new{TT, PW}(m, probs)
    end
end

"""
    ConstrainedUncertainScalarPopulation(members, probs)
    ConstrainedUncertainScalarPopulation(members, probs::Vector{Number})
    ConstrainedUncertainScalarPopulation(members, probs::Statsbase.AbstractWeights)

A convenience type to indicate that the population has been 
constrained. It behaves identically to `UncertainScalarPopulation`.
"""
struct ConstrainedUncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation{T, PW}
    members::Vector{T}
    probs::PW
end

function ConstrainedUncertainScalarPopulation(members::Vector{T1}, probabilities::Vector{T2}) where {T1 <: Number, T2 <: Number}
    if length(members) != length(probabilities)
        throw(ArgumentError("Lengths of members and probability vectors do not match."))
    end
    ConstrainedUncertainScalarPopulation(float.(members), StatsBase.weights(probabilities))
end
function ConstrainedUncertainScalarPopulation(members::VT, probabilities) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
    if length(members) != length(probabilities)
        throw(ArgumentError("Lengths of members and probability vectors do not match."))
    end
    ConstrainedUncertainScalarPopulation(UncertainValue.(members), StatsBase.weights(probabilities))
end

export 
UncertainScalarPopulation,
ConstrainedUncertainScalarPopulation