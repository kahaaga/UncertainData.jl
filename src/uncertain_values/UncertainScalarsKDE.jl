import Base.rand

import StatsBase.quantile
import StatsBase.median
import Distributions.support

import Distributions.ecdf
import Base:
    minimum, maximum,
    max, min

abstract type AbstractUncertainScalarKDE{T} <: AbstractEmpiricalValue end

"""
    UncertainScalarKDE

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`**: The `UnvariateKDE` estimate for the distribution of `values`.
- **`values`**: The values from which `distribution` is estimated.
- **`range`**: The values for which the pdf is estimated.
- **`pdf`**: The values of the pdf at each point in `range`.

"""
struct UncertainScalarKDE{T} <: AbstractUncertainScalarKDE{T}
    distribution::KernelDensity.UnivariateKDE
    values::AbstractVector{T}
    range
    pdf::StatsBase.Weights
end


"""
    TruncatedUncertainScalarKDE

A truncated UncertainScalarKDE.
"""
struct TruncatedUncertainScalarKDE{T} <: AbstractUncertainScalarKDE{T}
    distribution::KernelDensity.UnivariateKDE
    values::AbstractVector{T}
    range
    pdf::StatsBase.Weights
end


function summarise(uv::AbstractUncertainScalarKDE{T}) where {T}
    dist = uv.distribution
    range = uv.range
    dist = typeof(uv.distribution)
    _type = typeof(uv)
    "$_type($dist, range = $range)"
end

Base.show(io::IO, uv::AbstractUncertainScalarKDE{T}) where {T} = print(io, summarise(uv))




"""
    rand(uv::AbstractUncertainScalarKDE)

Sample a random number from an uncertain value represented by a kernel
density estimate.
"""
function rand(uv::AbstractUncertainScalarKDE)
    # Box width
    δ = step(uv.range)

    # Sample a box
    sampled_val = sample(uv.range, uv.pdf)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    rand(uv::AbstractUncertainScalarKDE, n::Int)

Sample a random number from an uncertain value represented by a kernel
density estimate.
"""
function rand(uv::AbstractUncertainScalarKDE, n::Int)
    # Box width
    δ = step(uv.range)

    # Sample n boxes according to estimated pdf
    sampled_vals = Vector{Float64}(undef, n)
    sample!(uv.range, uv.pdf, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end

"""
    ecdf(uv::AbstractUncertainScalarKDE)

Empirical cumulative distribution function for an uncertain value approximated
by kernel density estimation.
"""
ecdf(uv::AbstractUncertainScalarKDE) = cumsum(uv.pdf)

"""
The mode (most likely value) of an uncertain value represented by a
kernel density estimate.
"""
mode(uv::AbstractUncertainScalarKDE) = uv.range(findmax(uv.distribution.density)[2])


"""
    quantile(uv::UncertainScalarKDE, q)

Return the `q`-th quantile of the distribution furnishing the uncertain value.
"""
function quantile(uv::AbstractUncertainScalarKDE{T}, q) where T
    uv.range[findfirst(ecdf(uv) .> q)]
end

median(uv::AbstractUncertainScalarKDE{T}) where T = quantile(uv, 0.5)


"""
    support(uv::UncertainScalarKDE)

Return the support of an uncertain value furnished by a kernel density
estimate.
"""
support(uv::AbstractUncertainScalarKDE{T}) where T = 
    interval(minimum(uv.range), maximum(uv.range))


"""
    getrangeindex(uv::AbstractUncertainScalarKDE, q::Float64)

Return the index of the range/density value corresponding to the `q`-th quantile
of an uncertain value furnished by a kernel density estimate.
"""
function getquantileindex(uv::AbstractUncertainScalarKDE{T}, q::Float64) where T
    findfirst(ecdf(uv) .> q)
end



minimum(uv::AbstractUncertainScalarKDE) = minimum(uv.range)
maximum(uv::AbstractUncertainScalarKDE) = maximum(uv.range)


min(uv::AbstractUncertainScalarKDE) = minimum(uv.range)
max(uv::AbstractUncertainScalarKDE) = maximum(uv.range)





export
AbstractUncertainScalarKDE,
UncertainScalarKDE
ecdf,
support,
getquantileindex,
UnivariateKDE,
minimum,
maximum