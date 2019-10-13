# List of resampling schemes and their purpose

# Uncertain value collections

For collections of uncertain data, sampling constraints can be represented using the [`ConstrainedValueResampling`](@ref) type. This allows for passing complicated sampling constraints as a single input argument to functions that accept uncertain value collections.

## Constrained resampling

```@docs
ConstrainedValueResampling
```

# Uncertain index-value collections

For uncertain index-value datasets, use the [`ConstrainedIndexValueResampling`](@ref) type.

## Constrained resampling

```@docs
ConstrainedIndexValueResampling
```

## Sequential resampling

```@docs
SequentialResampling
```

## Sequential and interpolated resampling

```@docs
SequentialInterpolatedResampling
```
