

"""
    struct ConstrainedUncertainScalarValueOneParameter{S, T1 <: Number}
        distribution::Distribution{Univariate, S}
        a::T1
    end

A constrained uncertain value represented by a one-parameter distribution,
where the original distribution has been truncated.

## Fields:
- **`distribution`**: The truncated version of the original distribution.
- **`a`**: The original value of the parameter of the original distribution.
"""
struct ConstrainedUncertainScalarValueOneParameter{S,
        T1 <: Number} <: AbstractUncertainOneParameterScalarValue{S, T1}
    distribution::Distribution{Univariate, S}
    a::T1
end

"""
    struct ConstrainedUncertainScalarValueTwoParameter{S, T1 <: Number, T2 <: Number}
        distribution::Distribution{Univariate, S}
        a::T1
        b::T2
    end

A constrained uncertain value represented by a two-parameter distribution,
where the original distribution has been truncated.

## Fields:
- **`distribution`**: The truncated version of the original distribution.
- **`a`**: The original value of the first parameter of the original distribution.
- **`b`**: The original value of the second parameter of the original distribution.
"""
struct ConstrainedUncertainScalarValueTwoParameter{S, T1 <: Number,
        T2 <: Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    a::T1
    b::T2
end

"""
    struct ConstrainedUncertainScalarValueThreeParameter{S, T1 <: Number, T2 <: Number, T3 <: Number}
        distribution::Distribution{Univariate, S}
        a::T1
        b::T2
        c::T3
    end

A constrained uncertain value represented by a two-parameter distribution,
where the original distribution has been truncated.

## Fields:
- **`distribution`**: The truncated version of the original distribution.
- **`a`**: The original value of the first parameter of the original distribution.
- **`b`**: The original value of the second parameter of the original distribution.
- **`c`**: The original value of the third parameter of the original distribution.

"""
struct ConstrainedUncertainScalarValueThreeParameter{S, T1 <: Number, T2 <: Number, T3 <: Number} <: AbstractUncertainThreeParameterScalarValue{S, T1, T2, T3}
    distribution::Distribution{Univariate, S}
    a::T1
    b::T2
    c::T3
end



import Distributions.Normal
import Distributions.Uniform
import Distributions.Beta
import Distributions.BetaPrime
import Distributions.BetaBinomial
import Distributions.Gamma
import Distributions.Frechet

"""
    UncertainScalarTheoreticalThreeParameter(d::Distribution, a, b, c)

Uncertain value represented by a generic three-parameter distribution `d` with parameters `a`, `b` and `c`.
"""
struct UncertainScalarTheoreticalThreeParameter{S<:ValueSupport, T1<:Number, T2<:Number, T3<:Number} <: AbstractUncertainThreeParameterScalarValue{S, T1, T2, T3}
    distribution::Distribution{Univariate, S}
    a::T1
    b::T2
    c::T3
end

"""
    UncertainScalarTheoreticalTwoParameter(d::Distribution, a, b)

Uncertain value represented by a generic two-parameter distribution `d` with parameters `a` and `b`.
"""
struct UncertainScalarTheoreticalTwoParameter{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    a::T1
    b::T2
end

"""
    UncertainScalarTheoreticalOneParameter(d::Distribution, a)

Uncertain value represented by a generic one-parameter distribution `d` with parameter `a`.
"""
struct UncertainScalarGenericOneParameter{S<:ValueSupport, T1<:Number} <: AbstractUncertainOneParameterScalarValue{S, T1}
    distribution::Distribution{Univariate, S}
    a::T1
end

"""
    UncertainScalarNormallyDistributed(d::Normal, μ, σ)

Uncertain value represented by a normal distribution `d` with mean `μ` and standard deviation `σ`.

## Example 

```julia
x = UncertainValue(Normal, 1.2, 0.3)
```
"""
struct UncertainScalarNormallyDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    μ::T1
    σ::T2
end

"""
    UncertainScalarUniformlyDistributed(d::Uniform, lower, upper)

Uncertain value represented by a uniform distribution `d` with `lower` and `upper` bounds.

## Example 

```julia
x = UncertainValue(Uniform, -2.5, 4.5)
```
"""
struct UncertainScalarUniformlyDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    lower::T1
    upper::T2
end

"""
    UncertainScalarBetaDistributed(d::Beta, α, β)

Uncertain value represented by a beta distribution `d` with parameters `α` and `β`.

## Example 

```julia
x = UncertainValue(Beta, 0.5, 3.0)
```
"""
struct UncertainScalarBetaDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    α::T1
    β::T2
end

"""
    UncertainScalarBetaPrimeDistributed(d::BetaPrime, α, β)

Uncertain value represented by a beta prime distribution `d` with parameters `α` and `β`.

## Example 

```julia
x = UncertainValue(BetaPrime, 2.1, 3.3)
```
"""
struct UncertainScalarBetaPrimeDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    α::T1
    β::T2
end

"""
    UncertainScalarBetaBinomialDistributed(d::BetaBinomial, n, α, β)

Uncertain value represented by a beta binomial distribution `d` with parameters `n`, `α` and `β`.

## Example 

```julia
x = UncertainValue(BetaBinomial, 10, 0.2, 0.7)
```
"""
struct UncertainScalarBetaBinomialDistributed{S<:ValueSupport, T1<:Number, T2<:Number, T3<:Number} <: AbstractUncertainThreeParameterScalarValue{S, T1, T2, T3}
    distribution::Distribution{Univariate, S}
    n::T1
    α::T2
    β::T3
end

"""
    UncertainScalarGammaDistributed(d::Gamma, α, θ)

Uncertain value represented by a gamma distribution `d` with parameters `α` and `θ`.

## Example 

```julia
x = UncertainValue(Gamma, 0.2, 0.44)
```
"""
struct UncertainScalarGammaDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    α::T1
    θ::T2
end

"""
    UncertainScalarFrechetDistributed(d::Frechet, α, θ)

Uncertain value represented by a Fréchet distribution `d` with parameters `α` and `θ`.

## Example 

```julia
x = UncertainValue(Frechet, 2.0, 2.1)
```
"""
struct UncertainScalarFrechetDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    α::T1
    θ::T2
end

"""
    UncertainScalarBinomialDistributed(d::Binomial, n, θ)

Uncertain value represented by a binomial distribution `d` with parameters `n` and `θ`.

## Example 

```julia
x = UncertainValue(Binomial, 15, 0.5)
```
"""
struct UncertainScalarBinomialDistributed{S<:ValueSupport, T1<:Number, T2<:Number} <: AbstractUncertainTwoParameterScalarValue{S, T1, T2}
    distribution::Distribution{Univariate, S}
    n::T1
    p::T2
end


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



export
TheoreticalDistributionScalarValue,

# AbstractUncertainOneParameterScalarValue,
# AbstractUncertainTwoParameterScalarValue,
# AbstractUncertainThreeParameterScalarValue,

ConstrainedUncertainScalarValueOneParameter,
ConstrainedUncertainScalarValueTwoParameter,
ConstrainedUncertainScalarValueThreeParameter,

UncertainScalarGenericOneParameter,
UncertainScalarTheoreticalTwoParameter,
UncertainScalarTheoreticalThreeParameter,
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
Binomial
