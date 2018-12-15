include("AbstractEmpirical.jl")
include("distributions/fitted_distribution.jl")


abstract type AbstractEmpiricalScalarValue <: AbstractUncertainValue end

"""
    UncertainEmpiricalScalarValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The distribution describing the value.
- **`values`**: The values from which `distribution` is estimated.
"""
struct UncertainScalarEmpiricallyDistributed{D <: Distribution, T} <: AbstractEmpiricalScalarValue
    distribution::FittedDistribution{D} # S may be Continuous or Discrete
    values::AbstractVector{T}
end

resample(ue::UncertainScalarEmpiricallyDistributed) = rand(ue.distribution.distribution)
resample(ue::UncertainScalarEmpiricallyDistributed, n::Int) = rand(ue.distribution.distribution, n)


export
UncertainScalarEmpiricallyDistributed,
resample
