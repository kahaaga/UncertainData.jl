include("AbstractEmpirical.jl")
include("distributions/empirical_distribution.jl")

"""
    UncertainEmpiricalVectorValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The distribution describing the value.
- **`values`**: The values from which `distribution` is estimated.
"""
struct UncertainEmpiricalVectorValue{S <: ValueSupport} <: AbstractEmpiricalValue{S}
    distribution::Distribution{Multivariate, S} # S may be Continuous or Discrete
    values::AbstractVector{AbstractVector}
end
