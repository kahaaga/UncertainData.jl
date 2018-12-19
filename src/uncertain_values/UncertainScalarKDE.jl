import Base.rand

import StatsBase.quantile
import StatsBase.median
import StatsBase.support

import Distributions.ecdf
import Distributions.support
import Distributions.Distribution

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
    UncertainValue(data::Vector{T}; kernel::Type{D} = Normal, npoints::Int=2048)
        where {D <: Distribution, T}

Construct an uncertain value by a kernel density estimate to `data`.

## Arguments:
- **`kernel`**: The kernel to use. Defaults to `Distributions.Normal`. Must be
    a valid family from `Distributions.jl`.
- **`npoints`**: The number of points to use for the kernel density estimation.
    Fast Fourier transforms are used, so the number of points should be a power
    of 2 (default = 2048).
"""
function UncertainValue(data::Vector{T}; kernel::Type{D} = Normal,
        npoints::Int = 2048) where {D <: Distribution, T}

    # Kernel density estimation
    KDE = kde(data, npoints = npoints, kernel = kernel)

    # Get the x value for which the density is estimated.
    xrange = KDE.x

    # Normalise estimated density
    density = KDE.density ./ sum(KDE.density)

    # Create an uncertain value
    UncertainScalarKDE(KDE, data, xrange, Weights(density))
end


"""
    UncertainValue(kerneldensity::Type{K}, data::Vector{T};
        kernel::Type{D} = Normal, npoints::Int = 2048)
            where {K <: UnivariateKDE, D <: Distribution, T}

Construct an uncertain value by a kernel density estimate to `data`.

Fast Fourier transforms are used in the kernel density estimation, so the
number of points should be a power of 2 (default = 2048).
"""
function UncertainValue(kerneldensity::Type{K}, data::Vector{T};
        kernel::Type{D} = Normal, npoints::Int = 2048) where
            {K <: UnivariateKDE, D <: Distribution, T}

    # Kernel density estimation
    KDE = kde(data, npoints = npoints, kernel = kernel)

    # Get the x value for which the density is estimated.
    xrange = KDE.x

    # Normalise estimated density
    density = KDE.density ./ sum(KDE.density)

    # Create an uncertain value
    UncertainScalarKDE(KDE, data, xrange, Weights(density))
end



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

function quantile(uv::AbstractUncertainScalarKDE{T}, q) where T
    uv.range[findfirst(ecdf(uv) .> q)]
end

median(uv::AbstractUncertainScalarKDE{T}) where T = quantile(uv, 0.5)


"""
    support(uv::UncertainScalarKDE)

Return the support of an uncertain value furnished by a kernel density
estimate.
"""
support(uv::AbstractUncertainScalarKDE{T}) where T = (minimum(uv.range), maximum(uv.range))


"""
    getrangeindex(uv::AbstractUncertainScalarKDE, q::Float64)

Return the index of the range/density value corresponding to the `q`-th quantile
of an uncertain value furnished by a kernel density estimate.
"""
function getquantileindex(uv::AbstractUncertainScalarKDE{T}, q::Float64) where T
    findfirst(ecdf(uv) .> q)
end




export
AbstractUncertainScalarKDE,
UncertainScalarKDE
UncertainValue,
ecdf,
support,
getquantileindex
