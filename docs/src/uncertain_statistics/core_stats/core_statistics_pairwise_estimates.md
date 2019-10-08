# [Pairwise estimates of statistics](@id point_estimate_statistics)

These estimators operate on pairs of uncertain values. They compute the 
statistic in question by drawing independent length-`n` draws of the 
uncertain values, then computing the statistic on those draws.

## [Syntax](@id syntax_statistics_uncertainvalue_pairs)

The syntax for computing the statistic `f` for uncertain values `x` and `y` is:

- `f(x::AbstractUncertainValue, y::AbstractUncertainValue, args..., n::Int; kwargs...)`, which draws independent length-`n` draws of `x` and `y`, then estimates the statistic `f` for those draws.

## Covariance

```@docs
cov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; corrected::Bool = true)
```

## Correlation (Pearson)

```@docs
cor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Correlation (Kendall)

```@docs
corkendall(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Correlation (Spearman)

```@docs
corspearman(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Count non-equal

```@docs
countne(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Count equal

```@docs
counteq(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Maximum absolute deviation

```@docs
maxad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Mean absolute deviation

```@docs
meanad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Mean squared deviation

```@docs
msd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Peak signal-to-noise ratio

```@docs
psnr(x::AbstractUncertainValue, y::AbstractUncertainValue, maxv, n::Int)
```

## Root mean squared deviation

```@docs
rmsd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; normalize = false)
```

## Squared L2 distance

```@docs
sqL2dist(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Cross correlation

```@docs
crosscor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true)
```

## Cross covariance

```@docs
crosscov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true)
```

## Generalized Kullback-Leibler divergence

```@docs
gkldiv(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```

## Kullback-Leibler divergence

```@docs
kldivergence(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```
