There are a few built-in functions to check if your dataset allows the application of 
certain [sequential sampling constraints](available_constraints). These functions will check 
whether a valid sequence through your dataset exists, so that you can know beforehand 
whether a particular resampling scheme is possible to apply to your data.

## Strictly increasing sequence 

```@docs
strictly_increasing_sequence_exists
```

## Strictly decreasing sequence 

```@docs
strictly_decreasing_sequence_exists
```