# Increasing/decreasing


The following constraints may be used to impose sequential constraints when sampling a 
collection of uncertain values element-wise.

## StrictlyIncreasing

```@docs
StrictlyIncreasing
```

## StrictlyDecreasing

```@docs
StrictlyDecreasing
```

## Existence of sequences

`sequence_exists` will check whether a valid sequence through your collection of 
uncertain values exists, so that you can know beforehand whether a particular 
sequential sampling constraint is possible to apply to your data.

```@docs
sequence_exists
```

