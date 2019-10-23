"""
    UncertainIndexDataset

Generic dataset containing uncertain indices.

## Fields
- **`indices::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainIndexDataset <: AbstractUncertainIndexDataset
    indices::AbstractVector{<:AbstractUncertainValue}
end


"""
    ConstrainedUncertainIndexDataset

Constrained dataset containing uncertain indices.

## Fields
- **`indices::AbstractVector{AbstractUncertainValue}`**: The uncertain indices.
"""
struct ConstrainedUncertainIndexDataset <: AbstractUncertainIndexDataset
    indices::AbstractVector{<:AbstractUncertainValue}
end

function UncertainIndexDataset(x::AbstractArray{T, 1}) where T
    UncertainIndexDataset(CertainValue.(x))
end

export 
UncertainIndexDataset,
ConstrainedUncertainIndexDataset,
distributions

