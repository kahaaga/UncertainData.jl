## Regular test

```@docs
OneSampleTTest(d::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

**Example:**

```julia
# Normally distributed uncertain observation with mean = 2.1
uv = UncertainValue(Normal, 2.1, 0.2)

# Perform a one-sample t-test to test the null hypothesis that
# the sample comes from a distribution with mean μ0
OneSampleTTest(uv, 1000, μ0 = 2.1)
```

Which gives the following output:

```julia
# Which results in
One sample t-test
-----------------
Population details:
    parameter of interest:   Mean
    value under h_0:         2.1
    point estimate:          2.1031909275381566
    95% confidence interval: (2.091, 2.1154)

Test summary:
    outcome with 95% confidence: fail to reject h_0
    two-sided p-value:           0.6089

Details:
    number of observations:   1000
    t-statistic:              0.5117722099885472
    degrees of freedom:       999
    empirical standard error: 0.00623505433839
```

Thus, we cannot reject the null-hypothesis that the sample comes from a distribution
with mean = 2.1. Therefore, we accept the alternative hypothesis that our sample
*does* in fact come from such a distribution. This is of course true, because
we defined the uncertain value as a normal distribution with mean 2.1.


## Pooled test

```@docs
OneSampleTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

## Element-wise test

```@docs
OneSampleTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```
