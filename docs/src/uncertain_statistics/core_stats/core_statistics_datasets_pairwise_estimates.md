# [Pairwise statistics on uncertain data collections](@id single_dataset_estimate_statistics)

These estimators operate on pairs of uncertain value collections. They compute the 
statistic in question by drawing length-`n` draws of both datasets independently,
then computing the statistic `n` times for the `n` pairs of draws. 

Within each collection, point are always sampled independently according to their 
furnishing distributions.

## What is a collection of uncertain data?

This might be either an instance of `UncertainValueDataset`, `UncertainIndexDataset` or 
a vector of uncertain values `Vector{AbstractUncertainValue}`. In the package, the following
type union is used to represent these possibilities:

```julia
const UVAL_COLLECTION_TYPES = Union{UD, UV} where {
    UD <: AbstractUncertainValueDataset,
    UV <: AbstractVector{T} where {
        T <: AbstractUncertainValue}}
```

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
