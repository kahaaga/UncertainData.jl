import ..UncertainValues.AbstractUncertainValue
import ..UncertainValues.TheoreticalFittedUncertainScalar
import ..UncertainValues.UncertainScalarTheoreticalFit

import ..UncertainValues.FittedDistribution

########################################################################
# Resampling without constraints
########################################################################


resample(ue::UncertainScalarTheoreticalFit) =
    rand(ue.distribution.distribution)
resample(ue::UncertainScalarTheoreticalFit, n::Int) =
    rand(ue.distribution.distribution, n)

resample(fd::FittedDistribution) = rand(fd.distribution)
resample(fd::FittedDistribution, n::Int) = rand(fd.distribution, n)
