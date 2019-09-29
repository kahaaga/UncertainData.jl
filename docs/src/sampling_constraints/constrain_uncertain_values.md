# Constraining uncertain values

## Documentation

```@docs
constrain(uv::AbstractUncertainValue, constraint::SamplingConstraint)
```

![](constraining_uncertain_values.svg)

## Quick examples

Uncertain values may be constrained in various ways, as visualised by the following example.

Which was generated as follows. Note that the plot recipe normalises the distributions
after constraining the uncertain values.

```julia
uval = UncertainValue(Normal, 2, 5)

p1 = plot(uval, label = "full support", title = "Quantile truncation")
plot!(constrain(uval, TruncateQuantiles(0.2, 0.8)), label = "quantile range truncation")
plot!(constrain(uval, TruncateUpperQuantile(0.9)), label = "upper quantile truncation")
plot!(constrain(uval, TruncateLowerQuantile(0.1)), label = "lower quantile truncation")

p2 = plot(uval, label = "full support", title = "Value truncation")
plot!(constrain(uval, TruncateRange(2, 4)), ls = :dash, label = "range truncation")
plot!(constrain(uval, TruncateMaximum(4.5)), ls = :dash, label = "maximum value truncation")
plot!(constrain(uval, TruncateMinimum(-2)), ls = :dash, label = "minimum value truncation")

plot(p1, p2, layout = (2, 1), link = :x, xlabel = "value", ylabel = "probability")
```

## Constraining theoretical distributions

``` julia tab="Theoretical distribution"
using UncertainData, Distributions

# Define an uncertain value furnished by a theoretical distribution
uv = UncertainValue(Normal, 1, 0.5)

# Constrain the support of the furnishing distribution using various
# constraints
uvc_lq = constrain(uv, TruncateLowerQuantile(0.2))
uvc_uq = constrain(uv, TruncateUpperQuantile(0.8))
uvc_q = constrain(uv, TruncateQuantiles(0.2, 0.8))
uvc_min = constrain(uv, TruncateMinimum(0.5))
uvc_max = constrain(uv, TruncateMaximum(1.5))
uvc_range = constrain(uv, TruncateRange(0.5, 1.5))
```

## Constraining theoretical distributions with fitted parameters

``` julia tab="Theoretical distribution with fitted parameters"
using UncertainData, Distributions

# Define an uncertain value furnished by a theoretical distribution with
# parameters fitted to empirical data
uv = UncertainValue(Normal, rand(Normal(-1, 0.2), 1000))

# Constrain the support of the furnishing distribution using various
# constraints
uvc_lq = constrain(uv, TruncateLowerQuantile(0.2))
uvc_uq = constrain(uv, TruncateUpperQuantile(0.8))
uvc_q = constrain(uv, TruncateQuantiles(0.2, 0.8))
uvc_min = constrain(uv, TruncateMinimum(0.5))
uvc_max = constrain(uv, TruncateMaximum(1.5))
uvc_range = constrain(uv, TruncateRange(0.5, 1.5))
```

## Constraining Kernel density estimated distributions

``` julia tab="Kernel density estimated distribution"
# Define an uncertain value furnished by a kernel density estimate to the
# distribution of the empirical data
uv = UncertainValue(UnivariateKDE, rand(Uniform(10, 15), 1000))

# Constrain the support of the furnishing distribution using various
# constraints
uvc_lq = constrain(uv, TruncateLowerQuantile(0.2))
uvc_uq = constrain(uv, TruncateUpperQuantile(0.8))
uvc_q = constrain(uv, TruncateQuantiles(0.2, 0.8))
uvc_min = constrain(uv, TruncateMinimum(13))
uvc_max = constrain(uv, TruncateMaximum(13))
uvc_range = constrain(uv, TruncateRange(11, 12))
```

## Constraining (nested) weighted populations of uncertain values

Let's define a complicated uncertain value that is defined by a nested weighted population.

```julia
# Some subpopulations consisting of both scalar values and distributions
subpop1_members = [UncertainValue(Normal, 0, 1), UncertainValue(Uniform, -2, 2), -5]
subpop2_members = [UncertainValue(Normal, -2, 1), UncertainValue(Uniform, -6, -1),
                    -3, UncertainValue(Gamma, 1, 0.4)]

# Define the probabilities of sampling the different population members within the 
# subpopulations. Weights are normalised, so we can input any numbers here indicating 
# relative importance
subpop1_probs = [1, 2, 1]
subpop2_probs = [0.1, 0.2, 0.3, 0.1]

pop1 = UncertainValue(subpop1_members, subpop1_probs)
pop2 = UncertainValue(subpop2_members, subpop2_probs)

# Define the probabilities of sampling the two subpopulations in the overall population.
pop_probs = [0.3, 0.7]

# Construct overall population
pop_mixed = UncertainValue([pop1, pop2], pop_probs)
```

Now we can draw samples from this nested population. Sampling directly from the 
entire distribution is done by calling `resample(pop_mixed, n_draws)`. However,
in some cases we might want to constrain the sampling to some minimum, maximum 
or range of values. You can do that by using sampling constraints.

### TruncateMinimum

To truncate the overall population below at some absolute value, use a
[`TruncateMinimum`](@ref) sampling constraint.

```julia
constraint = TruncateMinimum(-1.1)
pop_mixed_constrained = constrain(pop_mixed, constraint);

n_draws = 500
x = resample(pop_mixed, n_draws)
xc = resample(pop_mixed_constrained, n_draws)

p1 = scatter(x, label = "", title = "resampling before constraint")
p2 = scatter(xc, label = "", title = "resampling after constraint")
hline!([constraint.min], label = "TruncateMinimum(-1.1)")
plot(p1, p2, layout = (2, 1), link = :both, ylims = (-3, 3), ms = 1)
xlabel!("Sampling #"); ylabel!("Value")
```

![](figs/constraining_complex_population_truncateminimum.svg)

## TruncateMaximum

To truncate the overall population above at some absolute value, use a
[`TruncateMaximum`](@ref) sampling constraint.

```julia
constraint = TruncateMaximum(1.5)
pop_mixed_constrained = constrain(pop_mixed, constraint);

n_draws = 500
x = resample(pop_mixed, n_draws)
xc = resample(pop_mixed_constrained, n_draws)

p1 = scatter(x, label = "", title = "resampling before constraint")
p2 = scatter(xc, label = "", title = "resampling after constraint")
hline!([constraint.max], label = "TruncateMaximum(1.5)")
plot(p1, p2, layout = (2, 1), link = :both, ylims = (-3, 3), ms = 1)
xlabel!("Sampling #"); ylabel!("Value")
```

![](figs/constraining_complex_population_truncatemaximum.svg)

## TruncateRange

To truncate the overall population above at some range of values, use a
[`TruncateRange`](@ref) sampling constraint.

```julia
constraint = TruncateRange(-1.5, 1.7)
pop_mixed_constrained = constrain(pop_mixed, constraint);

n_draws = 500
x = resample(pop_mixed, n_draws)
xc = resample(pop_mixed_constrained, n_draws)

p1 = scatter(x, label = "", title = "resampling before constraint")
p2 = scatter(xc, label = "", title = "resampling after constraint")
hline!([constraint.min, constraint.max], label = "TruncateRange(-1.5, 1.7)")

plot(p1, p2, layout = (2, 1), link = :both, ylims = (-3, 3), ms = 1)
xlabel!("Sampling #"); ylabel!("Value")
```

![](figs/constraining_complex_population_truncaterange.svg)

## TruncateLowerQuantile

To truncate the overall population below at some quantile of 
the overall population, use a
[`TruncateLowerQuantile`](@ref) sampling constraint.

```julia
constraint = TruncateLowerQuantile(0.2)

# Constrain the population below at the lower 20th percentile
# Resample the entire population (and its subpopulations) according to 
# their probabilities 30000 times to determine the percentile bound.
n_draws = 30000
pop_mixed_constrained = constrain(pop_mixed, constraint, n_draws);

# Calculate quantile using the same number of samples for plotting.
# Will not be exactly the same as the quantile actually used for 
# truncating, except in the limit n -> ∞
q = quantile(resample(pop_mixed, n_draws), constraint.lower_quantile)

n_draws_plot = 3000
x = resample(pop_mixed, n_draws_plot)
xc = resample(pop_mixed_constrained, n_draws_plot)

p1 = scatter(x, label = "", title = "resampling before constraint")
p2 = scatter(xc, label = "", title = "resampling after constraint")
hline!([lq], label = "TruncateLowerQuantile(0.2)")
plot(p1, p2, layout = (2, 1), link = :both, ms = 1, ylims = (-6, 4))
xlabel!("Sampling #"); ylabel!("Value")
```

![](figs/constraining_complex_population_truncatelowerquantile.svg)

## TruncateUpperQuantile

To truncate the overall population below at some quantile of 
the overall population, use a
[`TruncateUpperQuantile`](@ref) sampling constraint.

```julia
constraint = TruncateUpperQuantile(0.8)

# Constrain the population below at the lower 20th percentile
# Resample the entire population (and its subpopulations) according to 
# their probabilities 30000 times to determine the percentile bound.
n_resample_draws = 30000
pop_mixed_constrained = constrain(pop_mixed, constraint, n_resample_draws);

# Calculate quantile using the same number of samples for plotting.
# Will not be exactly the same as the quantile actually used for 
# truncating, except in the limit n_resample_draws -> ∞
q = quantile(resample(pop_mixed, n_resample_draws), constraint.upper_quantile)

n_plot_draws = 3000
x = resample(pop_mixed, n_plot_draws)
xc = resample(pop_mixed_constrained, n_plot_draws)

p1 = scatter(x, label = "", title = "resampling before constraint")
p2 = scatter(xc, label = "", title = "resampling after constraint")
hline!([q], label = "TruncateUpperQuantile(0.8)")
plot(p1, p2, layout = (2, 1), link = :both, ms = 1, ylims = (-6, 4))
xlabel!("Sampling #"); ylabel!("Value")
```

![](figs/constraining_complex_population_truncateupperquantile.svg)

## TruncateQuantiles

To truncate the overall population below at some quantile of 
the overall population, use a
[`TruncateQuantiles`](@ref) sampling constraint.

```julia
constraint = TruncateQuantiles(0.2, 0.8)

# Constrain the population below at the lower 20th percentile
# Resample the entire population (and its subpopulations) according to 
# their probabilities 30000 times to determine the percentile bound.
n_resample_draws = 30000
pop_mixed_constrained = constrain(pop_mixed, constraint, n_resample_draws);

# Calculate quantile using the same number of samples for plotting.
# Will not be exactly the same as the quantile actually used for 
# truncating, except in the limit n_resample_draws -> ∞
s = resample(pop_mixed, n_resample_draws)
qs = quantile(s, [constraint.lower_quantile, constraint.upper_quantile])

n_plot_draws = 3000
x = resample(pop_mixed, n_plot_draws)
xc = resample(pop_mixed_constrained, n_plot_draws)

p1 = scatter(x, label = "", title = "resampling before constraint")
p2 = scatter(xc, label = "", title = "resampling after constraint")
hline!([qs], label = "TruncateQuantiles(0.2, 0.8)")

plot(p1, p2, layout = (2, 1), link = :both, ms = 1, ylims = (-6, 4))
xlabel!("Sampling #"); ylabel!("Value")
```

![](figs/constraining_complex_population_truncatequantiles.svg)
