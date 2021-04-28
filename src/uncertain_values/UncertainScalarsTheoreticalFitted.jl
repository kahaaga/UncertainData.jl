import Distributions
import Statistics

abstract type TheoreticalFittedUncertainScalar <: TheoreticalDistributionScalarValue end

Broadcast.broadcastable(uv::TheoreticalFittedUncertainScalar) = Ref(uv.distribution)

"""
    UncertainScalarTheoreticalFit(  
        d::FittedDistribution{D}, 
        x::AbstractVector{T}) where {D <: Distribution, T}

An uncertain value represented a distribution `d` whose parameters are 
estimated from the empirical sample `x`.

## Examples

Here, we simulate an empirical sample. We then decide to represent the 
sample by a distribution whose parameters are estimated from the sample.

``` julia
using UncertainData, Distributions
# Simulate a 1000-point sample by drawing from a uniform distribution.
d = Uniform(); s = rand(d, 1000)

# Represent `s` by a uniform distribution whose parameters are estimated from `s`
x = UncertainValue(Uniform, s)
```

``` julia
using UncertainData, Distributions
# Simulate a 1000-point sample by drawing from a normal distribution.
s = rand(Normal(), 1000)

# Represent `s` by a normal distribution whose parameters are estimated from `s`
x = UncertainValue(Normal, s)
```

```julia
using UncertainData, Distributions

# Simulate a 1000-point sample by drawing from a gamma distribution 
# with parameters α = 2.1, θ = 5.2.
s = rand(Gamma(2.1, 5.2), 1000)

# Represent `s` by a gamma distribution whose parameters are estimated from `s`
x = UncertainValue(Gamma, some_sample)
```


*Note: these examples are contrived: of course, estimating the parameters 
of a uniform distribution from a sample drawn from a uniform distribution
will yield a good fit. Real samples are usually less straight-forward to 
model using theoretical distributions*.
In real applications, make sure to always visually investigate the histogram
of your data before picking which distribution to fit! Alternatively, 
use kernel density estimation to fit a distribution (i.e. [`UncertainScalarKDE`](@ref)).

### Beware: fitting distributions may lead to nonsensical results!

In a less contrived example, we may try to fit a beta distribution to a sample
generated from a gamma distribution.


```julia
using Distributions, UncertainData

# Generate 1000 values from a gamma distribution with parameters α = 2.1,
# θ = 5.2.
s = rand(Gamma(2.1, 5.2), 1000)

# Represent `s` by a beta distribution whose parameters are estimated from `s`
x = UncertainValue(Beta, some_sample)
```

This is obviously not a good idea. Always visualise your distribution before
deciding on which distribution to fit! You won't get any error messages if you
try to fit a distribution that does not match your data.

If the data do not follow an obvious theoretical distribution, it is better to
use kernel density estimation to define the uncertain value.
"""
struct UncertainScalarTheoreticalFit{D <: Distribution, T} <: TheoreticalFittedUncertainScalar
    distribution::FittedDistribution{D} # S may be Continuous or Discrete
    values::AbstractVector{T}
end

"""
    ConstrainedUncertainScalarTheoreticalFit(
        d::FittedDistribution{D}, 
        x::AbstractVector{T}) where {D <: Distribution, T}

An uncertain value represented a distribution `d` whose parameters are estimated from the empirical sample `x`,
where the distribution `d` has been truncated after it has been estimated.
"""
struct ConstrainedUncertainScalarTheoreticalFit{D <: Distribution, T} <: TheoreticalFittedUncertainScalar
    distribution::FittedDistribution{D} # S may be Continuous or Discrete
    values::AbstractVector{T}
end

""" Truncate a fitted distribution. """
Distributions.truncated(fd::FittedDistribution, lower, upper) =
    Distributions.truncated(fd.distribution, lower, upper)


Base.rand(fd::UncertainScalarTheoreticalFit) = rand(fd.distribution.distribution)
Base.rand(fd::UncertainScalarTheoreticalFit, n::Int) = rand(fd.distribution.distribution, n)

# For the fitted distributions, we need to access the fitted distribution's distribution
Distributions.pdf(fd::UncertainScalarTheoreticalFit, x) = pdf(fd.distribution.distribution, x)
StatsBase.mode(uv::UncertainScalarTheoreticalFit) = mode(uv.distribution.distribution)
Statistics.mean(uv::UncertainScalarTheoreticalFit) = mean(uv.distribution.distribution)
Statistics.median(uv::UncertainScalarTheoreticalFit) = median(uv.distribution.distribution)
Statistics.quantile(uv::UncertainScalarTheoreticalFit, q) = quantile(uv.distribution.distribution, q)
Statistics.std(uv::UncertainScalarTheoreticalFit) = std(uv.distribution.distribution)
Statistics.var(uv::UncertainScalarTheoreticalFit) = var(uv.distribution.distribution)



export
TheoreticalFittedUncertainScalar,
UncertainScalarTheoreticalFit,
ConstrainedUncertainScalarTheoreticalFit
