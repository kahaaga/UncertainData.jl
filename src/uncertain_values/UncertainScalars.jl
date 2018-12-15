abstract type AbstractUncertainTwoParameterScalarValue <: AbstractUncertainValue end
abstract type AbstractUncertainThreeParameterScalarValue <: AbstractUncertainValue end

import Distributions.Normal
import Distributions.Uniform
import Distributions.Beta
import Distributions.BetaPrime
import Distributions.BetaBinomial
import Distributions.Gamma
import Distributions.Frechet

"""
Uncertain value represented by a generic three-parameter distribution.
"""
struct UncertainScalarGenericThreeParameter{T1<:Number, T2<:Number, T3<:Number,
        S<:ValueSupport} <: AbstractUncertainThreeParameterScalarValue
    distribution::Distribution{Univariate, S}
    a::T1
    b::T2
    c::T3
end

resample(uv::UncertainScalarGenericThreeParameter) = rand(uv.distribution)


"""
Uncertain value represented by a generic two-parameter distribution.
"""
struct UncertainScalarGenericTwoParameter{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    a::T1
    b::T2
end

resample(uv::UncertainScalarGenericTwoParameter) = rand(uv.distribution)


"""
Uncertain value represented by a normal distribution.
"""
struct UncertainScalarNormallyDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    μ::T1
    σ::T2
end

resample(uv::UncertainScalarNormallyDistributed) = rand(uv.distribution)



"""
Uncertain value represented by a uniform distribution.
"""
struct UncertainScalarUniformlyDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    lower::T1
    upper::T2
end

resample(uv::UncertainScalarUniformlyDistributed) = rand(uv.distribution)



"""
Uncertain value represented by a beta distribution.
"""
struct UncertainScalarBetaDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    α::T1
    β::T2
end

resample(uv::UncertainScalarBetaDistributed) = rand(uv.distribution)


"""
Uncertain value represented by a beta prime distribution.
"""
struct UncertainScalarBetaPrimeDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    α::T1
    β::T2
end

resample(uv::UncertainScalarBetaPrimeDistributed) = rand(uv.distribution)


"""
Uncertain value represented by a beta binomial distribution.
"""
struct UncertainScalarBetaBinomialDistributed{T1<:Number, T2<:Number,
        T3<:Number, S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    n::T1
    α::T2
    β::T3
end

resample(uv::UncertainScalarBetaBinomialDistributed) = rand(uv.distribution)



"""
Uncertain value represented by a gamma distribution.
"""
struct UncertainScalarGammaDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    α::T1
    θ::T2
end

resample(uv::UncertainScalarGammaDistributed) = rand(uv.distribution)



"""
Uncertain value represented by a Fréchet distribution.
"""
struct UncertainScalarFrechetDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    α::T1
    θ::T2
end

resample(uv::UncertainScalarFrechetDistributed) = rand(uv.distribution)



"""
Uncertain value represented by a binomial distribution.
"""
struct UncertainScalarBinomialDistributed{T1<:Number, T2<:Number,
        S<:ValueSupport} <: AbstractUncertainTwoParameterScalarValue
    distribution::Distribution{Univariate, S}
    n::T1
    p::T2
end

resample(uv::UncertainScalarBinomialDistributed) = rand(uv.distribution)



###################
# Pretty printing
###################
function summarise(o::AbstractUncertainTwoParameterScalarValue)
    a = @sprintf "%.3f" o.a
    b = @sprintf "%.3f" o.b
    dist = o.distribution
    _type = typeof(o)
    "$_type($a, $b, $dist)"
end
Base.show(io::IO, q::AbstractUncertainTwoParameterScalarValue) = print(io, summarise(q))


function summarise(o::AbstractUncertainThreeParameterScalarValue)
    a = @sprintf "%.3f" o.a
    b = @sprintf "%.3f" o.b
    c = @sprintf "%.3f" o.c
    dist = o.distribution
    _type = typeof(o)
    "$_type($a, $b, $c, $dist)"
end
Base.show(io::IO, q::AbstractUncertainThreeParameterScalarValue) = print(io, summarise(q))


function summarise(o::UncertainScalarNormallyDistributed)
    μ = @sprintf "%.3f" o.μ
    σ = @sprintf "%.3f" o.σ
    dist = o.distribution
    _type = typeof(o)
    "$_type(μ = $μ, σ = $σ)"
end

Base.show(io::IO, q::UncertainScalarNormallyDistributed) = print(io, summarise(q))

function summarise(o::UncertainScalarUniformlyDistributed)
    lower = @sprintf "%.3f" o.lower
    upper = @sprintf "%.3f" o.upper
    dist = o.distribution
    _type = typeof(o)
    "$_type(lower = $lower, upper = $upper)"
end

Base.show(io::IO, q::UncertainScalarUniformlyDistributed) = print(io, summarise(q))


function summarise(o::UncertainScalarBetaDistributed)
    α = @sprintf "%.3f" o.α
    β = @sprintf "%.3f" o.β
    dist = o.distribution
    _type = typeof(o)
    "$_type(α = $α, β = $β)"
end

Base.show(io::IO, q::UncertainScalarBetaDistributed) = print(io, summarise(q))

function summarise(o::UncertainScalarBetaPrimeDistributed)
    α = @sprintf "%.3f" o.α
    β = @sprintf "%.3f" o.β
    dist = o.distribution
    _type = typeof(o)
    "$_type(α = $α, β = $β)"
end

Base.show(io::IO, q::UncertainScalarBetaPrimeDistributed) = print(io, summarise(q))

function summarise(o::UncertainScalarBetaBinomialDistributed)
    n = @sprintf "%.3f" o.n
    α = @sprintf "%.3f" o.α
    β = @sprintf "%.3f" o.β
    dist = o.distribution
    _type = typeof(o)
    "$_type(n = $n, α = $α, β = $β)"
end

Base.show(io::IO, q::UncertainScalarBetaBinomialDistributed) = print(io, summarise(q))


function summarise(o::UncertainScalarGammaDistributed)
    α = @sprintf "%.3f" o.α
    θ = @sprintf "%.3f" o.θ
    dist = o.distribution
    _type = typeof(o)
    "$_type(α = $α, θ = $θ)"
end

Base.show(io::IO, q::UncertainScalarGammaDistributed) = print(io, summarise(q))

function summarise(o::UncertainScalarFrechetDistributed)
    α = @sprintf "%.3f" o.α
    θ = @sprintf "%.3f" o.θ
    dist = o.distribution
    _type = typeof(o)
    "$_type(α = $α, θ = $θ)"
end

Base.show(io::IO, q::UncertainScalarFrechetDistributed) = print(io, summarise(q))



function summarise(o::UncertainScalarBinomialDistributed)
    n = @sprintf "%.3f" o.n
    p = @sprintf "%.3f" o.p
    dist = o.distribution
    _type = typeof(o)
    "$_type(n = $n, p = $p)"
end

Base.show(io::IO, q::UncertainScalarBinomialDistributed) = print(io, summarise(q))


###################
# Pretty printing
###################

export
AbstractUncertainTwoParameterScalarValue,
AbstractUncertainThreeParameterScalarValue,
UncertainScalarGenericTwoParameter,
UncertainScalarGenericThreeParameter,
UncertainScalarNormallyDistributed,
UncertainScalarUniformlyDistributed,
UncertainScalarBetaDistributed,
UncertainScalarBetaPrimeDistributed,
UncertainScalarBetaBinomialDistributed,
UncertainScalarBinomialDistributed,
UncertainScalarGammaDistributed,
UncertainScalarFrechetDistributed,
Normal,
Uniform,
Beta,
BetaPrime,
BetaBinomial,
Gamma,
Frechet,
resample
