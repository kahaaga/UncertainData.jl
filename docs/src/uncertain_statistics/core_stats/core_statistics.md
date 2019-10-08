# Statistics on uncertain values and collections

This package extends many of the statistical algorithms in `StatsBase`
for uncertain values. The statistics are computed using a resampling approach.

To enable uncertain statistics, first run the following to bring the functions into scope.

```julia
using StatsBase
```

## List

- [Point-estimates of statistics on single uncertain values](@ref syntax_statistics_uncertainvalue_single)
- [Statistics on pairs of uncertain values](@ref syntax_statistics_uncertainvalue_pairs)
- [Statistics on a single uncertain data collection](@ref syntax_statistics_collection_single)
- [Statistics on pairs of uncertain data collections](@ref syntax_statistics_collection_pairs)

## Collections of uncertain values

In the documentation for the statistical methods, you'll notice that the inputs are supposed to be of type [`UVAL_COLLECTION_TYPES`](@ref). This is a type union representing all types of collections for which the statistical methods are defined. Currently, this includes `UncertainValueDataset`, `UncertainIndexDataset` 
and vectors of uncertain values (`Vector{AbstractUncertainValue}`).

```julia
const UVAL_COLLECTION_TYPES = Union{UD, UV} where {
    UD <: AbstractUncertainValueDataset,
    UV <: AbstractVector{T} where {T <: AbstractUncertainValue}}
```
