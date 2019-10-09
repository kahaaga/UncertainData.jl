# [Statistics on single collections of uncertain data](@id single_dataset_estimate_statistics)

These estimators operate on collections of uncertain values. Each element of such a collection
can be an uncertain value of [any type](@ref uncertain_value_types), such as [populations](@ref uncertain_value_population), 
[theoretical distributions](@ref uncertain_value_theoretical_distribution), 
[KDE distributions](@ref uncertain_value_kde) or 
[fitted distributions](@ref uncertain_value_fitted_theoretical_distribution).

The methods compute the statistic in question by drawing a length-`k` realisation of the `k`-element
collection. Realisations are drawn by sampling each uncertain point in the collection independently. The statistic is then computed on either a single such realisation (yielding a single value for the statistic) or 
over multiple realisations (yielding a distribution of the statistic).

# [Syntax](@id syntax_statistics_collection_single)

The syntax for computing a statistic `f` for single instances of an uncertain value collections is

- `f(x::UVAL_COLLECTION_TYPES)`, which resamples `x` once, assuming no element-wise dependence 
    between the elements of `x`.
- `f(x::UVAL_COLLECTION_TYPES, n::Int, args...; kwargs...)`, which resamples `x` `n` times, 
    assuming no element-wise dependence between the elements of `x`, then computes the statistic 
    on each of those `n` independent draws. Returns a distributions of estimates of the statistic.

# Methods 

## Mean

```@docs
mean(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Mode

```@docs
mode(x::UVAL_COLLECTION_TYPES, n::Int)

```

## Quantile

```@docs
quantile(x::UVAL_COLLECTION_TYPES, q, n::Int)
```

## IQR

```@docs
iqr(uv::UVAL_COLLECTION_TYPES, n::Int)
```

## Median

```@docs
median(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Middle

```@docs
middle(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Standard deviation

```@docs
std(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Variance

```@docs
var(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Generalized/power mean

```@docs
genmean(x::UVAL_COLLECTION_TYPES, p, n::Int)

```

## Generalized variance

```@docs
genvar(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Harmonic mean

```@docs
harmmean(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Geometric mean

```@docs
geomean(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Kurtosis

```@docs
kurtosis(x::UVAL_COLLECTION_TYPES, n::Int; m = mean(x))
```

## k-th order moment

```@docs
moment(x::UVAL_COLLECTION_TYPES, k, n::Int)
```

## Percentile

```@docs
percentile(x::UVAL_COLLECTION_TYPES, p, n::Int)
```

## Renyi entropy

```@docs
renyientropy(x::UVAL_COLLECTION_TYPES, α, n::Int)
```

## Run-length encoding

```@docs
rle(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Standard error of the mean

```@docs
sem(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Skewness

```@docs
skewness(x::UVAL_COLLECTION_TYPES, n::Int; m = mean(x))
```

## Span

```@docs
span(x::UVAL_COLLECTION_TYPES, n::Int)
```

## Summary statistics

```@docs
summarystats(x::UVAL_COLLECTION_TYPES, n::Int)

```

## Total variance

```@docs
totalvar(x::UVAL_COLLECTION_TYPES, n::Int)
```
