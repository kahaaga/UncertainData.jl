
"""
    UncertainValueDataset(values)

A dataset of uncertain values which have no explicit index associated with its uncertain values. Use this type when you want to be explicit 
about the values representing data values, as opposed to [`UncertainIndexDataset`](@ref)s. 


## Fields

- **`values::AbstractVector{<:AbstractUncertainValue}`**: The uncertain values. Each value is
    represented by an `AbstractUncertainValue`.
"""
struct UncertainValueDataset <: AbstractUncertainValueDataset
    values::AbstractVector{<:AbstractUncertainValue}
end

"""
    ConstrainedUncertainValueDataset

Generic constrained dataset containing uncertain values.

## Fields
- **`values::AbstractVector{<:AbstractUncertainValue}`**: The uncertain values.
"""
struct ConstrainedUncertainValueDataset <: AbstractUncertainValueDataset
    values::AbstractVector{<:AbstractUncertainValue}
end

function UncertainValueDataset(x::AbstractArray{T, 1}) where T
    UncertainValueDataset(CertainScalar.(x))
end

export
UncertainValueDataset,
ConstrainedUncertainValueDataset