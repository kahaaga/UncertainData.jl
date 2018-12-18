using Distributions

abstract type AbstractEmpiricalDistribution end

struct FittedDistribution{D <: Distribution} <: AbstractEmpiricalDistribution
    distribution::D
end

export
AbstractEmpiricalDistribution,
FittedDistribution,
distribution
