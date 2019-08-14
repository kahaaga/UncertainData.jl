import KernelDensity.UnivariateKDE
import Distributions.Distribution

""" 
    UncertainValue(data::Vector{T}, probabilities::Vector{Real})

Construct an uncertain value represented by a population that will be sampled according to
the provided probabilities.
""" 
UncertainValue(data::Vector{T1}, probabilities::Vector{T2}) where {T1, T2} = 
    UncertainScalarPopulation(data, probabilities)

"""
    UncertainValue(data::Vector{T};
        kernel::Type{D} = Normal,
        npoints::Int=2048) where {D <: Distributions.Distribution, T}

Construct an uncertain value by a kernel density estimate to `data`.

Fast Fourier transforms are used in the kernel density estimation, so the
number of points should be a power of 2 (default = 2048).
"""
function UncertainValue(data::Vector{T};
        kernel::Type{D} = Normal,
        bandwidth = KernelDensity.default_bandwidth(data),
        npoints::Int = 2048) where {D <: Distributions.Distribution, T}

    # Kernel density estimation
    KDE = kde(data, npoints = npoints, kernel = kernel, bandwidth = bandwidth)

    # Get the x value for which the density is estimated.
    xrange = KDE.x

    # Normalise estimated density
    density = KDE.density ./ sum(KDE.density)

    # Create an uncertain value
    UncertainScalarKDE(KDE, data, xrange, Weights(density))
end


"""
    UncertainValue(kerneldensity::Type{K}, data::Vector{T};
        kernel::Type{D} = Normal,
        npoints::Int=2048) where {K <: UnivariateKDE, D <: Distribution, T}

Construct an uncertain value by a kernel density estimate to `data`.

Fast Fourier transforms are used in the kernel density estimation, so the
number of points should be a power of 2 (default = 2048).
"""
function UncertainValue(kerneldensity::Type{K}, data::Vector{T};
        kernel::Type{D} = Normal,
        bandwidth = KernelDensity.default_bandwidth(data)/4,
        npoints::Int = 2048) where {K <: UnivariateKDE, D <: Distribution, T}

    # Kernel density estimation
    KDE = kde(data, npoints = npoints, kernel = kernel, bandwidth = bandwidth)

    # Get the x value for which the density is estimated.
    xrange = KDE.x

    # Normalise estimated density
    density = KDE.density ./ sum(KDE.density)

    # Create an uncertain value
    UncertainScalarKDE(KDE, data, xrange, Weights(density))
end


"""
    UncertainValue(empiricaldata::AbstractVector{T},
        d::Type{D}) where {D <: Distribution}

# Constructor for empirical distributions.

Fit a distribution of type `d` to the data and use that as the
representation of the empirical distribution. Calls `Distributions.fit` behind
the scenes.

## Arguments
- **`empiricaldata`**: The data for which to fit the `distribution`.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

"""
function UncertainValue(d::Type{D},
        empiricaldata::Vector{T}) where {D<:Distribution, T}

    distribution = FittedDistribution(Distributions.fit(d, empiricaldata))
    UncertainScalarTheoreticalFit(distribution, empiricaldata)
end


"""

    UncertainValue(distribution::Type{D}, a::T1, b::T2;
        kwargs...) where {T1<:Number, T2 <: Number, D<:Distribution}

# Constructor for two-parameter distributions

`UncertainValue`s are currently implemented for the following two-parameter
distributions: `Uniform`, `Normal`, `Binomial`, `Beta`, `BetaPrime`, `Gamma`,
and `Frechet`.

### Arguments

- **`a`, `b`**: Generic parameters whose meaning varies depending
    on what `distribution` is provided. See the list below.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

Precisely what  `a` and `b` are depends on which distribution is provided.

- `UncertainValue(Normal, μ, σ)` returns an `UncertainScalarNormallyDistributed` instance.
- `UncertainValue(Uniform, lower, upper)` returns an `UncertainScalarUniformlyDistributed` instance.
- `UncertainValue(Beta, α, β)` returns an `UncertainScalarBetaDistributed` instance.
- `UncertainValue(BetaPrime, α, β)` returns an `UncertainScalarBetaPrimeDistributed` instance.
- `UncertainValue(Gamma, α, θ)` returns an `UncertainScalarGammaDistributed` instance.
- `UncertainValue(Frechet, α, θ)` returns an `UncertainScalarFrechetDistributed` instance.
- `UncertainValue(Binomial, n, p)` returns an `UncertainScalarBinomialDistributed` instance.

### Keyword arguments

- **`nσ`**: If `distribution <: Distributions.Normal`, then how many standard
    deviations away from `μ` does `lower` and `upper` (i.e. both, because
    they are the same distance away from `μ`) represent?
- **`tolerance`**: A threshold determining how symmetric the uncertainties
    must be in order to allow the construction of  Normal distribution
    (`upper - lower > threshold` is required).
- **`trunc_lower`**: Lower truncation bound for distributions with infinite
    support. Defaults to `-Inf`.
- **`trunc_upper`**: Upper truncation bound for distributions with infinite
    support. Defaults to `Inf`.

## Examples

### Normal distribution

Normal distributions are formed by using the constructor
`UncertainValue(μ, σ, Normal; kwargs...)`. This gives a normal distribution with
mean μ and standard deviation σ/nσ (nσ must be given as a keyword argument).

```julia
# A normal distribution with mean = 2.3 and standard deviation 0.3.
UncertainValue(2.3, 0.3, Normal)

# A normal distribution with mean 2.3 and standard deviation 0.3/2.
UncertainValue(2.3, 0.3, Normal, nσ = 2)

# A normal distribution with mean 2.3 and standard deviation = 0.3,
truncated to the interval `[1, 3]`.
UncertainValue(2.3, 0.3, Normal, trunc_lower = 1.0, trunc_upper = 3.0)
```

### Uniform distribution

Uniform distributions are formed using the
`UncertainValue(lower, upper, Uniform)` constructor.

```julia
#  A uniform distribution on `[2, 3]`
UncertainValue(-2, 3, Uniform)
```

"""
function UncertainValue(distribution::Type{D}, a::T1, b::T2;
        kwargs...) where {T1<:Number, T2 <: Number, D<:Distribution}

    if distribution == Uniform
        dist = assigndist_uniform(a, b)
        UncertainScalarUniformlyDistributed(dist, a, b)
    elseif distribution == Binomial
        dist = assigndist_binomial(a, b)
        UncertainScalarBinomialDistributed(dist, a, b)
    elseif distribution == Normal
        dist = assigndist_normal(a, b; kwargs...)
        UncertainScalarNormallyDistributed(dist, a, b)
    elseif distribution == Beta
        dist = assigndist_beta(a, b; kwargs...)
        UncertainScalarBetaDistributed(dist, a, b)
    elseif distribution == BetaPrime
        dist = assigndist_betaprime(a, b; kwargs...)
        UncertainScalarBetaPrimeDistributed(dist, a, b)
    elseif distribution == Gamma
        if !((a > 0) & (b > 0))
            error("α and θ must both be > 0")
        end
        dist = assigndist_gamma(a, b; kwargs...)
        UncertainScalarGammaDistributed(dist, a, b)
    elseif distribution == Frechet
        dist = assigndist_frechet(a, b; kwargs...)
        UncertainScalarFrechetDistributed(dist, a, b)
    else
        throw(DomainError("Two-parameter $dist is not implemented."))
    end
end


"""
    UncertainValue(distribution::Type{D}, a::T1, b::T2, c::T3;
        kwargs...) where {T1<:Number, T2<:Number, T3<:Number, D<:Distribution}

## Constructor for three-parameter distributions

Currently implemented distributions are `BetaBinomial`.

### Arguments
- **`a`, `b`, `c`**: Generic parameters whose meaning varies depending
    on what `distribution` is provided. See the list below.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

Precisely what `a`, `b` and `c` are depends on which distribution is provided.

- `UncertainValue(BetaBinomial, n, α, β)` returns an `UncertainScalarBetaBinomialDistributed` instance.


### Keyword arguments
- **`nσ`**: If `distribution <: Distributions.Normal`, then how many standard
    deviations away from `μ` does `lower` and `upper` (i.e. both, because
    they are the same distance away from `μ`) represent?
- **`tolerance`**: A threshold determining how symmetric the uncertainties
    must be in order to allow the construction of  Normal distribution
    (`upper - lower > threshold` is required).
- **`trunc_lower`**: Lower truncation bound for distributions with infinite
    support. Defaults to `-Inf`.
- **`trunc_upper`**: Upper truncation bound for distributions with infinite
    support. Defaults to `Inf`.

## Examples
### BetaBinomial distribution

Normal distributions are formed by using the constructor
`UncertainValue(μ, σ, Normal; kwargs...)`. This gives a normal distribution with
mean μ and standard deviation σ/nσ (nσ must be given as a keyword argument).

```julia
# A beta binomial distribution with n = 100 trials and parameters α = 2.3 and
# β = 5
UncertainValue(100, 2.3, 5, BetaBinomial)
```
"""
function UncertainValue(distribution::Type{D}, a::T1, b::T2, c::T3;
        kwargs...) where {T1<:Number, T2<:Number, T3<:Number, D<:Distribution}

    if distribution == BetaBinomial
        dist = assigndist_betabinomial(a, b, c; kwargs...)
        UncertainScalarBetaBinomialDistributed(dist, a, b, c)
    else
        throw(DomainError("Three-parameter $dist is not implemented."))
    end
end

##############################
# Macro constructors
##############################
# macro uncertainvalue(μ, lower, upper, d,
#         nσ = 2, trunc_lower = -Inf, trunc_upper = Inf, tolerance = 1e-3)
#     return :(UncertainValue($μ, $lower, $upper, $d,
#                 nσ = $nσ,
#                 trunc_lower = $trunc_lower,
#                 trunc_upper = $trunc_upper,
#                 tolerance = $tolerance))
# end
#
#macro uncertainvalue(empiricaldata, dist)
#    return :(UncertainValue($empiricaldata, $dist))
#end
#
# """
# A macro for the construction of uncertain values. Calls
#     [`UncertainValue`](@ref) with the provided arguments.
#
# - **`@uncertainvalue(μ, lower, upper, dist, kwargs...)`**:
#     Fit a distribution of type `dist` to `μ` and `lower`/`upper` uncertainty
#     bounds.
# - **`@uncertainvalue(empiricaldata, dist)`**:
#     Fit a distribution of type `dist` to a vector of empirical data.
# """
#:(@uncertainvalue)
#
#
# """
#     @evalue(values, d)
#
# Construct an uncertain value from an empirical distribution.
# """
#macro uncertain(values::AbstractVector, d)
#    :(UncertainScalarTheoreticalFit($values, $d))
#end
#uncertain, @uncertain



export
UncertainValue
#uncertainvalue,
#@uncertainvalue
