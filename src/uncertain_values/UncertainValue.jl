import KernelDensity.UnivariateKDE
import Distributions.Distribution
import StatsBase: AbstractWeights, Weights
import Distributions


"""
    UncertainValue(d::Distribution)
    UncertainValue(d::Type{Normal}, μ, σ) → UncertainScalarNormallyDistributed
    UncertainValue(d::Type{Uniform}, lower, upper) → UncertainScalarUniformlyDistributed
    UncertainValue(d::Type{Beta}, α, β) → UncertainScalarBetaDistributed
    UncertainValue(d::Type{BetaPrime}, α, β) → UncertainScalarBetaPrimeDistributed
    UncertainValue(d::Type{Gamma}, α, θ) → UncertainScalarGammaDistributed
    UncertainValue(d::Type{Frechet}, α, θ) → UncertainScalarFrechetDistributed
    UncertainValue(d::Type{Binomial, n, p) → UncertainScalarBinomialDistributed
    UncertainValue(d::Type{BetaBinomial, n, α, β) → UncertainScalarBetaBinomialDistributed

Construct an uncertain value represented by a (possibly truncated) 
theoretical distribution `d`.

    UncertainValue(d::Type{<:Distribution}, x::AbstractVector) → UncertainScalarTheoreticalFit

Construct an uncertain value by fitting a distribution of type `d` to an empirical sample 
`x`, and use that fitted distribution as the representation of `x`. 

See also: [`UncertainScalarTheoreticalFit`](@ref)

    UncertainValue(x::AbstractVector; 
        kernel::Type{<:Distribution} = Normal, npoints::Int = 2048) → UncertainScalarKDE

Construct an uncertain value by estimating the underlying distribution to 
the empirical sample `x` using the kernel density estimation (KDE), then using the resulting 
KDE-distribution as the representation of `x`. Fast Fourier transforms are used in the kernel density 
estimation, so the number of points should be a power of 2 (default = 2048).

See also: [`UncertainScalarKDE`](@ref)

    UncertainValue(pop::Vector, probs::Union{Vector, AbstractWeights}) → UncertainScalarPopulation

Construct an uncertain value from a population `pop`, whose sampling 
probabilities (prior beliefs) are `probs`. The population `pop` can contain any 
type of uncertain value. Scalars in `pop` are converted to [`CertainScalar`](@ref)s.

See also: [`UncertainScalarPopulation`](@ref)

    UncertainValue(x::T) where {T <: Real} → CertainScalar

Create a `CertainScalar` instance from a scalar with no uncertainty. 

See also: [`CertainScalar`](@ref)

    UncertainValue(m::Measurement) → UncertainScalarNormallyDistributed

Convert a `Measurement` instance to an uncertain value compatible with UncertainData.jl.

`Measurement` instances from [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl)[^1] are 
treated as normal distributions with known means. Once the conversion is done, the
functionality provided by Measurements.jl, such as exact error propagation, is lost.

# Examples

## Theoretical distributions with known parameters

Measurements are often given as a mean and an associated standard deviation. 
Such measurements can be directly represented by the parameters of the distribution.

Assume a data point has a normally distributed uncertainty, with a mean value of 2.2 
and standard deviation of 4.0. We use the following notation to represent that value.

```julia
using UncertainData, Distributions
UncertainValue(Normal(2.2, 4.0))
UncertainValue(Normal, 2.2, 4.0) # alternative constructor
```

Other distributions, as well as truncated distributions, also work. 

```julia
using UncertainData
UncertainValue(Uniform, -5.0, 5.0)
UncertainValue(Gamma, 3.0, 1.2)

lo, hi = 0.5, 3.5 # truncation limits
UncertainValue(Truncated(Gamma(4, 5.1), lo, hi))
```

## Theoretical distributions with parameters estimated from empirical data

In some cases, it might be convenient to represent an empirical sample by a 
porobability distribution whose parameters are estimated from the sample. 
Here, we simulate a real dataset by generating a small sample from a 
normal distribution, then fit a normal distribution to it.

```julia
using UncertainData, Distributions
s = rand(Normal(0, 1), 100)

# Represent the sample `s` by a normal distribution with estimated parameters
x = UncertainValue(Normal, s)
```

## Distributions estimated using the kernel density approach

For empirical data with non-trivial underlying distributions, one may use 
kernel density estimation to fit a distribution to the empirical sample.

Below, we simulate a multimodal empirial sample, and represent that 
sample by a kernel density estimated distribution.

```julia
using UncertainData, Distributions
M = MixtureModel(Normal[
          Normal(-2.0, 1.2),
          Normal(0.0, 1.0),
          Normal(3.0, 2.5)], [0.2, 0.5, 0.3])
# This is our sample
s = rand(M, 40000)

# `x` is now a kernel density estimated distribution that represents the sample `s`
x = UncertainValue(s) # or UncertainValue(UnivariateKDE, s) to be explicit
```

## Populations (discrete sets of values with associated weights)

Sometimes, numerous measurements of the same phenomenon might be available. In such cases, 
a population may be used to simultaneously represent all data available. Weights 
representing prior beliefs can be added (set weights equal if all points are 
equiprobable).

Below, we assume `x1` and `x2` were measured with sophisticated devices, giving 
both a mean and standard deviation. `x3`, on the other hand, was measured with a 
primitive device, giving only a mean value. Hence our trust in `x3` is lower than 
for `x1` and `x2`. The following 

```julia
x1 = UncertainValue(Normal, 0.1, 0.5)
x2 = UncertainValue(Gamma, 1.2, 3.1)
x3 = UncertainValue(0.1)
pop = [x1, x2, x3] # the population
wts = [0.45, 0.45, 0.1] # weights; `x1` and `x2` are equiprobable, and more probable than `x3`.
UncertainValue(pop, wts)
```

## Values without uncertainties

Numerical values without associated uncertainties must be converted before mixing with 
uncertain values.

```julia
x = UncertainValue(2.0)
```

## Compatibility with Measurements.jl 

`Measurement`s from Measurements.jl are assumed to be normally distributed and errors 
are propagated using linear error propagation theory. In this package, resampling 
is used to propagate errors. Thus, `Measurement`s must be converted to normal distributions 
to be used in conjuction with other uncertain values in this package. 

```julia
using UncertainData, Measurements
m = measurement(value, uncertainty)
x = UncertainValue(m) # now compatible with UncertainData.jl, but drops support for exact error propagation
```

"""
function UncertainValue end

UncertainValue(x::T) where T <: Real = CertainScalar(x)

# Identity constructor
UncertainValue(uval::AbstractUncertainValue) = uval

# From Measurements.jl
UncertainValue(m::Measurement{T}) where T = UncertainValue(Normal, m.val, m.err)

# Populations
UncertainValue(
    pop::AbstractVector, 
    probs::Union{AbstractVector{<:Number}, <:StatsBase.AbstractWeights}) =
    UncertainScalarPopulation(pop, probs)

# function UncertainValue(values::Vector{<:Number}, probs::Vector{<:Number})
#     UncertainScalarPopulation(float.(values), probs)
# end

# function UncertainValue(values::Vector{<:Number}, probs::W) where {W <: AbstractWeights}
#     UncertainScalarPopulation(float.(values), probs)
# end

# function UncertainValue(values::VT, probs) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
#     UncertainScalarPopulation(UncertainValue.(values), probs)
# end

# function UncertainValue(values::VT, probs::Vector{Number}) where VT <: Vector{ELTYPE} where {ELTYPE<:POTENTIAL_UVAL_TYPES}
#     UncertainScalarPopulation(UncertainValue.(values), probs)
# end

#KDE
function UncertainValue(data::AbstractVector{T};
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


# Fitted distributions
# TODO: make TheoreticalFittedUncertainScalar parametric on the input distribution
function UncertainValue(d::Type{<:Distribution}, data::AbstractVector)

    distribution = FittedDistribution(Distributions.fit(d, data))
    UncertainScalarTheoreticalFit(distribution, data)
end


# """

#     UncertainValue(distribution::Type{D}, a::T1, b::T2;
#         kwargs...) where {T1 <: Number, T2 <: Number, D <: Distribution} → TheoreticalDistributionScalarValue

# # Constructor for two-parameter distributions

# `UncertainValue`s are currently implemented for the following two-parameter
# distributions: `Uniform`, `Normal`, `Binomial`, `Beta`, `BetaPrime`, `Gamma`,
# and `Frechet`.

# ### Arguments

# - **`a`, `b`**: Generic parameters whose meaning varies depending
#     on what `distribution` is provided. See the list below.
# - **`distribution`**: A valid univariate distribution from `Distributions.jl`.

# Precisely what  `a` and `b` are depends on which distribution is provided.

# - `UncertainValue(Normal, μ, σ)` returns an `UncertainScalarNormallyDistributed` instance.
# - `UncertainValue(Uniform, lower, upper)` returns an `UncertainScalarUniformlyDistributed` instance.
# - `UncertainValue(Beta, α, β)` returns an `UncertainScalarBetaDistributed` instance.
# - `UncertainValue(BetaPrime, α, β)` returns an `UncertainScalarBetaPrimeDistributed` instance.
# - `UncertainValue(Gamma, α, θ)` returns an `UncertainScalarGammaDistributed` instance.
# - `UncertainValue(Frechet, α, θ)` returns an `UncertainScalarFrechetDistributed` instance.
# - `UncertainValue(Binomial, n, p)` returns an `UncertainScalarBinomialDistributed` instance.

# ### Keyword arguments

# - **`nσ`**: If `distribution <: Distributions.Normal`, then how many standard
#     deviations away from `μ` does `trunc_lower` and `trunc_upper` (i.e. both, because
#     they are the same distance away from `μ`) represent?
# - **`tolerance`**: A threshold determining how symmetric the uncertainties
#     must be in order to allow the construction of  Normal distribution
#     (`upper - lower > threshold` is required).
# - **`trunc_lower`**: Lower truncation bound for distributions with infinite
#     support. Defaults to `-Inf`.
# - **`trunc_upper`**: Upper truncation bound for distributions with infinite
#     support. Defaults to `Inf`.

# ## Examples

# ### Normal distribution

# Normal distributions are formed by using the constructor
# `UncertainValue(μ, σ, Normal; kwargs...)`. This gives a normal distribution with
# mean μ and standard deviation σ/nσ (nσ must be given as a keyword argument).

# ```julia
# # A normal distribution with mean = 2.3 and standard deviation 0.3.
# UncertainValue(2.3, 0.3, Normal)

# # A normal distribution with mean 2.3 and standard deviation 0.3/2.
# UncertainValue(2.3, 0.3, Normal, nσ = 2)

# # A normal distribution with mean 2.3 and standard deviation = 0.3,
# truncated to the interval `[1, 3]`.
# UncertainValue(2.3, 0.3, Normal, trunc_lower = 1.0, trunc_upper = 3.0)
# ```

# ### Uniform distribution

# Uniform distributions are formed using the
# `UncertainValue(lower, upper, Uniform)` constructor.

# ```julia
# #  A uniform distribution on `[2, 3]`
# UncertainValue(-2, 3, Uniform)
# ```

# """
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
        throw(DomainError("Two-parameter $distribution distribution is not implemented"))
    end
end

# TODO: make TheoreticalDistributionScalarValue type parametric on the input distribution
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

#TODO: this is not type-stable.
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

#TODO: this is not type-stable.

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
        # Todo: generic types are not implemented yet
        msg = "uncertain value type for $n_params-parameter $d not implemented."
            throw(DomainError(msg))
        
        # if n_params == 1
        #     return UncertainScalarTheoreticalOneParameter(d, param_values...)
        # elseif n_params == 2
        #     return UncertainScalarTheoreticalTwoParameter(d, param_values...)
        # elseif n_params == 3
        #     return UncertainScalarTheoreticalThreeParameter(d, param_values...)
        # else
        #     msg = "uncertain value type for $n_params-parameter $d not implemented."
        #     throw(DomainError(msg))
        # end
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
