
# [Resampling with schemes](@id applying_resampling_scheme_uncertain_indexvalue_collections)

For some uncertain collections and datasets, special resampling types are available to make resampling easier.

## Constrained resampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::ConstrainedIndexValueResampling{2, 1})
```

## Sequential resampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::SequentialResampling)
```

## Sequential and interpolated resampling

```@docs
resample(::AbstractUncertainIndexValueDataset, ::SequentialInterpolatedResampling)
```
