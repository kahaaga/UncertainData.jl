## Regular test

```@docs
UnequalVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

## Pooled test

```@docs
UnequalVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

## Element-wise test

```@docs
UnequalVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```
