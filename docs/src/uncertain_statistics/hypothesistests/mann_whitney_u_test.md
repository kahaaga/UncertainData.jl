
## Regular test

```@docs
MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000)
```

## Pooled test

```@docs
MannWhitneyUTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```

## Element-wise test

```@docs
MannWhitneyUTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```
