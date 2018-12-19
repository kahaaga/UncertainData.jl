import Distributions.Distribution
import Distributions.rand
import Distributions.support
import StatsBase.quantile
import Distributions.pdf

abstract type AbstractEmpiricalDistribution end

struct FittedDistribution{D <: Distribution} <: AbstractEmpiricalDistribution
    distribution::D
end

Broadcast.broadcastable(fd::FittedDistribution) = Ref(fd)

Distributions.rand(fd::FittedDistribution) = rand(fd.distribution)
Distributions.rand(fd::FittedDistribution, n::Int) = rand(fd.distribution, n)
Distributions.support(fd::FittedDistribution) = support(fd.distribution)
Distributions.pdf(fd::FittedDistribution, x) = pdf(fd.distribution, x)
StatsBase.quantile(fd::FittedDistribution, q) = quantile(fd.distribution, q)

export
AbstractEmpiricalDistribution,
FittedDistribution
