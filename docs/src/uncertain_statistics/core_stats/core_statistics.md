This package implements many of the statistical algorithms in `StatsBase` for uncertain 
values and uncertain datasets.

The syntax for calling the algorithms is the same as in `StatsBase`, but
the functions here accept an additional positional argument `n`. This additional 
argument controls how many times the uncertain values are resampled to compute the 
statistics. For theoretical distributions, both with known and fitted parameters, some of 
the stats functions may be called without the `n` argument.

### Statistics of single uncertain values

```@docs
mean(uv::AbstractUncertainValue, n::Int)
```

```@docs
median(uv::AbstractUncertainValue, n::Int)
```

```@docs
middle(uv::AbstractUncertainValue, n::Int)
```

```@docs
std(uv::AbstractUncertainValue, n::Int)
```

```@docs
var(uv::AbstractUncertainValue, n::Int)
```

```@docs
quantile(uv::AbstractUncertainValue, q, n::Int)
```

### Statistics on datasets of uncertain values

The following statistics are available for uncertain datasets (collections
of uncertain values).

```@docs
mean(d::AbstractUncertainValueDataset, n::Int)
```

```@docs
median(d::AbstractUncertainValueDataset, n::Int)
```

```@docs
middle(d::AbstractUncertainValueDataset, n::Int)
```

```@docs
std(d::AbstractUncertainValueDataset, n::Int)
```

```@docs
var(d::AbstractUncertainValueDataset, n::Int)
```

```@docs
quantile(d::AbstractUncertainValueDataset, q, n::Int)
```

```@docs
cov(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int)
```

```@docs
cor(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int)
```
