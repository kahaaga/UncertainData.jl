
# [Resampling schemes](@id applying_resampling_scheme_uncertain_indexvalue_collections)

For some uncertain collections and datasets, special resampling types are available to make resampling easier.

# Constrained resampling schemes

## Constrained resampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::ConstrainedIndexValueResampling{2, 1})
```

# Sequential resampling schemes

## Sequential

```@docs
resample(::AbstractUncertainIndexValueDataset, ::SequentialResampling)
```

## Sequential and interpolated

```@docs
resample(::AbstractUncertainIndexValueDataset, ::SequentialInterpolatedResampling)
```

# Binned resampling schemes

## BinnedResampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::BinnedResampling)
```

## BinnedMeanResampling

```@docs
resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedMeanResampling)
```

## BinnedWeightedResampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::BinnedWeightedResampling)
```

## BinnedMeanWeightedResampling

```@docs
resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedMeanWeightedResampling)
```

# Interpolated-and-binned resampling

## InterpolateAndBin resampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::InterpolateAndBin{Linear})
```
