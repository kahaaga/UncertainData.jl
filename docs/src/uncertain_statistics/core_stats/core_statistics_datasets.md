
# [Statistics on datasets of uncertain values](@id dataset_statistics)

The following statistics are available for collections of uncertain values
(uncertain datasets).

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
