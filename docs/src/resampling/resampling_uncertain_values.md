Uncertain values may be resampled by drawing random number from the distributions
furnishing them.

## Documentation

```@docs 
resample(uv::AbstractUncertainValue)
```

```@docs 
resample(uv::AbstractUncertainValue, n::Int)
```

## Examples

``` julia tab="Resample once"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

resample(uv_theoretical)
resample(uv_theoretical_fitted)
resample(uv_kde)
```

``` julia tab="Resample n times"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

n = 500
resample(uv_theoretical, n)
resample(uv_theoretical_fitted, n)
resample(uv_kde, n)
```

Resampling can also be performed with constraints.

- `resample(uv::AbstractUncertainValue, constraint::SamplingConstraint)`
    samples the uncertain value once, drawing from a restricted
    range of the support of the the probability distribution furnishing it.

- `resample(uv::AbstractUncertainValue, constraint::SamplingConstraint, n::Int)`
    samples the uncertain value `n` times, drawing values from a restricted
    range of the support of the the probability distribution furnishing it.

Available sampling constraints are:
1. `TruncateStd(nσ::Int)`
2. `TruncateMinimum(min::Number)`
3. `TruncateMaximum(max::Number)`
4. `TruncateRange(min::Number, max::Number)`
5. `TruncateLowerQuantile(lower_quantile::Float64)`
6. `TruncateUpperQuantile(upper_quantile::Float64)`
7. `TruncateQuantiles(lower_quantile::Float64, upper_quantile::Float64)`

For full documentation of the constraints, see the 
[available constraints](../sampling_constraints/available_constraints.md) in the menu.


``` julia tab="Lower quantile"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

# Resample the uncertain value with the restriction that the sampled
# values must be higher than the 0.2-th quantile of the distribution
# furnishing the value.
resample(uv_theoretical, TruncateLowerQuantile(0.2))
resample(uv_theoretical_fitted, TruncateLowerQuantile(0.2))
resample(uv_kde, TruncateLowerQuantile(0.2))

n = 100
resample(uv_theoretical, TruncateLowerQuantile(0.2), n)
resample(uv_theoretical_fitted, TruncateLowerQuantile(0.2), n)
resample(uv_kde, TruncateLowerQuantile(0.2))


```

``` julia tab="Upper quantile"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

# Resample the uncertain value  with the restriction that the sampled
# values must be lower than the 0.95-th quantile of the distribution
# furnishing the value.
resample(uv_theoretical, TruncateUpperQuantile(0.95))
resample(uv_theoretical_fitted, TruncateUpperQuantile(0.95))
resample(uv_kde, TruncateUpperQuantile(0.95))

n = 100
resample(uv_theoretical, TruncateUpperQuantile(0.95), n)
resample(uv_theoretical_fitted, TruncateUpperQuantile(0.95), n)
resample(uv_kde, TruncateUpperQuantile(0.95))
```

``` julia tab="Quantile range"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

# Resample the uncertain value with the restriction that the sampled
# values must be within the (0.025, 0.975) quantile range.
resample(uv_theoretical, TruncateQuantiles(0.025, 0.975))
resample(uv_theoretical_fitted, TruncateQuantiles(0.025, 0.975))
resample(uv_kde, TruncateQuantiles(0.025, 0.975))

n = 100
resample(uv_theoretical, TruncateQuantiles(0.025, 0.975), n)
resample(uv_theoretical_fitted, TruncateQuantiles(0.025, 0.975), n)
resample(uv_kde, TruncateQuantiles(0.025, 0.975))
```

``` julia tab="Minimum"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

# Resample the uncertain value with the restriction that the sampled
# values have -2 as a lower bound.
resample(uv_theoretical, TruncateMinimum(-2))
resample(uv_theoretical_fitted, TruncateMinimum(-2))
resample(uv_kde, TruncateMinimum(-2))

n = 100
resample(uv_theoretical, TruncateMinimum(-2), n)
resample(uv_theoretical_fitted, TruncateMinimum(-2), n)
resample(uv_kde, TruncateMinimum(-2))
```

``` julia tab="Maximum"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

# Resample the uncertain value with the restriction that the sampled
# values have 3 as an upper bound.
resample(uv_theoretical, TruncateMaximum(3))
resample(uv_theoretical_fitted, TruncateMaximum(3))
resample(uv_kde, TruncateMaximum(3))

n = 100
resample(uv_theoretical, TruncateMaximum(3), n)
resample(uv_theoretical_fitted, TruncateMaximum(3), n)
resample(uv_kde, TruncateMaximum(3))
```


``` julia tab="Range"
using Distributions, UncertainData

# Generate some uncertain values
uv_theoretical = UncertainValue(Normal, 4, 0.2)
uv_theoretical_fitted = UncertainValue(Normal, rand(Normal(1, 0.2), 1000))
uv_kde = UncertainValue(rand(Gamma(4, 5), 1000))

# Resample the uncertain value with the restriction that the sampled
# values must have values on the interval [-1, 1]. We first sample once,
# then 50 times.
resample(uv_theoretical, TruncateRange(-1, 1))
resample(uv_theoretical_fitted, TruncateRange(-1, 1))
resample(uv_kde, TruncateRange(-1, 1))

n = 100
resample(uv_theoretical, TruncateRange(-1, 1), n)
resample(uv_theoretical_fitted, TruncateRange(-1, 1), n)
resample(uv_kde, TruncateRange(-1, 1))
```
