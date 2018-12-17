# Hypothesis tests
In addition to providing ensemble computation of basic statistic measures, this package also wraps various hypothesis tests from `HypothesisTests.jl`. This allows us to perform hypothesis testing on ensemble realisations of the data.



## Terminology

**Pooled statistics** are computed by sampling all uncertain values comprising the dataset n times, pooling the values together and treating them as one variable, then computing the statistic.

**Element-wise statistics** are computed by sampling each uncertain value n times, keeping the data generated from each uncertain value separate. The statistics are the computed separately for each sample.

## Tests for uncertain values

### One-sample t-test

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

### Exact Kolmogorov-Smirnov test

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

### One-sample Anderson–Darling test

```@docs
OneSampleADTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)
```

### Equal variance t-test


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

### Unequal variance t-test


```@docs
UnequalVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
```

### Jarque-Bera test

```@docs
JarqueBeraTest(d::AbstractUncertainValue, n::Int = 1000)
```

## Tests for uncertain datasets

### One-sample t-test

```@docs
OneSampleTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
OneSampleTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

### Exact one-sample Kolmogorov-Smirnov test

```@docs
ExactOneSampleKSTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
```

### Approximate two-sample Kolmogorov-Smirnov test

```@docs
ApproximateTwoSampleKSTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```

```@docs
ApproximateTwoSampleKSTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```

### Unequal variance t-test

```@docs
UnequalVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
UnequalVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

### Equal variance t-test

```@docs
EqualVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

```@docs
EqualVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)
```

### Wilcoxon rank-sum test


```@docs
MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000)
```

```@docs
MannWhitneyUTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```

```@docs
MannWhitneyUTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)
```


## List of tests

One-sample tests for uncertain values:

- `OneSampleTTest(d::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)`.
- `ExactOneSampleKSTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)`.
- `OneSampleADTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)`.
- `JarqueBeraTest(d::AbstractUncertainValue, n::Int = 1000)`.

Two-sample tests for uncertain values:

- `EqualVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)`.
- `UnequalVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)`.
- `MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue, n::Int = 1000)`.


Pooled two-sample tests for uncertain datasets:

- `OneSampleTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `ApproximateTwoSampleKSTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.
- `UnequalVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `EqualVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `MannWhitneyUTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.

Element-wise two-sample tests for uncertain datasets:

- `OneSampleTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `ExactOneSampleKSTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)`.
- `ApproximateTwoSampleKSTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.
- `UnequalVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `EqualVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; μ0::Real = 0)`.
- `MannWhitneyUTestElementWise(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`.
