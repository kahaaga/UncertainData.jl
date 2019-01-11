For data values with histograms close to some known distribution, the user
may choose to represent the data by fitting a theoretical distribution to the
values. This will only work well if the histogram closely resembles a
theoretical distribution.


## Constructor

```@docs
UncertainValue(d::Type{D}, empiricaldata::Vector{T}) where {D<:Distribution, T}
```


## Examples

``` julia tab="Uniform"
using Distributions, UncertainData

# Create a normal distribution
d = Uniform()

# Draw a 1000-point sample from the distribution.
some_sample = rand(d, 1000)

# Define an uncertain value by fitting a uniform distribution to the sample.
uv = UncertainValue(Uniform, some_sample)
```

``` julia tab="Normal"
using Distributions, UncertainData

# Create a normal distribution
d = Normal()

# Draw a 1000-point sample from the distribution.
some_sample = rand(d, 1000)

# Represent the uncertain value by a fitted normal distribution.
uv = UncertainValue(Normal, some_sample)
```

``` julia tab="Gamma"
using Distributions, UncertainData

# Generate 1000 values from a gamma distribution with parameters α = 2.1,
# θ = 5.2.
some_sample = rand(Gamma(2.1, 5.2), 1000)

# Represent the uncertain value by a fitted gamma distribution.
uv = UncertainValue(Gamma, some_sample)
```
In these examples we're trying to fit the same distribution to our sample
as the distribution from which we draw the sample. Thus, we will get good fits.
In real applications, make sure to always visually investigate the histogram
of your data!


### Beware: fitting distributions may lead to nonsensical results!
In a less contrived example, we may try to fit a beta distribution to a sample
generated from a gamma distribution.


``` julia
using Distributions, UncertainData

# Generate 1000 values from a gamma distribution with parameters α = 2.1,
# θ = 5.2.
some_sample = rand(Gamma(2.1, 5.2), 1000)

# Represent the uncertain value by a fitted beta distribution.
uv = UncertainValue(Beta, some_sample)
```

This is obviously not a good idea. Always visualise your distribution before
deciding on which distribution to fit! You won't get any error messages if you
try to fit a distribution that does not match your data.

If the data do not follow an obvious theoretical distribution, it is better to
use kernel density estimation to define the uncertain value.

