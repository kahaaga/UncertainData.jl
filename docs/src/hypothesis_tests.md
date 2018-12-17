# Hypothesis tests
In addition to providing ensemble computation of basic statistic measures, this package also wraps various hypothesis tests from `HypothesisTests.jl`. This allows us to perform hypothesis testing on ensemble realisations of the data.



## Terminology

**Pooled statistics** are computed by sampling all uncertain values comprising the dataset n times, pooling the values together and treating them as one variable, then computing the statistic.

**Element-wise statistics** are computed by sampling each uncertain value n times, keeping the data generated from each uncertain value separate. The statistics are the computed separately for each sample.

## Tests for uncertain values

### One-sample tests

```@docs
OneSampleTTest(d::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

```@docs
ExactOneSampleKSTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)
```

```@docs
OneSampleADTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)
```

```@docs
JarqueBeraTest(d::AbstractUncertainValue, n::Int = 1000)
```

### Two-sample tests

```@docs
EqualVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

```@docs
UnequalVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

```@docs
MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000)
```

## Tests for uncertain datasets

### Two-sample

```@docs
OneSampleTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
ApproximateTwoSampleKSTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```

```@docs
UnequalVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
EqualVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
MannWhitneyUTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```


Element-wise statistics on two datasets (pairwise pooling the uncertain values comprising each dataset):

```@docs
OneSampleTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
ExactOneSampleKSTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
```

```@docs
ApproximateTwoSampleKSTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```

```@docs
UnequalVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
EqualVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
MannWhitneyUTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```


## List of tests

### One-sample tests for uncertain values:

- `OneSampleTTest(d::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)`.
- `ExactOneSampleKSTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)`.
- `OneSampleADTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)`.
- `JarqueBeraTest(d::AbstractUncertainValue, n::Int = 1000)`.

### Two-sample tests for uncertain values

- `EqualVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)`.
- `UnequalVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)`.
- `MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000)`.


### Pooled two-sample tests for uncertain datasets

- `OneSampleTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `ApproximateTwoSampleKSTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.
- `UnequalVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `EqualVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `MannWhitneyUTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.

### Element-wise two-sample tests for uncertain datasets

- `OneSampleTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `ExactOneSampleKSTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)`.
- `ApproximateTwoSampleKSTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.
- `UnequalVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `EqualVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `MannWhitneyUTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.
