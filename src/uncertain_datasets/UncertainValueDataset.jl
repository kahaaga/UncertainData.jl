
"""
    UncertainValueDataset

A dataset of uncertain values.

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

export
UncertainValueDataset,
ConstrainedUncertainValueDataset