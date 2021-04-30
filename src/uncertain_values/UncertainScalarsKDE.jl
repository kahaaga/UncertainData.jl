import Base.rand

import StatsBase.quantile
import StatsBase.median
import Distributions.support
import Distributions.ecdf
import Base:
    minimum, maximum,
    max, min


"""
    UncertainScalarKDE(d::KernelDensity.UnivariateKDE, x::AbstractVector, range, pdf)

An uncertain value represented by a kernel density estimate `d`,  to the 
underlying distribution for the empirical sample `x`. 
    
`range` are the values for which the pdf is estimated, and `pdf` are the 
corresponding values of the pdf. Gaussian kernels are used by default.

## Examples

```julia
using Distributions, UncertainData, KernelDensity

# Draw a 1000-point sample from a normal distribution.
s = rand(Normal(), 1000)

# Estimate a distribution to the underlying distribution by using 
# kernel density estimation on the sample `s` 
x = UncertainValue(s)

# The explicit constructor allows adjusting the kernel (must be a valid 
# kernel from Distributions.jl; normal distributions are the default), 
# and the number of  points used for the estimation (must be a power of 2; 
# default is 2048 points).
x = UncertainValue(UnivariateKDE, s; kernel = Normal, npoints = 1024) 
```
"""
struct UncertainScalarKDE{T, V <: AbstractVector{T}} <: AbstractUncertainScalarKDE{T}
    distribution::KernelDensity.UnivariateKDE
    values::V
    range
    pdf::StatsBase.Weights
end


"""
    TruncatedUncertainScalarKDE

A truncated [`UncertainScalarKDE`](@ref).
"""
struct TruncatedUncertainScalarKDE{T, V <: AbstractVector{T}} <: AbstractUncertainScalarKDE{T}
    distribution::KernelDensity.UnivariateKDE
    values::V
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
    getquantileindex(uv::AbstractUncertainScalarKDE, q::Float64)

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