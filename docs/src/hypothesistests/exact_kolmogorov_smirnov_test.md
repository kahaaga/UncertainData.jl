## Regular test

```@docs
ExactOneSampleKSTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)
```

**Example**

We'll test whether the uncertain value `uv = UncertainValue(Gamma, 2, 4)`
comes from the theoretical distribution `Gamma(2, 4)`. Of course, we expect
the test to confirm this, because we're using the exact same distribution.

```julia
uv = UncertainValue(Gamma, 2, 4)

# Perform the Kolgomorov-Smirnov test by drawing 1000 samples from the
# uncertain value.
ExactOneSampleKSTest(uv, Gamma(2, 4), 1000)
```

That gives the following output:

```julia
Exact one sample Kolmogorov-Smirnov test
----------------------------------------
Population details:
    parameter of interest:   Supremum of CDF differences
    value under h_0:         0.0
    point estimate:          0.0228345021301449

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.6655

Details:
    number of observations:   1000
```

As expected, the test can't reject the hypothesis that the uncertain value `uv`
comes from the theoretical distribution `Gamma(2, 4)`, precisely because
it does.


## Pooled test

```@docs
ExactOneSampleKSTestPooled(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
```


## Element-wise test

```@docs
ExactOneSampleKSTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
```
