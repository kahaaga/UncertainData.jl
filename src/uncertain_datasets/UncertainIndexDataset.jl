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

`UncertainValueDataset`s can also be comprised of uncertain values of different 
types (see also [`UncertainValue`](@ref)).

```julia 
o1 = UncertainValue(Normal, 0, 0.5)
o2 = UncertainValue(Normal, 2.0, 0.1)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(Beta, 4, 5)
o6 = UncertainValue(Gamma, 4, 5)
o7 = UncertainValue(Frechet, 1, 2)
o8 = UncertainValue(BetaPrime, 1, 2)
o9 = UncertainValue(BetaBinomial, 10, 3, 2)
o10 = UncertainValue(Binomial, 10, 0.3)

uvals = [o1, o2, o3, o4, o5, o6, o7, o8, o9, o10]
d = UncertainValueDataset(uvals)

# Plot the 20th to 80th percentile range error bars. 
plot(d, [0.2, 0.8])
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

