import Distributions
import Statistics

abstract type TheoreticalFittedUncertainScalar <: TheoreticalDistributionScalarValue end

Broadcast.broadcastable(uv::TheoreticalFittedUncertainScalar) = Ref(uv.distribution)

"""
    UncertainEmpiricalScalarValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The distribution describing the value.
- **`values`**: The values from which `distribution` is estimated.
"""
struct UncertainScalarTheoreticalFit{D <: Distribution, T} <: TheoreticalFittedUncertainScalar
    distribution::FittedDistribution{D} # S may be Continuous or Discrete
    values::AbstractVector{T}
end

"""
    ConstrainedUncertainEmpiricalScalarValue

An empirical value represented by a distribution estimated from actual data.

## Fields
- **`distribution`** The truncated version of the distribution describing the
    value.
- **`values`**: The values from which the original distribution was estimated.
"""
struct ConstrainedUncertainScalarTheoreticalFit{D <: Distribution, T} <: TheoreticalFittedUncertainScalar
    distribution::FittedDistribution{D} # S may be Continuous or Discrete
    values::AbstractVector{T}
end

""" Truncate a fitted distribution. """
Distributions.Truncated(fd::FittedDistribution, lower, upper) =
    Distributions.Truncated(fd.distribution, lower, upper)


Base.rand(fd::UncertainScalarTheoreticalFit) = rand(fd.distribution.distribution)
Base.rand(fd::UncertainScalarTheoreticalFit, n::Int) = rand(fd.distribution.distribution, n)

# For the fitted distributions, we need to access the fitted distribution's distribution
Distributions.pdf(fd::UncertainScalarTheoreticalFit, x) = pdf(fd.distribution.distribution, x)
StatsBase.mode(uv::UncertainScalarTheoreticalFit) = mode(uv.distribution.distribution)
Statistics.mean(uv::UncertainScalarTheoreticalFit) = mean(uv.distribution.distribution)
Statistics.median(uv::UncertainScalarTheoreticalFit) = median(uv.distribution.distribution)
Statistics.quantile(uv::UncertainScalarTheoreticalFit, q) = quantile(uv.distribution.distribution, q)
Statistics.std(uv::UncertainScalarTheoreticalFit) = std(uv.distribution.distribution)
Statistics.var(uv::UncertainScalarTheoreticalFit) = var(uv.distribution.distribution)



export
TheoreticalFittedUncertainScalar,
UncertainScalarTheoreticalFit,
ConstrainedUncertainScalarTheoreticalFit
