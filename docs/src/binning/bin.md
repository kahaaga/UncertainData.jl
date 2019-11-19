# Binning scalar values

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

# Binning uncertain data

## Bin values

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{RawValues})
```

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{RawValues})
```

## Bin summaries

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling)
```

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling)
```
