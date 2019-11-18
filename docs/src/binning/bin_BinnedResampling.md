
# Binning

## [Scalar data](@id bin_scalar_valued_data)

### Get bin values

```@docs
bin(left_bin_edges::AbstractRange, xs, ys)
bin!(bins::Vector{AbstractVector}, left_bin_edges::AbstractRange, xs, ys)
```

### Summarise bins

```@docs
bin(f::Function, left_bin_edges::AbstractRange, xs, ys)
```

## [Uncertain data](@id bin_uncertain_data_BinnedResampling)

### Get bin values

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{RawValues})
```

### Summarise bins

```@docs
bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling)
```
