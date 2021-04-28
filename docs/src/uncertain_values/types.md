# Types of uncertain values

## Convenience constructors

The following convenience constructors are used to defined uncertain values.

```@docs
UncertainValue
```

## [Theoretical distributions](@id uncertain_value_theoretical_distribution)

It is common in the scientific literature to encounter uncertain data values
which are reported as following a specific distribution. For example, an author
report the mean and standard deviation of a value stated to follow a
normal distribution. `UncertainData.jl` makes it easy to represent such values!

```@docs
UncertainScalarBetaDistributed
UncertainScalarBetaBinomialDistributed
UncertainScalarBetaPrimeDistributed
UncertainScalarBinomialDistributed
UncertainScalarFrechetDistributed
UncertainScalarGammaDistributed
UncertainScalarNormallyDistributed
UncertainScalarUniformlyDistributed
```

## [Fitted theoretical distributions](@id uncertain_value_fitted_theoretical_distribution)

For data values with histograms close to some known distribution, the user
may choose to represent the data by fitting a theoretical distribution to the
values. This will only work well if the histogram closely resembles a
theoretical distribution.

```@docs
UncertainScalarTheoreticalFit
```

## [Kernel density estimates (KDE)](@id uncertain_value_kde)

When your data have an empirical distribution that doesn't follow any obvious
theoretical distribution, the data may be represented by a kernel density
estimate to the underlying distribution.

```@docs
UncertainScalarKDE
```

### Extended example

Let's create a bimodal distribution, then sample 10000 values from it.

```@example kde1
using UncertainData, Distributions, Plots, StatsPlots
# Draw 1000 points from a three-component mixture model to create a multimodal distribution.
n1 = Normal(-3.0, 1.2)
n2 = Normal(8.0, 1.2)
n3 = Normal(0.0, 2.5)
M = MixtureModel([n1, n2, n3])
s = rand(M, 1000);
histogram(s, nbins = 80)
ylabel!("Frequency"); xlabel!("Value")
savefig("figs/bimodal_empirical.svg") #hide
```

![](figs/bimodal_empirical.svg)

It is not obvious which distribution to fit to such data.
A kernel density estimate, however, will always be a decent representation
of the data, because it doesn't follow a specific distribution and adapts to
the data values.

To create a kernel density estimate, simply call the
`UncertainValue` constructor with a vector containing the sample. This will trigger
kernel density estimation.

```@example kde1
x = UncertainValue(s)
```

The plot below compares the empirical histogram (here represented as a density
plot) with our kernel density estimate.

```@example kde1
x = UncertainValue(s)
density(s, label = "10000 mixture model (M) samples")
density!(rand(x, 50000),
    label = "50000 samples from KDE estimate to M")
xlabel!("data value")
ylabel!("probability density")
savefig("figs/KDEUncertainValue.svg") #hide
```

![](figs/KDEUncertainValue.svg)


## [Populations](@id uncertain_value_population)

The `UncertainScalarPopulation` type allows representation of an uncertain scalar 
represented by a population of values who will be sampled according to a vector of 
explicitly provided probabilities. Think of it as an explicit kernel density estimate. 

```@docs
UncertainScalarPopulation
```

## Certain values

The `CertainScalar` allows representation of values with no uncertainty. It behaves 
just as a scalar, but can be mixed with uncertain values when performing 
[mathematical operations](../mathematics/elementary_operations.md) and 
[resampling](../resampling/resampling_overview.md). 

```@docs
CertainScalar
```

## Compatibility with Measurements.jl

`Measurement` instances from the Measurements.jl package[^1] are in UncertainData.jl represented as normal distributions. If exact error propagation is a requirement and your data is exclusively normally distributed, use Measurements.jl. If your data is not necessarily 
normally distributed and contain errors of different types, and 
a resampling approach to error propagation is desired, use UncertainData.jl. 

See the [`UncertainValue`](@ref) constructor for instructions on how to 
convert `Measurement`s to uncertain values compatible with this package.

[^1]:
    M. Giordano, 2016, "Uncertainty propagation with functionally correlated quantities", arXiv:1610.08716 (Bibcode: 2016arXiv161008716G).
