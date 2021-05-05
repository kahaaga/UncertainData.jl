"""
    UncertainIndexDataset(indices)

A dataset containing `indices` that have uncertainties associated with them.

`UncertainIndexDataset`s are meant to contain the indices corresponding to 
an [`UncertainValueDataset`](@ref), and are used for the `indices` field 
in [`UncertainIndexValueDataset`](@ref)s.

## Example

Say we had a dataset of 20 values for which the uncertainties are normally distributed 
with increasing standard deviation through time.

```julia
using UncertainData, Plots
time_inds = 1:13
uvals = [UncertainValue(Normal, ind, rand(Uniform()) + (ind / 6)) for ind in time_inds]
inds = UncertainIndexDataset(uvals)

# With built-in plot recipes, we can plot the dataset, say, using the 
33rd to 67th percentile range for the indices.
plot(inds, [0.33, 0.67])
```
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
    UncertainIndexDataset(CertainScalar.(x))
end

export 
UncertainIndexDataset,
ConstrainedUncertainIndexDataset,
distributions

