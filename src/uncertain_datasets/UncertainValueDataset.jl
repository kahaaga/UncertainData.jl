
"""
    UncertainValueDataset(values)

A dataset of uncertain values which have no explicit index associated with its uncertain values. 
Use this type when you want to be explicit about the values representing data values, as 
opposed to [`UncertainIndexDataset`](@ref)s. 

`UncertainValueDataset`s can be comprised of uncertain values of any type compatible with
this package (see also [`UncertainValue`](@ref)).

## Example 

```julia
using UncertainData
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