# Resampling and binning

## Uncertain values

Uncertain values may be resampled by drawing random number from the distributions
furnishing them. Optionally, sampling constraints can be applied.


```@docs
resample(uv::AbstractUncertainValue)
resample(uv::AbstractUncertainValue, n::Int)
```

## Uncertain datasets

### Binning

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{RawValues})
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{RawValues})
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling)
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling)
```

```@docs
bin(left_bin_edges::AbstractRange, xs, ys)
bin!(bins::Vector{AbstractVector{T}}, ::AbstractRange{T}, xs, ys) where T
bin(f::Function, left_bin_edges::AbstractRange, xs, ys)
bin_mean
```
