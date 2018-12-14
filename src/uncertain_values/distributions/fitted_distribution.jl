using Distributions

abstract type AbstractEmpiricalDistribution end

struct FittedDistribution{D <: Distribution} <: AbstractEmpiricalDistribution
    distribution::D
end

resample(fd::FittedDistribution) = rand(fd.distribution)

export
AbstractEmpiricalDistribution,
FittedDistribution,
resample
