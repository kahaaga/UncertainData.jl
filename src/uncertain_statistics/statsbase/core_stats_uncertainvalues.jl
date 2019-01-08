import Statistics
import Statistics.std
import Statistics.var
import Statistics.cor
import Statistics.cov
import Statistics.mean
import Statistics.median
import Statistics.median
import Statistics.middle
import Statistics.quantile
import ..Resampling.resample
import Distributions.mode

import ..UncertainValues.AbstractUncertainScalarKDE

#########################################
# Statistics on `UncertainValue`s
# #########################################
Distributions.mode(uv::AbstractUncertainValue) = mode(uv.distribution)
Statistics.mean(uv::AbstractUncertainValue) = mean(uv.distribution)
Statistics.median(uv::AbstractUncertainValue) = median(uv.distribution)
Statistics.quantile(uv::AbstractUncertainValue, q) = quantile(uv.distribution, q)
Statistics.std(uv::AbstractUncertainValue) = std(uv.distribution)
Statistics.var(uv::AbstractUncertainValue) = var(uv.distribution)
#
# Statistics.mean(uv::AbstractUncertainScalarKDE, n::Int = 10000) = mean(resample(uv, n))
# Statistics.median(uv::AbstractUncertainScalarKDE, n::Int = 10000) = median(resample(uv, n))
# Statistics.quantile(uv::AbstractUncertainScalarKDE, q, n::Int = 10000) = quantile(resample(uv, n), q)
# Statistics.std(uv::AbstractUncertainScalarKDE, n::Int = 10000) = std(resample(uv, n))
# Statistics.var(uv::AbstractUncertainScalarKDE, n::Int = 10000) = var(resample(uv, n))


# Providing an extra integer argument n triggers resampling.
"""
	mean(uv::AbstractUncertainValue, n::Int)

Compute the mean of an uncertain value over an `n`-draw sample of it.
"""
Statistics.mean(uv::AbstractUncertainValue, n::Int) = mean(resample(uv, n))
Statistics.mean(uv::AbstractUncertainValue, n::Int) = mean(resample(uv, n))

"""
	mode(uv::AbstractUncertainValue, n::Int)

Compute the mode of an uncertain value over an `n`-draw sample of it.
"""
Distributions.mode(uv::AbstractUncertainValue, n::Int) = mode(resample(uv, n))

"""
	median(uv::AbstractUncertainValue, n::Int)

Compute the median of an uncertain value over an `n`-draw sample of it.
"""
Statistics.median(uv::AbstractUncertainValue, n::Int) = median(resample(uv, n))

"""
	middle(uv::AbstractUncertainValue, n::Int)

Compute the middle of an uncertain value over an `n`-draw sample of it.
"""
Statistics.middle(uv::AbstractUncertainValue, n::Int = 1000) = middle(resample(uv, n))

"""
	quantile(uv::AbstractUncertainValue, q, n::Int)

Compute the quantile(s) `q` of an uncertain value over an `n`-draw sample of it.
"""
Statistics.quantile(uv::AbstractUncertainValue, q, n::Int) = quantile(resample(uv, n), q)


"""
	std(uv::AbstractUncertainValue, n::Int)

Compute the standard deviation of an uncertain value over an `n`-draw sample of it.
"""
Statistics.std(uv::AbstractUncertainValue, n::Int) = std(resample(uv, n))


"""
	variance(uv::AbstractUncertainValue, n::Int)

Compute the variance of an uncertain value over an `n`-draw sample of it.
"""
Statistics.var(uv::AbstractUncertainValue, n::Int) = var(resample(uv, n))
