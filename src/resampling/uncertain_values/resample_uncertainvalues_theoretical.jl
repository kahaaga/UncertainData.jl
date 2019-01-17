import ..UncertainValues:
    AbstractUncertainValue,
    FittedDistribution,
    TheoreticalFittedUncertainScalar,
	UncertainScalarTheoreticalFit
import Distributions: Truncated
import StatsBase: quantile, std, mean
import Distributions: support

########################################################################
# Resampling without constraints
########################################################################
"""
	resample(uv::AbstractUncertainValue)

Sample the uncertain value once, drawing values from the entire support of the probability 
distribution furnishing it.
"""
resample(uv::AbstractUncertainValue) = rand(uv.distribution)


"""
	resample(uv::AbstractUncertainValue, n::Int)

Sample the uncertain value `n` times, drawing values from the entire support of the 
probability distribution furnishing it.
"""
resample(uv::AbstractUncertainValue, n::Int) =
    rand(uv.distribution, n)


"""
    resample(fd::FittedDistribution)

Resample a `FittedDistribution` instance once.
"""
resample(fd::FittedDistribution) = rand(fd.distribution)


"""
    resample(fd::FittedDistribution, n::Int)

Resample a `FittedDistribution` instance `n` times.
"""
resample(fd::FittedDistribution, n::Int) = rand(fd.distribution, n)


"""
    resample(ue::UncertainScalarTheoreticalFit)

Resample an `UncertainScalarTheoreticalFit` instance once.
"""
resample(ue::UncertainScalarTheoreticalFit) =
    rand(ue.distribution.distribution)


"""
    resample(ue::UncertainScalarTheoreticalFit, n::Int)

Resample an `UncertainScalarTheoreticalFit` instance `n` times.
"""
resample(ue::UncertainScalarTheoreticalFit, n::Int) =
    rand(ue.distribution.distribution, n)


"""
    resample(uv::TheoreticalFittedUncertainScalar, n::Int)

Resample an `TheoreticalFittedUncertainScalar` instance once.
"""
resample(uv::TheoreticalFittedUncertainScalar) =
    rand(uv.distribution.distribution)


"""
    resample(uv::TheoreticalFittedUncertainScalar, n::Int)

Resample an `TheoreticalFittedUncertainScalar` instance `n` times.
"""
resample(uv::TheoreticalFittedUncertainScalar, n::Int) =
    rand(uv.distribution.distribution, n)
