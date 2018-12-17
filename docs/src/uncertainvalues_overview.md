# Uncertain value representations

Uncertain values may be constructed in three different ways, depending on what
information you have available.

## As theoretical distributions with known parameters
This is common when
working with uncertain data found in the scientific literature, where data
values are often stated as following a distribution with given parameters,
for example a normal distribution with a given mean and standard deviation.

The generic two-parameter constructor returns an uncertain value represented
by a distribution of type `d` with parameters `a` and `b` (which, of course,
have different meanings depending on which distribution is provided). Valid
distributions are `Normal`, `Uniform`, `Beta`, `BetaPrime`, `Gamma`, `Frechet`
and `Binomial`.


```julia
UncertainValue(d::Type{D}, a<:Number, b<:Number)
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


The three-parameter constructor works similarly for three-parameter
distributions:

```
UncertainValue(d::Type{D}, a<:Number, b<:Number)
```

Combined with a valid two-parameter distribution, the 
`a`, `b` and `c` parameter syntax translates into:

- `UncertainValue(BetaBinomial, n, α, β)`


## As theoretical distributions with fitted parameters

If your data has a histogram closely resembling some theoretical distribution,
the uncertain value may be represented by fitting such a distribution to the data.

- The `UncertainValue(d::Type{D}, empiricaldata::Vector) where {D <: Distribution}` constructor fits a distribution of type `d` to `empiricaldata`.


## As a kernel density estimate to the observed data
doesn't follow an obvious theoretical distribution, the recommended course of
action is to represent the uncertain value with a kernel density estimate
of the distribution.


- The `UncertainValue(empiricaldata::Vector)` constructor returns an uncertain value represented by a kernel density estimate to the empirical distribution.
