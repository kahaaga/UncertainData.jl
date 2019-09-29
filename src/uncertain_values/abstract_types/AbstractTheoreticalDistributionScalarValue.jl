import Base.rand
import Distributions, StatsBase
import IntervalArithmetic: interval
import Statistics 

abstract type TheoreticalDistributionScalarValue <: AbstractUncertainValue end

Base.rand(uv::TheoreticalDistributionScalarValue) = rand(uv.distribution)
Base.rand(uv::TheoreticalDistributionScalarValue, n::Int) = rand(uv.distribution, n)

function Distributions.support(fd::TheoreticalDistributionScalarValue)
    s = support(fd.distribution)
    interval(s.lb, s.ub)
end

Distributions.pdf(fd::TheoreticalDistributionScalarValue, x) = pdf(fd.distribution, x)
Statistics.mean(fd::TheoreticalDistributionScalarValue) = mean(fd.distribution)
Statistics.median(fd::TheoreticalDistributionScalarValue) = median(fd.distribution)
Statistics.middle(fd::TheoreticalDistributionScalarValue) = middle(fd.distribution)
Statistics.quantile(fd::TheoreticalDistributionScalarValue, q) = quantile(fd.distribution, q)
Statistics.std(fd::TheoreticalDistributionScalarValue) = std(fd.distribution)
Statistics.var(fd::TheoreticalDistributionScalarValue) = var(fd.distribution)
StatsBase.mode(fd::TheoreticalDistributionScalarValue) = mode(fd.distribution)


abstract type AbstractUncertainOneParameterScalarValue{S <: ValueSupport, T1} <: TheoreticalDistributionScalarValue end
abstract type AbstractUncertainTwoParameterScalarValue{S <: ValueSupport, T1, T2} <: TheoreticalDistributionScalarValue end
abstract type AbstractUncertainThreeParameterScalarValue{S <: ValueSupport, T1, T2, T3} <: TheoreticalDistributionScalarValue end
