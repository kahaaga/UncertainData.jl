The core concept of `UncertainData` is to replace an uncertain data value with a 
probability distribution describing the point's uncertainty.

There are currently three ways of doing so:

- by [theoretical distributions with known parameters](uncertainvalues_theoreticaldistributions.md)
- by [theoretical distributions with parameters fitted to empirical data](uncertainvalues_fitted.md)
- by [kernel density estimates to empirical data](uncertainvalues_kde.md)
- by [weighted populations](populations.md) where the probability of drawing values are 
    already known, so you can skip kernel density estimation.
- a type representing [values without uncertainty](certainvalue.md), so you can mix 
    uncertain values with certain values

## Some quick examples

See also the [extended examples](uncertainvalues_examples.md)!


### Kernel density estimation (KDE)

If the data doesn't follow an obvious theoretical distribution, the recommended
course of action is to represent the uncertain value with a kernel density
estimate of the distribution.

``` julia tab="Implicit KDE estimate"
using Distributions, UncertainData, KernelDensity

# Generate some random data from a normal distribution, so that we get a
# histogram resembling a normal distribution.
some_sample = rand(Normal(), 1000)

# Uncertain value represented by a kernel density estimate (it is inferred
# that KDE is wanted when no distribution is provided to the constructor).
uv = UncertainValue(some_sample)
```

``` julia tab="Explicit KDE estimate"
using Distributions, UncertainData

# Generate some random data from a normal distribution, so that we get a
# histogram resembling a normal distribution.
some_sample = rand(Normal(), 1000)


# Specify that we want a kernel density estimate representation
uv = UncertainValue(UnivariateKDE, some_sample)
```

### Populations 

If you have a population of values where each value has a probability assigned to it, 
you can construct an uncertain value by providing the values and uncertainties as 
two equal-length vectors to the constructor. Weights are normalized by default.

```julia
vals = rand(100)
weights = rand(100)
p = UncertainValue(vals, weights)
```

### Fitting a theoretical distribution

If your data has a histogram closely resembling some theoretical distribution,
the uncertain value may be represented by fitting such a distribution to the data.

``` julia tab="Example 1: fitting a normal distribution"
using Distributions, UncertainData

# Generate some random data from a normal distribution, so that we get a
# histogram resembling a normal distribution.
some_sample = rand(Normal(), 1000)

# Uncertain value represented by a theoretical normal distribution with
# parameters fitted to the data.
uv = UncertainValue(Normal, some_sample)
```

``` julia tab="Example 2: fitting a gamma distribution"
using Distributions, UncertainData

# Generate some random data from a gamma distribution, so that we get a
# histogram resembling a gamma distribution.
some_sample = rand(Gamma(), 1000)

# Uncertain value represented by a theoretical gamma distribution with
# parameters fitted to the data.
uv = UncertainValue(Gamma, some_sample)
```

### Theoretical distribution with known parameters

It is common when working with uncertain data found in the scientific
literature that data value are stated to follow a distribution with given
parameters. For example, a data value may be given as normal distribution with
a given mean `μ = 2.2` and standard deviation `σ = 0.3`.


``` julia tab="Example 1: theoretical normal distribution"
# Uncertain value represented by a theoretical normal distribution with
# known parameters μ = 2.2 and σ = 0.3
uv = UncertainValue(Normal, 2.2, 0.3)
```

``` julia tab="Example 2: theoretical gamma distribution"
# Uncertain value represented by a theoretical gamma distribution with
# known parameters α = 2.1 and θ = 3.1
uv = UncertainValue(Gamma, 2.1, 3.1)
```

``` julia tab="Example 3: theoretical binomial distribution"
# Uncertain value represented by a theoretical binomial distribution with
# known parameters p = 32 and p = 0.13
uv = UncertainValue(Binomial, 32, 0.13)
```

### Values with no uncertainty 

Scalars with no uncertainty can also be represented. 

```julia 
c1, c2 = UncertainValue(2), UncertainValue(2.2)
```
