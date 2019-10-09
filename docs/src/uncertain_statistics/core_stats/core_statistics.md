# Statistics on uncertain values and collections

This package extends many of the statistical algorithms in `StatsBase`
for uncertain values. The statistics are computed using a resampling approach. 

To use these methods, you first have to run the following in your Julia console 
to bring the functions into scope:

```julia
using StatsBase
```

## Exact vs. approximate error propagation

For exact error propagation of normally distributed uncertain values that are 
potentially correlated, you can use
[Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl). It is, however,
not always the case that data points have normally distributed uncertainties. 

This where the resampling approach becomes useful. In this package, the resampling 
approach allows you to *approximate any statistic* for 
[*any type of uncertain value*](@ref uncertain_value_types). You may still use 
normal distributions to represent uncertain values, but the various statistics 
are *approximated through resampling*, rather than computed exactly.

# List of statistics

Some statistics are implemented only for [uncertain values](@ref uncertain_value_types), while
other statistics are implemented only for [collections of uncertain values](@ref uncertain_value_collection_types). Some statistics also work on pairs of of uncertain values, 
or pairs of uncertain value collections. Here's an overview:

- [Uncertain values, on single values](@ref syntax_statistics_uncertainvalue_single)
- [Uncertain values, on pairs of values](@ref syntax_statistics_uncertainvalue_pairs)
- [Uncertain collections, on single collections](@ref syntax_statistics_collection_single)
- [Uncertain collections, on pairs of collections](@ref syntax_statistics_collection_pairs)

# Accepted collection types

In the documentation for the statistical methods, you'll notice that the inputs are supposed to be of type [`UVAL_COLLECTION_TYPES`](@ref). This is a type union representing all types of collections for which the statistical methods are defined. Currently, this includes `UncertainValueDataset`, `UncertainIndexDataset` 
and vectors of uncertain values (`Vector{T} where T <: AbstractUncertainValue`).

```julia
const UVAL_COLLECTION_TYPES = Union{UD, UV} where {
    UD <: AbstractUncertainValueDataset,
    UV <: AbstractVector{T} where {T <: AbstractUncertainValue}}
```
