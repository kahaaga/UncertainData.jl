# [Pairwise statistics on uncertain data collections](@id pairs_dataset_estimate_statistics)

These estimators operate on pairs of [uncertain value collections](@ref uncertain_value_collection_types). 
Each element of such a collection can be an uncertain value of [any type](@ref uncertain_value_types), such as [populations](@ref uncertain_value_population), 
[theoretical distributions](@ref uncertain_value_theoretical_distribution), 
[KDE distributions](@ref uncertain_value_kde) or 
[fitted distributions](@ref uncertain_value_fitted_theoretical_distribution).

The methods compute the statistic in question by drawing a length-`k` realisation of each of the `k`-element
collections. Realisations are drawn by sampling each uncertain point in the collections independently. The statistic is then computed on either a single pair of such realisations (yielding a single value for the statistic) or over multiple pairs of realisations (yielding a distribution of the statistic).

Within each collection, point are always sampled independently according to their 
furnishing distributions, unless sampling constraints are provided (not yet implemented).

# [Syntax](@id syntax_statistics_collection_pairs)

The syntax for estimating of a statistic `f` on uncertain value collections `x` and `y` is

- `f(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, args..., n::Int; kwargs...)`, which draws independent length-`n` draws of `x` and `y`, then estimates the statistic `f` for those draws.

# Methods 

## Covariance

```@docs
cov(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; corrected::Bool = true)
```

## Correlation (Pearson)

```@docs
cor(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Correlation (Kendall)

```@docs
corkendall(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Correlation (Spearman)

```@docs
corspearman(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Count non-equal

```@docs
countne(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Count equal

```@docs
counteq(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Maximum absolute deviation

```@docs
maxad(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Mean absolute deviation

```@docs
meanad(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Mean squared deviation

```@docs
msd(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Peak signal-to-noise ratio

```@docs
psnr(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, maxv, n::Int)
```

## Root mean squared deviation

```@docs
rmsd(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; normalize = false)
```

## Squared L2 distance

```@docs
sqL2dist(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Cross correlation

```@docs
crosscor(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; demean = true)
```

## Cross covariance

```@docs
crosscov(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; demean = true)
```

## Generalized Kullback-Leibler divergence

```@docs
gkldiv(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```

## Kullback-Leibler divergence

```@docs
kldivergence(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int)
```
