import Base.rand

import StatsBase.quantile
import StatsBase.median
import Distributions.ecdf
import Distributions.support


"""
    UncertainScalarKDE

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`**: The `UnvariateKDE` estimate for the distribution of `values`.
- **`values`**: The values from which `distribution` is estimated.
- **`range`**: The values for which the pdf is estimated.
- **`pdf`**: The values of the pdf at each point in `range`.

"""
struct UncertainScalarKDE{T} <: AbstractEmpiricalValue
    distribution::KernelDensity.UnivariateKDE
    values::AbstractVector{T}
    range
    pdf::StatsBase.Weights
end


function summarise(uv::UncertainScalarKDE{T}) where {T}
    dist = uv.distribution
    range = uv.range
    dist = typeof(uv.distribution)
    _type = typeof(uv)
    "$_type($dist, range = $range)"
end

Base.show(io::IO, uv::UncertainScalarKDE{T}) where {T} = print(io, summarise(uv))


"""
    UncertainValue(data::Vector{T};
        kernel::Type{D} = Normal,
        npoints::Int=2048) where {K <: KernelDensity.UnivariateKDE, D <: Distributions.Distribution, T}

Construct an uncertain value by a kernel density estimate to `data`.

Fast Fourier transforms are used in the kernel density estimation, so the
number of points should be a power of 2 (default = 2048).
"""
function UncertainValue(data::Vector{T};
        kernel::Type{D} = Normal,
        npoints::Int = 2048) where {D <: Distributions.Distribution, T}

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
        kernel::Type{D} = Normal,
        npoints::Int=2048) where {K <: KernelDensity.UnivariateKDE, D <: Distributions.Distribution, T}

Construct an uncertain value by a kernel density estimate to `data`.

Fast Fourier transforms are used in the kernel density estimation, so the
number of points should be a power of 2 (default = 2048).
"""
function UncertainValue(kerneldensity::Type{K}, data::Vector{T};
        kernel::Type{D} = Normal,
        npoints::Int = 2048) where {K <: KernelDensity.UnivariateKDE, D <: Distributions.Distribution, T}

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
    rand(uv::UncertainScalarKDE)

Sample a random number from an uncertain value represented by a kernel
density estimate.
"""
function rand(uv::UncertainScalarKDE)
    # Box width
    δ = step(uv.range)

    # Sample a box
    sampled_val = sample(uv.range, uv.pdf)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    rand(uv::UncertainScalarKDE, n::Int)

Sample a random number from an uncertain value represented by a kernel
density estimate.
"""
function rand(uv::UncertainScalarKDE, n::Int)
    # Box width
    δ = step(uv.range)

    # Sample n boxes according to estimated pdf
    sampled_vals = Vector{Float64}(undef, n)
    sample!(uv.range, uv.pdf, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end

"""
    ecdf(uv::UncertainScalarKDE)

Empirical cumulative distribution function for an uncertain value approximated
by kernel density estimation.
"""
ecdf(uv::UncertainScalarKDE) = cumsum(uv.pdf)

"""
    quantile(uv::UncertainScalarKDE, q)

Return the `q`-th quantile of the distribution furnishing the uncertain value.
"""
function quantile(uv::UncertainScalarKDE, q)
    uv.range[findfirst(ecdf(uv) .> q)]
end

median(uv::UncertainScalarKDE) = quantile(uv, 0.5)


"""
    support(uv::UncertainScalarKDE)

Return the support of an uncertain value furnished by a kernel density
estimate.
"""
support(uv::UncertainScalarKDE) = (minimum(uv.range), maximum(uv.range))

"""
    getrangeindex(uv::UncertainScalarKDE, q::Float64)

Return the index of the range/density value corresponding to the `q`-th quantile
of an uncertain value furnished by a kernel density estimate.
"""
function getquantileindex(uv::UncertainScalarKDE, q::Float64)
    findfirst(ecdf(uv) .> q)
end




export
UncertainScalarKDE
UncertainValue,
ecdf,
support,
getquantileindex
