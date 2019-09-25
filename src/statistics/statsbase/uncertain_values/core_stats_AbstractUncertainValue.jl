import StatsBase 

"""
	mean(uv::AbstractUncertainValue, n::Int)

Compute the mean of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.mean(x::AbstractUncertainValue, n::Int) = resample(mean, x, n)

"""
	mode(uv::AbstractUncertainValue, n::Int)

Compute the mode of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.mode(x::AbstractUncertainValue, n::Int) = resample(mode, x, n)

"""
	quantile(uv::AbstractUncertainValue, q, n::Int)

Compute the quantile(s) `q` of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.quantile(x::AbstractUncertainValue, q, n::Int) = resample(quantile, x, n, q)

"""
	median(uv::AbstractUncertainValue, n::Int)

Compute the median of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.median(x::AbstractUncertainValue, n::Int) = resample(median, x, n)

"""
	middle(uv::AbstractUncertainValue, n::Int)

Compute the middle of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.middle(x::AbstractUncertainValue, n::Int) = resample(middle, x, n)

"""
	std(uv::AbstractUncertainValue, n::Int)

Compute the standard deviation of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.std(x::AbstractUncertainValue, n::Int) = resample(std, x, n)

"""
	variance(uv::AbstractUncertainValue, n::Int)

Compute the variance of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.var(x::AbstractUncertainValue, n::Int) = resample(var, x, n)

"""
	genmean(uv::AbstractUncertainValue, p, n::Int)

Compute the generalized/power mean with exponent `p` of an uncertain value over an 
`n`-draw sample of it.
"""
StatsBase.genmean(x::AbstractUncertainValue, p, n::Int) = resample(genmean, x, n, p)
"""
	genvar(uv::AbstractUncertainValue, n::Int)

Compute the generalized sample variance of an uncertain value over an 
`n`-draw sample of it.
"""
StatsBase.genvar(x::AbstractUncertainValue, n::Int) = resample(genvar, x, n)


"""
	harmmean(uv::AbstractUncertainValue, n::Int)

Compute the harmonic mean of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.harmmean(x::AbstractUncertainValue, n::Int) = resample(harmmean, x, n)

"""
	geomean(uv::AbstractUncertainValue, n::Int)

Compute the geometric mean of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.geomean(x::AbstractUncertainValue, n::Int) = resample(geomean, x, n)

"""
	kurtosis(uv::AbstractUncertainValue, n::Int)

Compute the excess kurtosis of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.kurtosis(x::AbstractUncertainValue, n::Int; m = mean(x)) = resample(kurtosis, x, n, m)

StatsBase.moment(x::AbstractUncertainValue, k, n::Int, m = mean(x)) = resample(moment, x, n, k, m)

StatsBase.percentile(x::AbstractUncertainValue, p, n::Int) = resample(percentile, x, n, p)

StatsBase.renyientropy(x::AbstractUncertainValue, α, n::Int) = resample(quantile, x, n, α)

StatsBase.rle(x::AbstractUncertainValue, n::Int) = resample(rle, x, n)

StatsBase.sem(x::AbstractUncertainValue, n::Int) = resample(sem, x, n)

StatsBase.skewness(x::AbstractUncertainValue, n::Int; m = mean(x)) = resample(skewness, x, n, m)

StatsBase.span(x::AbstractUncertainValue, n::Int) = resample(span, x, n)

StatsBase.summarystats(x::AbstractUncertainValue, n::Int) = resample(summarystats, x, n)

StatsBase.totalvar(x::AbstractUncertainValue, n::Int) = resample(totalvar, x, n)