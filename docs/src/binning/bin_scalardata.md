
# [Binning scalar series](@id bin_scalar_series)

## Bin values

```@docs
bin(left_bin_edges::AbstractRange, xs, ys)
```

```@docs
bin!(bins::Vector{AbstractVector{T}}, ::AbstractRange{T}, xs, ys) where T
```

## Bin summaries

```@docs
bin(f::Function, left_bin_edges::AbstractRange, xs, ys)
```

## Fast bin summaries

```@docs
bin_mean
```
