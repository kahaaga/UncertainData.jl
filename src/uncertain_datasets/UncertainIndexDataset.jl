"""
    UncertainIndices

Generic dataset containing uncertain indices.

## Fields
- **`indices::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainIndexDataset <: AbstractUncertainIndexDataset
    indices::AbstractVector{AbstractUncertainValue}
end



"""
    ConstrainedUncertainIndexDataset

Generic constrained dataset containing uncertain values.

## Fields
- **`indices::AbstractVector{AbstractUncertainValue}`**: The uncertain indices.
"""
struct ConstrainedUncertainIndexDataset <: AbstractUncertainIndexDataset
    indices::AbstractVector{AbstractUncertainValue}
end

export 
UncertainIndexDataset,
ConstrainedUncertainIndexDataset,
distributions

