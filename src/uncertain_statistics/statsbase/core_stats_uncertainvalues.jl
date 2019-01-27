import ..UncertainValues:
	AbstractUncertainScalarKDE,
	TheoreticalDistributionScalarValue,
	UncertainScalarTheoreticalFit

import Statistics

# The general strategy is to resample

"""
	mean(uv::AbstractUncertainValue, n::Int)

Compute the mean of an uncertain value over an `n`-draw sample of it.
"""
Statistics.mean(uv::AbstractUncertainValue, n::Int) = mean(resample(uv, n))

"""
	mode(uv::AbstractUncertainValue, n::Int)

Compute the mode of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.mode(uv::AbstractUncertainValue, n::Int) = mode(resample(uv, n))

"""
	median(uv::AbstractUncertainValue, n::Int)

Compute the median of an uncertain value over an `n`-draw sample of it.
"""
Statistics.median(uv::AbstractUncertainValue, n::Int) = median(resample(uv, n))

"""
	middle(uv::AbstractUncertainValue, n::Int)

Compute the middle of an uncertain value over an `n`-draw sample of it.
"""
Statistics.middle(uv::AbstractUncertainValue, n::Int) = middle(resample(uv, n))

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


# But for theoretical distributions, we may directly access properties of the furnishing 
# distributions 

##########################################################################################
# Uncertain values represented by theoretical distributions.
# Base stats can be estimated directly from the distributions, so no need for resampling.
# These methods definitions are just for compatibility with other uncertain values, which 
# may not have analytically determined statistics associated with them.
##########################################################################################
StatsBase.mode(uv::TheoreticalDistributionScalarValue, n::Int) = mode(uv)
Statistics.mean(uv::TheoreticalDistributionScalarValue, n::Int) = mean(uv)
Statistics.median(uv::TheoreticalDistributionScalarValue, n::Int) = median(uv)
Statistics.middle(uv::TheoreticalDistributionScalarValue, n::Int) = middle(uv)
Statistics.quantile(uv::TheoreticalDistributionScalarValue, q, n::Int) = quantile(uv, q)
Statistics.std(uv::TheoreticalDistributionScalarValue, n::Int) = std(uv)
Statistics.var(uv::TheoreticalDistributionScalarValue, n::Int) = var(uv)

StatsBase.mode(uv::UncertainScalarTheoreticalFit, n::Int) = mode(uv)
Statistics.mean(uv::UncertainScalarTheoreticalFit, n::Int) = mean(uv)
Statistics.median(uv::UncertainScalarTheoreticalFit, n::Int) = median(uv)
Statistics.middle(uv::UncertainScalarTheoreticalFit, n::Int) = middle(uv)
Statistics.quantile(uv::UncertainScalarTheoreticalFit, q, n::Int) = quantile(uv, q)
Statistics.std(uv::UncertainScalarTheoreticalFit, n::Int) = std(uv)
Statistics.var(uv::UncertainScalarTheoreticalFit, n::Int) = var(uv)
