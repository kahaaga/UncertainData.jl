import ..UncertainValues.AbstractUncertainValue
import ..UncertainValues.UncertainScalarEmpiricallyDistributed
import ..UncertainValues.FittedDistribution
import Distributions.Truncated

########################################################################
# Resampling without constraints
########################################################################
resample(ue::UncertainScalarEmpiricallyDistributed) =
    rand(ue.distribution.distribution)
resample(ue::UncertainScalarEmpiricallyDistributed, n::Int) =
    rand(ue.distribution.distribution, n)

resample(fd::FittedDistribution) = UncertainValues.resample(fd)
resample(fd::FittedDistribution, n::Int) = UncertainValues.resample(fd, n)

resample(uv::AbstractUncertainValue) = UncertainValues.resample(uv)
resample(uv::AbstractUncertainValue, n::Int) =
    UncertainValues.resample(uv, n)

resample(uv::UncertainScalarEmpiricallyDistributed) =
    UncertainValues.resample(uv)
resample(uv::UncertainScalarEmpiricallyDistributed, n::Int) =
    UncertainValues.resample(uv, n)
