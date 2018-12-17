# Uncertain value representations

Uncertain values may be constructed in three different ways, depending on what
information you have available.

## Kernel density estimates to the observed data
If the data doesn't follow an obvious theoretical distribution, the recommended
course of action is to represent the uncertain value with a kernel density
estimate of the distribution.

The `UncertainValue(empiricaldata::Vector)` constructor returns an uncertain
value represented by a kernel density estimate to the empirical distribution.

``` julia tab="Kernel density estimate of empirical distribution"
using Distributions, UncertainData

# Generate some random data from a normal distribution, so that we get a
# histogram resembling a normal distribution.
some_sample = rand(Normal(), 1000)

# Uncertain value represented by a kernel density estimate
uv = UncertainValue(some_sample)

# The following is equivalent
using KernelDensity # needed to get access to the UnivarateKDE type
uv = UncertainValue(UnivariateKDE, some_sample)
```


## Theoretical distributions with fitted parameters

If your data has a histogram closely resembling some theoretical distribution,
the uncertain value may be represented by fitting such a distribution to the data.

- The `UncertainValue(d::Type{D}, empiricaldata::Vector) where {D <: Distribution}` constructor fits a distribution of type `d` to `empiricaldata`.

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


## Theoretical distributions with known parameters
It is common when working with uncertain data found in the scientific
literature that data value are stated to follow a distribution with given
parameters. For example, a data value may be given as normal distribution with
a given mean `μ = 0` and standard deviation `σ = 0.3`.

```julia
# Uncertain value represented by a theoretical normal distribution with
# known parameters μ = 0 and σ = 0.3
uv = UncertainValue(Normal, 0, 0.3)
```

### Generic two-parameter constructor
The generic two-parameter constructor returns an uncertain value represented
by a distribution of type `d` with parameters `a` and `b` (which, of course,
have different meanings depending on which distribution is provided). Valid
distributions are `Normal`, `Uniform`, `Beta`, `BetaPrime`, `Gamma`, `Frechet`
and `Binomial`.


```julia
UncertainValue(d::Type{D}, a<:Number, b<:Number)
```

For example,

``` julia tab="Example 1"
# Uncertain value represented by a theoretical gamma distribution with
# known parameters α = 2.1 and θ = 3.1
uv = UncertainValue(Gamma, 2.1, 3.1)
```

``` julia tab="Example 2"
# Uncertain value represented by a theoretical binomial distribution with
# known parameters p = 32 and p = 0.13
uv = UncertainValue(Binomial, 32, 0.13)
```

Combined with a valid two-parameter distribution, the `a` and `b` parameter
syntax translates into:

- `UncertainValue(Normal, μ, σ)`
- `UncertainValue(Uniform, lower, upper)`
- `UncertainValue(Beta, α, β)`
- `UncertainValue(BetaPrime, α, β)`
- `UncertainValue(Gamma, α, θ)`
- `UncertainValue(Frechet, α, θ)`
- `UncertainValue(Binomial, n, p)`

### Generic three-parameter constructor

The three-parameter constructor works similarly for three-parameter
distributions:

```
UncertainValue(d::Type{D}, a<:Number, b<:Number, c<:Number)
```

Combined with a valid two-parameter distribution, the
`a`, `b` and `c` parameter syntax translates into:

- `UncertainValue(BetaBinomial, n, α, β)`
