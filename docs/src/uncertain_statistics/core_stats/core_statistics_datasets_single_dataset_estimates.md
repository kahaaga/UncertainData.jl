# [Statistics on single collections of uncertain data](@id single_dataset_estimate_statistics)

These estimators operate on collections of uncertain values. They compute the 
statistic in question by drawing a length-`n` draw of the uncertain value, 
sampling each point in the collection independently, then computing the statistic 
on those `n` draws.

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
