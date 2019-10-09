# [Point-estimate statistics](@id point_estimate_statistics)

These estimators operate on single uncertain values, which can be of [any type](@ref uncertain_value_types), such as [populations](@ref uncertain_value_population), 
[theoretical distributions](@ref uncertain_value_theoretical_distribution), 
[KDE distributions](@ref uncertain_value_kde) or 
[fitted distributions](@ref uncertain_value_fitted_theoretical_distribution). They compute the statistic in question by drawing a length-`n` draw of the uncertain value, then computing the statistic on that draw.

# [Syntax](@id syntax_statistics_uncertainvalue_single)

The syntax for computing the statistic `f` for single instances of an uncertain value `x` is

- `f(x::AbstractUncertainValue, n::Int, args...; kwargs...)`, which estimates the statistic `f` for a length-`n` draw of `x`.

# Methods

## Mean

```@docs
mean(x::AbstractUncertainValue, n::Int)
```

## Mode

```@docs
mode(x::AbstractUncertainValue, n::Int)
```

## Quantile

```@docs
quantile(x::AbstractUncertainValue, q, n::Int)
```

## IQR

```@docs
iqr(uv::AbstractUncertainValue, n::Int)
```

## Median

```@docs
median(x::AbstractUncertainValue, n::Int)
```

## Middle

```@docs
middle(x::AbstractUncertainValue, n::Int)
```

## Standard deviation

```@docs
std(x::AbstractUncertainValue, n::Int)
```

## Variance

```@docs
var(x::AbstractUncertainValue, n::Int)
```

## Generalized/power mean

```@docs
genmean(x::AbstractUncertainValue, p, n::Int)
```

## Generalized variance

```@docs
genvar(x::AbstractUncertainValue, n::Int)
```

## Harmonic mean

```@docs
harmmean(x::AbstractUncertainValue, n::Int)
```

## Geometric mean

```@docs
geomean(x::AbstractUncertainValue, n::Int)
```

## Kurtosis

```@docs
kurtosis(x::AbstractUncertainValue, n::Int; m = mean(x))
```

## k-th order moment

```@docs
moment(x::AbstractUncertainValue, k, n::Int, m = mean(x))
```

## Percentile

```@docs
percentile(x::AbstractUncertainValue, p, n::Int)
```

## Renyi entropy

```@docs
renyientropy(x::AbstractUncertainValue, α, n::Int)
```

## Run-length encoding

```@docs
rle(x::AbstractUncertainValue, n::Int)
```

## Standard error of the mean

```@docs
sem(x::AbstractUncertainValue, n::Int)
```

## Skewness

```@docs
skewness(x::AbstractUncertainValue, n::Int; m = mean(x))
```

## Span

```@docs
span(x::AbstractUncertainValue, n::Int)
```

## Summary statistics

```@docs
summarystats(x::AbstractUncertainValue, n::Int)
```

## Total variance

```@docs
totalvar(x::AbstractUncertainValue, n::Int)
```

## Theoretical and fitted distributions

For theoretical distributions, both with known and fitted parameters, some of 
the stats functions may be called without the `n` argument, because the underlying
distributions are represented as actual distributons. For these, we can compute
several of the statistics from the distributions directly.
