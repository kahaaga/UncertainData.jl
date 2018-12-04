include("AbstractEmpiricalValue.jl")
include("../distributions/empirical_distribution.jl")

"""
    UncertainEmpiricalScalarValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The distribution describing the value.
- **`values`**: The values from which `distribution` is estimated.
"""
struct UncertainEmpiricalScalarValue{S <: ValueSupport} <: AbstractEmpiricalValue{S}
    distribution::Distribution{Univariate, S} # S may be Continuous or Discrete
    values::AbstractVector
end

"""
    UncertainEmpiricalScalarValue(values, d)

Construct an uncertain value from an empirical distribution. The probability
distribution describing the value is estimated by calling
`Distributions.fit_mle(d, values)`.
"""
function UncertainEmpiricalScalarValue(values::AbstractVector{T}, d) where T
    ed = EmpiricalDistribution(values, d)
    UncertainEmpiricalScalarValue(ed.distribution, ed.values)
end

function UncertainEmpiricalValue(values::AbstractVector{T}, d) where T
    UncertainEmpiricalScalarValue(values, d)
end

"""
    @evalue(values, d)

Construct an uncertain value from an empirical distribution.
"""
macro empiricalvalue(values::AbstractVector, d)
    :(UncertainEmpiricalScalarValue($values, $d))
end


export
UncertainEmpiricalScalarValue,
UncertainEmpiricalValue,
empiricalvalue, @empiricalvalue
