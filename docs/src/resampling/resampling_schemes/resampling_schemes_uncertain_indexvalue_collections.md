# [List of resampling schemes and their purpose](@id resampling_schemes_uncertainindexvaluecollections)

For collections of uncertain data, sampling constraints can be represented using the [`ConstrainedIndexValueResampling`](@ref) type. This allows for passing complicated sampling 
constraints as a single input argument to functions that accept uncertain value collections. 
Sequential constraints also make it possible to impose constraints on the indices of 
datasets while sampling.

## Constrained

## Constrained resampling

```@docs
ConstrainedIndexValueResampling
```

## Sequential

### Sequential resampling

```@docs
SequentialResampling
```

### Sequential and interpolated resampling

```@docs
SequentialInterpolatedResampling
```

## Binned resampling

### BinnedResampling

```@docs
BinnedResampling
```

### BinnedWeightedResampling

```@docs
BinnedWeightedResampling
```

### BinnedMeanResampling

```@docs
BinnedMeanResampling
```

### BinnedMeanWeightedResampling

```@docs
BinnedMeanWeightedResampling
```

## Interpolated-and-binned resampling

### InterpolateAndBin

```@docs
InterpolateAndBin
```
