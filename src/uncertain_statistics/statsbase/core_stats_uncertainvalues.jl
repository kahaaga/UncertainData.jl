import Distributions: mode, mean, median, quantile, std, var, middle

import ..UncertainValues:
	AbstractUncertainScalarKDE,
	TheoreticalDistributionScalarValue,
	UncertainScalarTheoreticalFit


# The general strategy is to resample

"""
	mean(uv::AbstractUncertainValue, n::Int)

Compute the mean of an uncertain value over an `n`-draw sample of it.
"""
mean(uv::AbstractUncertainValue, n::Int) = mean(resample(uv, n))

"""
	mode(uv::AbstractUncertainValue, n::Int)

Compute the mode of an uncertain value over an `n`-draw sample of it.
"""
mode(uv::AbstractUncertainValue, n::Int) = mode(resample(uv, n))

"""
	median(uv::AbstractUncertainValue, n::Int)

Compute the median of an uncertain value over an `n`-draw sample of it.
"""
median(uv::AbstractUncertainValue, n::Int) = median(resample(uv, n))

"""
	middle(uv::AbstractUncertainValue, n::Int)

Compute the middle of an uncertain value over an `n`-draw sample of it.
"""
middle(uv::AbstractUncertainValue, n::Int) = middle(resample(uv, n))

"""
	quantile(uv::AbstractUncertainValue, q, n::Int)

Compute the quantile(s) `q` of an uncertain value over an `n`-draw sample of it.
"""
quantile(uv::AbstractUncertainValue, q, n::Int) = quantile(resample(uv, n), q)


"""
	std(uv::AbstractUncertainValue, n::Int)

Compute the standard deviation of an uncertain value over an `n`-draw sample of it.
"""
std(uv::AbstractUncertainValue, n::Int) = std(resample(uv, n))


"""
	variance(uv::AbstractUncertainValue, n::Int)

Compute the variance of an uncertain value over an `n`-draw sample of it.
"""
var(uv::AbstractUncertainValue, n::Int) = var(resample(uv, n))


# But for theoretical distributions, we may directly access properties of the furnishing 
# distributions 

###########################################################
# Uncertain values represented by theoretical distributions.
# Base stats can be estimated directly from the distributions. 
###########################################################
mode(uv::TheoreticalDistributionScalarValue) = mode(uv.distribution)
mean(uv::TheoreticalDistributionScalarValue) = mean(uv.distribution)
median(uv::TheoreticalDistributionScalarValue) = median(uv.distribution)
quantile(uv::TheoreticalDistributionScalarValue, q) = quantile(uv.distribution, q)
std(uv::TheoreticalDistributionScalarValue) = std(uv.distribution)
var(uv::TheoreticalDistributionScalarValue) = var(uv.distribution)


mode(uv::TheoreticalDistributionScalarValue, n::Int) = mode(uv.distribution)
mean(uv::TheoreticalDistributionScalarValue, n::Int) = mean(uv.distribution)
median(uv::TheoreticalDistributionScalarValue, n::Int) = median(uv.distribution)
middle(uv::TheoreticalDistributionScalarValue, n::Int) = middle(resample(uv, n))
quantile(uv::TheoreticalDistributionScalarValue, q, n::Int) = quantile(uv.distribution, q)
std(uv::TheoreticalDistributionScalarValue, n::Int) = std(uv.distribution)
var(uv::TheoreticalDistributionScalarValue, n::Int) = var(uv.distribution)

# For the fitted distributions, we need to access the fitted distribution's distribution
mode(uv::UncertainScalarTheoreticalFit) = mode(uv.distribution.distribution)
mean(uv::UncertainScalarTheoreticalFit) = mean(uv.distribution.distribution)
median(uv::UncertainScalarTheoreticalFit) = median(uv.distribution.distribution)
quantile(uv::UncertainScalarTheoreticalFit, q) = quantile(uv.distribution.distribution, q)
std(uv::UncertainScalarTheoreticalFit) = std(uv.distribution.distribution)
var(uv::UncertainScalarTheoreticalFit) = var(uv.distribution.distribution)

mode(uv::UncertainScalarTheoreticalFit, n::Int) = mode(uv.distribution.distribution)
mean(uv::UncertainScalarTheoreticalFit, n::Int) = mean(uv.distribution.distribution)
median(uv::UncertainScalarTheoreticalFit, n::Int) = median(uv.distribution.distribution)
middle(uv::UncertainScalarTheoreticalFit, n::Int) = middle(resample(uv, n))
quantile(uv::UncertainScalarTheoreticalFit, q, n::Int) = quantile(uv.distribution.distribution, q)
std(uv::UncertainScalarTheoreticalFit, n::Int) = std(uv.distribution.distribution)
var(uv::UncertainScalarTheoreticalFit, n::Int) = var(uv.distribution.distribution)


export mode, mean, median, middle, quantile, std, var