# Uncertain statistics

## Core statistics

This package implements most of the statistical algorithms in `StatsBase` for uncertain values and uncertain datasets.

The syntax for calling the algorithms is the same as in `StatsBase`, but
the functions here accept an additional positional argument `n`, which controls
how many times the uncertain values are resampled to compute the statistics.

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
mean(d::UncertainDataset, n::Int)
```

```@docs
median(d::UncertainDataset, n::Int)
```

```@docs
middle(d::UncertainDataset, n::Int)
```

```@docs
std(d::UncertainDataset, n::Int)
```

```@docs
var(d::UncertainDataset, n::Int)
```

```@docs
quantile(d::UncertainDataset, q, n::Int)
```

```@docs
cov(d1::UncertainDataset, d2::UncertainDataset, n::Int)
```

```@docs
cor(d1::UncertainDataset, d2::UncertainDataset, n::Int)
```
