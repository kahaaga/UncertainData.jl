# [Kernel density estimates (KDE)](@id uncertain_value_kde)

When your data have an empirical distribution that doesn't follow any obvious
theoretical distribution, the data may be represented by a kernel density
estimate to the underlying distribution.

```@docs
UncertainScalarKDE
```

## Extended example

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
