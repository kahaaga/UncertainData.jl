import KernelDensity.UnivariateKDE
import Distributions.Distribution
import StatsBase: AbstractWeights, Weights
import Distributions

"""
    UncertainValue(x::T) where T <: Real

Create a `CertainValue` instance from a scalar with no uncertainty.
"""
UncertainValue(x::T) where T <: Real = CertainValue(x)

# Identity constructor
UncertainValue(uval::AbstractUncertainValue) = uval

# From Measurements.jl
UncertainValue(m::Measurement{T}) where T = UncertainValue(Normal, m.val, m.err)

"""
    UncertainValue(values::Vector{<:Number}, probs::Vector{<:Number})

From a numeric vector, construct an `UncertainPopulation` whose 
members are scalar values.
"""
function UncertainValue(values::Vector{<:Number}, probs::Vector{<:Number})
    UncertainScalarPopulation(float.(values), probs)
end

"""
    UncertainValue(values::Vector{<:Number}, probs::Vector{<:Number})

From a numeric vector, construct an `UncertainPopulation` whose 
members are scalar values.
"""
function UncertainValue(values::Vector{<:Number}, probs::W) where {W <: AbstractWeights}
    UncertainScalarPopulation(float.(values), probs)
end

"""
    UncertainValue(values::Vector, probs::Union{Vector, AbstractWeights})

Construct a population whose members are given by `values` and whose sampling 
probabilities are given by `probs`. The elements of `values` can be either 
numeric or uncertain values of any type.
"""
function UncertainValue(values::VT, probs) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
    UncertainScalarPopulation(UncertainValue.(values), probs)
end

function UncertainValue(values::VT, probs::Vector{Number}) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
    UncertainScalarPopulation(UncertainValue.(values), probs)
end

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

# For vectors of zero-dimensional arrays. 
UncertainValue(x::Vector{Array{<:Real, 0}}) = UncertainValue([el[] for el in x])


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


"""
    nested_disttype(t::Distributions.Truncated)

Get the type of the untruncated distribution for a potentially nested
truncated distribution.
"""
function untruncated_dist(t::Distributions.Truncated)
    t_untrunc = t
    
    while typeof(t_untrunc) <: Distributions.Truncated
        t_untrunc = t_untrunc.untruncated
    end
    
    return t_untrunc
end

"""
    untruncated_disttype(t::Distributions.Truncated)

Get the type of the untruncated distribution for a potentially nested
truncated distribution.
"""
function untruncated_disttype(t::Distributions.Truncated)
    t_untrunc = t
    
    while typeof(t_untrunc) <: Distributions.Truncated
        t_untrunc = t_untrunc.untruncated
    end
    
    return typeof(t_untrunc)
end

"""
    UncertainValue(t::Distributions.Truncated)

Construct an uncertain value from an instance of a distribution. If a specific
uncertain value type has not been implemented, the number of parameters is 
determined from the distribution and an instance of one of the following types
is returned: 

- `ConstrainedUncertainScalarValueOneParameter`
- `ConstrainedUncertainScalarValueTwoParameter`
- `ConstrainedUncertainScalarValueThreeParameter`

## Examples 

```julia
# Normal distribution truncated to the interval [0.5, 0.7]
t = Truncated(Normal(0, 1), 0.5, 0.7)
UncertainValue(t)

# Gamma distribution truncated to the interval [0.5, 3.5]
t = Truncate(Gamma(4, 5.1), 0.5, 3.5)
UncertainValue(t)

# Binomial distribution truncated to the interval [2, 7]
t = Truncate(Binomial(10, 0.4), 2, 7)
UncertainValue(t)
```
"""
function UncertainValue(t::Distributions.Truncated)
    dist_type = untruncated_disttype(t)
    original_dist = untruncated_dist(t)
    params = fieldnames(dist_type)
    param_values = [getfield(original_dist, p) for p in params]

    n_params = length(params)
    if n_params == 1
        return ConstrainedUncertainScalarValueOneParameter(t, param_values...)
    elseif n_params == 2
        return ConstrainedUncertainScalarValueTwoParameter(t, param_values...)
    elseif n_params == 3
        return ConstrainedUncertainScalarValueThreeParameter(t, param_values...)
    end
end

"""
    UncertainValue(d::Distributions.Distribution)

Construct an uncertain value from an instance of a distribution. If a specific
uncertain value type has not been implemented, the number of parameters is 
determined from the distribution and an instance of one of the following types
is returned: 

- `UncertainScalarTheoreticalOneParameter`
- `UncertainScalarTheoreticalTwoParameter`
- `UncertainScalarTheoreticalThreeParameter`

## Examples 

```julia
UncertainValue(Normal(0, 1))
UncertainValue(Gamma(4, 5.1))
UncertainValue(Binomial, 8, 0.2)
```
"""
function UncertainValue(d::Distributions.Distribution)    
    params = fieldnames(typeof(d))
    n_params = length(params)
    param_values = [getfield(d, p) for p in params]
    
    if d isa Uniform
        UncertainScalarUniformlyDistributed(d, param_values...)
    elseif d isa Binomial
        UncertainScalarBinomialDistributed(d, param_values...)
    elseif d isa Normal
        UncertainScalarNormallyDistributed(d, param_values...)
    elseif d isa Beta
        UncertainScalarBetaDistributed(d, param_values...)
    elseif d isa BetaPrime
        UncertainScalarBetaPrimeDistributed(d, param_values...)
    elseif d isa Gamma
        UncertainScalarGammaDistributed(d, param_values...)
    elseif d isa Frechet
        UncertainScalarFrechetDistributed(d, param_values...)
    # if no specific type is implemented for this distribution, just create 
    # a generic one
    else 
        if n_params == 1
            return UncertainScalarTheoreticalOneParameter(d, param_values...)
        elseif n_params == 2
            return UncertainScalarTheoreticalTwoParameter(d, param_values...)
        elseif n_params == 3
            return UncertainScalarTheoreticalThreeParameter(d, param_values...)
        else
            msg = "uncertain value type for $n_params-parameter $d not implemented."
            throw(DomainError(msg))
        end
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
