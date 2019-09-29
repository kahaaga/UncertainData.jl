# Estimate statistics on uncertain values and datasets of uncertain values

This package extends many of the statistical algorithms in `StatsBase`
for uncertain values. To compute these statistics, a resampling approach is used.

## Enabling uncertain statistics

To enable uncertain statistics, first run the following:

```julia
using StatsBase
```

## List of core statistics

For more details and lists of the available statistics, see

- [Point-estimates of statistics on single uncertain values](@ref point_estimate_statistics)
- [Statistics on pairs of uncertain values](@ref pairwise_statistics)
- [Statistics on a single uncertain data collection](@ref single_dataset_estimate_statistics)
- [Statistics on pairs of uncertain data collections](@ref pairs_dataset_estimate_statistics)

## [Point-estimates of statistics on uncertain values](@id pointwise_statistics)

There are two direct ways of obtaining the value of a statistic `f` for single instances of an uncertain value `uval`:

- `f(uval::AbstractUncertainValue)` return the exact value of the statistic if `uval` is some sort of formal distribution.
- `f(uval::AbstractUncertainValue, n::Int, args...; kwargs...)` estimates the statistic `f` for a length-`n` draw of `uval`.

## [Pairwise estimates of statistics on uncertain values](@id pairwise_statistics)

Pairwise estimation of a statistic `f` for the uncertain values `x` and `y` can be done by calling:

- `f(x::AbstractUncertainValue, y::AbstractUncertainValue, args..., n::Int; kwargs...)`, which draws independent length-`n` draws of `x` and `y`, then estimates the statistic `f` for those draws.

## [Statistics on single uncertain value collections](@id single_statistics_collections)

There are two direct ways of obtaining the value of a statistic `f` for single instances of an uncertain value collection:

- `f(x::UVAL_COLLECTION_TYPES)` resamples `x` once, assuming no element-wise dependence between the elements of `x`.
- `f(x::UVAL_COLLECTION_TYPES, n::Int, args...; kwargs...)` resamples `x` `n` times, assuming no 
    element-wise dependence between the elements of `x`, then computes the statistic on each of those `n` independent draws. Returns a distributions of estimates of the statistic.

Here, `UVAL_COLLECTION_TYPES` is defined as

```julia
const UVAL_COLLECTION_TYPES = Union{UD, UV} where {
    UD <: AbstractUncertainValueDataset, 
    UV <: AbstractVector{T} where {
        T <: AbstractUncertainValue}}
```

## [Statistics on pairs of uncertain value collections](@id pairwise_statistics_collections)

Pairwise estimation of a statistic `f` for the uncertain value collections `x` and `y` can be done by calling:

- `f(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, args..., n::Int; kwargs...)`, which draws independent length-`n` draws of `x` and `y`, then estimates the statistic `f` for those draws.

Here, `UVAL_COLLECTION_TYPES` is defined as

```julia
const UVAL_COLLECTION_TYPES = Union{UD, UV} where {
    UD <: AbstractUncertainValueDataset, 
    UV <: AbstractVector{T} where {
        T <: AbstractUncertainValue}}
```

## Using `resample` directly

If the statistical algorithm is implemented in a way that allows it, you can also be explicit about the resampling by calling the relevant `resample` method:

- `resample(f::Function, x::AbstractUncertainValue, n::Int, args...; kwargs...)` does essentially the same as `f(uval::AbstractUncertainValue, n, args...; kwargs...)`.
- `resample(f::Function, x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int, args...; kwargs...)` does essentially the same as `f(x::AbstractUncertainValue, n, args...; kwargs...)` and `f(x::AbstractUncertainValue, y::AbstractUncertainValue, n, args...; kwargs...)`.

- `resample(f::Function, x::UVAL_COLLECTION_TYPES, y:UVAL_COLLECTION_TYPES, n::Int, args...; kwargs...)` does essentially the same as `f(x:UVAL_COLLECTION_TYPES, y:UVAL_COLLECTION_TYPES, args..., n::Int; kwargs...)`.