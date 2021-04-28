
import IntervalArithmetic: interval
import Distributions 
import StatsBase

const POTENTIAL_UVAL_TYPES = Union{T1, T2} where {T1 <: Number, T2 <: AbstractUncertainValue}


convert_elwise(f::Function, x) = map(f, x);
convert_elwise(f::Function, x::AbstractUncertainValue) = x
nested_convert_elwise(f::Function, x) = map(xᵢ -> convert_elwise(f, xᵢ), x)

function verify_pop_and_weights(pop, wts) 
    if length(pop) != length(wts)
        throw(ArgumentError("The number of population members and the number of weights do not match."))
    end
end

"""
    UncertainScalarPopulation(values, probs)
    UncertainScalarPopulation(values, probs::Vector{Number})
    UncertainScalarPopulation(values, probs::Statsbase.AbstractWeights)

An `UncertainScalarPopulation`, which consists of some population members (`values`)
and some weights (`probs`) that indicate the relative importance of the 
population members (for example during resampling). 

## Fields

- **`values`**: The members of the population. Can be either numerical values, any
    type of uncertain value defined in this package (including populations), and
    `Measurement` instances from Measurements.jl.
- **`probs`**: The probabilities of sampling each member of the population.

## Constructors 

- If `values` contains only scalar numeric values, then the `values` field 
    will be of type `Vector{Number}`.
- If `values` contains one or more uncertain values, then the `values` field 
    will be of type `Vector{AbstractUncertainValue}`

## Examples

### Weighted scalar populations

Weighted scalar populations are defined as follows. Note: Weights must always be provided,
and scalars must be converted to uncertain values before creating the population.

```julia
using UncertainData
pop = UncertainValue.([1.0, 2.0, 3.0]); wts = rand(3)

# Treat elements of `pop` as equiprobable  
p = UncertainScalarPopulation(pop, [1, 1, 1]) 

# Treat elements of `pop` as inequiprobable  
p = UncertainScalarPopulation(pop, [2, 3, 1]) 
```

## Populations with mixed-type uncertain values 

Uncertain population can also consist of a mixture of different types of uncertain values.
Here, we use a population consisting of a scalar, two theoretical distributions
with known parameters, and a theoretical uniform distribution whose parameters 
are estimated from a random sample `s`. We assign equal weights to the member 
of the population.

```julia
s = rand(1000)
pop = [
    3.0, 
    UncertainValue(Normal, 0, 1), 
    UncertainValue(Gamma, 2, 3), 
    UncertainValue(Uniform, s)
]
wts = [0.5, 0.5, 0.5, 0.5]
p = UncertainScalarPopulation(pop, wts)
```

## Nested populations 

Nested populations are also possible.

```
using UncertainData, Distributions 
s = rand(Normal(0.1, 2.0), 8000)
p1 = [UncertainValue(Normal, 0.5, 0.33), UncertainValue(Gamma, 0.6, 0.9)]

# If including scalars, these must be converted to `CertainScalar`s first,
# as follows.
p2 = [UncertainValue(2.2), UncertainValue(Normal, s), UncertainValue(s)]

# Give p1 and p2 relative weights 0.1 and 0.5 (these are normalized, so 
# do not need to sum to 1).
p = UncertainScalarPopulation([p1, p2], [0.1, 0.5])
```
"""
struct UncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation{T, PW}
    values::AbstractVector{T}
    probs::PW

    function UncertainScalarPopulation(pop, probs::AbstractVector{T}) where {T <: Number}
        verify_pop_and_weights(pop, probs)
        @show "here"
        @show pop
        members = nested_convert_elwise(UncertainValue, pop); TT = eltype(members)
        wts = Weights(probs); PW = typeof(wts)
        new{TT, PW}(members, wts)
    end

    function UncertainScalarPopulation(pop, probs::PW) where {PW <: StatsBase.AbstractWeights}
        verify_pop_and_weights(pop, probs)
        @show "here2"
        members = nested_convert_elwise(UncertainValue, pop); TT = eltype(members)
        new{TT, PW}(members, probs)
    end
end


# function UncertainScalarPopulation(values::Vector{T1}, probabilities::Vector{T2}) where {T1 <: Number, T2 <: Number}

#     UncertainScalarPopulation(
#         nested_convert_elwise(UncertainValue, values), # in case scalars are provided
#         StatsBase.weights(probabilities)
#         )
# # end
# function UncertainScalarPopulation(values::VT, probabilities) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}

#     UncertainScalarPopulation(UncertainValue.(values), StatsBase.weights(probabilities))
# end


"""
    ConstrainedUncertainScalarPopulation(values, probs)
    ConstrainedUncertainScalarPopulation(values, probs::Vector{Number})
    ConstrainedUncertainScalarPopulation(values, probs::Statsbase.AbstractWeights)

A `ConstrainedUncertainScalarPopulation`, which consists of some population 
members (`values`)and some weights (`probs`) that indicate the relative importance of 
the population members (for example during resampling). The uncertain values 
for this type is meant to consist of constrained uncertain values 
(generated by calling `constrain(uval, sampling_constraint`) on them.

This is just a convenience type to indicate that the population has been 
constrained. It behaves identically to `UncertainScalarPopulation`.

There are different constructors for different types of `values`:

- If `values` contains only scalar numeric values, then the `values` field 
    will be of type `Vector{Number}`.
- If `values` contains one or more uncertain values, then the `values` field 
    will be of type `Vector{AbstractUncertainValue}`

"""
struct ConstrainedUncertainScalarPopulation{T, PW <: StatsBase.AbstractWeights} <: AbstractScalarPopulation{T, PW}
    values::Vector{T}
    probs::PW
end

"""
    ConstrainedUncertainScalarPopulation(values::Vector, probabilities::Vector{Float64})

Construct a constrained population from a vector of values and a vector of 
probabilities associated to those values.
"""
function ConstrainedUncertainScalarPopulation(values::Vector{T1}, probabilities::Vector{T2}) where {T1 <: Number, T2 <: Number}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    ConstrainedUncertainScalarPopulation(float.(values), StatsBase.weights(probabilities))
end
function ConstrainedUncertainScalarPopulation(values::VT, probabilities) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
    if length(values) != length(probabilities)
        throw(ArgumentError("Lengths of values and probability vectors do not match."))
    end
    ConstrainedUncertainScalarPopulation(UncertainValue.(values), StatsBase.weights(probabilities))
end

export 
UncertainScalarPopulation,
ConstrainedUncertainScalarPopulation