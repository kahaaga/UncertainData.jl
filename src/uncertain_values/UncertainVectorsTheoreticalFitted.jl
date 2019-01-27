"""
    UncertainEmpiricalVectorValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The distribution describing the value.
- **`values`**: The values from which `distribution` is estimated.
"""
struct UncertainEmpiricalVectorValue{D <: Distribution, T} <: AbstractEmpiricalValue
    distribution::D #
    values::AbstractVector{AbstractVector{T}}
end
