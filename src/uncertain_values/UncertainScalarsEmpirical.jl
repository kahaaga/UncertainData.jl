include("AbstractEmpirical.jl")
include("../distributions/empirical_distribution.jl")


abstract type AbstractEmpiricalScalarValue{S} <: AbstractEmpiricalValue{S} end

"""
    UncertainEmpiricalScalarValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The distribution describing the value.
- **`values`**: The values from which `distribution` is estimated.
"""
struct UncertainScalarEmpiricallyDistributed{S <: ValueSupport} <: AbstractEmpiricalScalarValue{S}
    distribution::Distribution{Univariate, S} # S may be Continuous or Discrete
    values::AbstractVector
end

"""
    UncertainEmpiricalScalarValue(values, d)

Construct an uncertain value from an empirical distribution. The probability
distribution describing the value is estimated by calling
`Distributions.fit_mle(d, values)`.
"""
function UncertainScalarEmpiricallyDistributed(values::AbstractVector{T}, d) where T
    ed = EmpiricalDistribution(values, d)
    UncertainScalarEmpiricallyDistributed(ed.distribution, ed.values)
end

export
UncertainScalarEmpiricallyDistributed
