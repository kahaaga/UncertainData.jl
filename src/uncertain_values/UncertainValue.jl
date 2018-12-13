include("UncertainScalarsEmpirical.jl")
include("UncertainScalars.jl")


"""
    UncertainValue(empiricaldata::AbstractVector{T}, distribution) where {T <: Number}

# Constructor for empirical distributions

## Arguments
- **`empiricaldata`**: The data for which to fit the `distribution`.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

"""
function UncertainValue(empiricaldata::AbstractVector{T},
        distribution) where {T<:Number}
    UncertainScalarEmpiricallyDistributed(empiricaldata, distribution)
end

"""

     UncertainValue(a, b, distribution; kwargs...)

# Constructor for two-parameter distributions

`UncertainValue`s are currently implemented for the following two-parameter
distributions: `Uniform`, `Normal`, `Binomial`, `Beta`, `BetaPrime`, `Gamma`,
and `Frechet`.

### Arguments

- **`a`, `b`**: Generic parameters whose meaning varies depending
    on what `distribution` is provided. See the list above.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

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

#### Uniform distribution

Uniform distributions are formed using the
`UncertainValue(lower, upper, Uniform)` constructor.

```julia
#  A uniform distribution on `[2, 3]`
UncertainValue(-2, 3, Uniform)
```

"""
function UncertainValue(a::T1, b::T2, distribution;
        kwargs...) where {T1<:Number, T2 <: Number}
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
    UncertainValue(a, b, c, distribution; kwargs...)

## Constructor for three-parameter distributions

Currently implemented distributions are `BetaBinomial`.

### Arguments
- **`a`, `b`, `c`**: Generic parameters whose meaning varies depending
    on what `distribution` is provided. See the list above.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

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
"""
function UncertainValue(a::T1, b::T2, c::T3, distribution;
            kwargs...) where {T1 <: Number, T2 <: Number, T3 <: Number, S}

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
#    :(UncertainScalarEmpiricallyDistributed($values, $d))
#end
#uncertain, @uncertain



export
UncertainValue
#uncertainvalue,
#@uncertainvalue
