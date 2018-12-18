## Regular test

```@docs
EqualVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

**Example**

Let's create two uncertain values furnished by distributions of different types.
We'll perform the equal variance t-test to check if there is support for the
null-hypothesis that the distributions furnishing the uncertain values
come from distributions with equal means and variances.

We expect the test to reject this null-hypothesis, because we've created
two very different distributions.

```julia
uv1 = UncertainValue(Normal, 1.2, 0.3)
uv2 = UncertainValue(Gamma, 2, 3)

# EqualVarianceTTest on 1000 draws for each variable
EqualVarianceTTest(uv1, uv2, 1000)
```

The output is:

```julia
Two sample t-test (equal variance)
----------------------------------
Population details:
    parameter of interest:   Mean difference
    value under h_0:         0
    point estimate:          -4.782470406651697
    95% confidence interval: (-5.0428, -4.5222)

Test summary:
    outcome with 95% confidence: reject h_0
    two-sided p-value:           <1e-99

Details:
    number of observations:   [1000,1000]
    t-statistic:              -36.03293014520585
    degrees of freedom:       1998
    empirical standard error: 0.1327249931487462
```

The test rejects the null-hypothesis, so we accept the alternative hypothesis
that the samples come from distributions with different means and variances.


## Pooled test

```@docs
EqualVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

## Element-wise test

```@docs
EqualVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```
