# [Point-estimate statistics](@id point_estimate_statistics)

These estimators operate on single uncertain values. They compute the statistic in question by drawing a
length-`n` draw of the uncertain value, then computing the statistic on that draw.

## Statistics by resampling

```@docs
mean(x::AbstractUncertainValue, n::Int)
```

```@docs
mode(x::AbstractUncertainValue, n::Int)
```

```@docs
quantile(x::AbstractUncertainValue, q, n::Int)
```

```@docs
iqr(uv::AbstractUncertainValue, n::Int)
```

```@docs
median(x::AbstractUncertainValue, n::Int)
```

```@docs
middle(x::AbstractUncertainValue, n::Int)
```

```@docs
std(x::AbstractUncertainValue, n::Int)
```

```@docs
var(x::AbstractUncertainValue, n::Int)
```

```@docs
genmean(x::AbstractUncertainValue, p, n::Int)
```

```@docs
genvar(x::AbstractUncertainValue, n::Int)
```

```@docs
harmmean(x::AbstractUncertainValue, n::Int)
```

```@docs
geomean(x::AbstractUncertainValue, n::Int)
```

```@docs
kurtosis(x::AbstractUncertainValue, n::Int; m = mean(x))
```

```@docs
moment(x::AbstractUncertainValue, k, n::Int, m = mean(x))
```

```@docs
percentile(x::AbstractUncertainValue, p, n::Int)
```

```@docs
renyientropy(x::AbstractUncertainValue, α, n::Int)
```

```@docs
rle(x::AbstractUncertainValue, n::Int)
```

```@docs
sem(x::AbstractUncertainValue, n::Int)
```

```@docs
skewness(x::AbstractUncertainValue, n::Int; m = mean(x))
```

```@docs
span(x::AbstractUncertainValue, n::Int)
```

```@docs
summarystats(x::AbstractUncertainValue, n::Int)
```

```@docs
totalvar(x::AbstractUncertainValue, n::Int)
```

## Theoretical and fitted distributions

For theoretical distributions, both with known and fitted parameters, some of 
the stats functions may be called without the `n` argument, because the underlying
distributions are represented as actual distributons. For these, we can compute
several of the statistics from the distributions directly.
