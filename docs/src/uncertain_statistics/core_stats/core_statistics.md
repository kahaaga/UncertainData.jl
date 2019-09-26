# Estimate statistics on uncertain values and datasets of uncertain values

This package extends many of the statistical algorithms in `StatsBase` 
for uncertain values. To compute these statistics, a resampling 
approach is used. For more details and lists of the available statistics, see

- [Point-estimates of statistics](@ref point_estimate_statistics)
- [Pairwise estimates of statistics](@ref pairwise_statistics)
- [Dataset statistics](@ref dataset_statistics).

## [Point-estimates of statistics](@id pointwise_statistics)

There are two direct ways of obtaining the value of a statistic `f` for single instances of an uncertain value `uval`:

- `f(uval::AbstractUncertainValue)` return the exact value of the statistic if `uval` is some sort of formal distribution.
- `f(uval::AbstractUncertainValue, n::Int, args...; kwargs...)` estimates the statistic `f` for a length-`n` draw of `uval`.

You can also be explicit about the resampling by calling the relevant `resample` method:

- `resample(f::Function, uval::AbstractUncertainValue, n::Int, args...; kwargs...)` does essentially the same as `f(uval::AbstractUncertainValue, n, args...; kwargs...)`.

## [Pairwise estimates of statistics](@id pairwise_statistics)

Pairwise estimation of a statistic `f` for the uncertain values `x` and `y` can be done by calling:

- `f(x::AbstractUncertainValue, y::AbstractUncertainValue, args..., n::Int; kwargs...)`, which draws independent length-`n` draws of `x` and `y`, then estimates the statistic `f` for those draws. 

You can also be explicit about the resampling by calling the relevant `resample` method:

- `resample(f::Function, x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int, args...; kwargs...)` does essentially the same as `f(f(x::AbstractUncertainValue, y::AbstractUncertainValue, args..., n::Int; kwargs...)`.
