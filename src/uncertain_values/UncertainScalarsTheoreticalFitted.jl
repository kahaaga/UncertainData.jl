include("AbstractEmpirical.jl")
include("distributions/fitted_distribution.jl")

import Distributions.Truncated


abstract type TheoreticalFittedUncertainScalar <: TheoreticalDistributionScalarValue end

Broadcast.broadcastable(d::TheoreticalFittedUncertainScalar) = Ref(d)

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


export
TheoreticalFittedUncertainScalar,
UncertainScalarTheoreticalFit,
ConstrainedUncertainScalarTheoreticalFit
