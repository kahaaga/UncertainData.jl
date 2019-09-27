import StatsBase

"""
	mean(uv::AbstractUncertainValue, n::Int)

Compute the mean of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.mean(x::AbstractUncertainValue, n::Int) = resample(StatsBase.mean, x, n)

"""
	mode(uv::AbstractUncertainValue, n::Int)

Compute the mode of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.mode(x::AbstractUncertainValue, n::Int) = resample(StatsBase.mode, x, n)

"""
	quantile(uv::AbstractUncertainValue, q, n::Int)

Compute the quantile(s) `q` of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.quantile(x::AbstractUncertainValue, q, n::Int) = resample(StatsBase.quantile, x, n, q)

"""
	iqr(uv::AbstractUncertainValue, n::Int)

Compute the interquartile range (IQR), i.e. the 75th percentile minus the 25th percentile,
over an `n`-draw sample of an uncertain value.
"""
StatsBase.iqr(x::AbstractUncertainValue, n::Int) = resample(StatsBase.iqr, x, n, q)


"""
	median(uv::AbstractUncertainValue, n::Int)

Compute the median of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.median(x::AbstractUncertainValue, n::Int) = resample(StatsBase.median, x, n)

"""
	middle(uv::AbstractUncertainValue, n::Int)

Compute the middle of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.middle(x::AbstractUncertainValue, n::Int) = resample(StatsBase.middle, x, n)

"""
	std(uv::AbstractUncertainValue, n::Int)

Compute the standard deviation of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.std(x::AbstractUncertainValue, n::Int) = resample(StatsBase.std, x, n)

"""
	variance(uv::AbstractUncertainValue, n::Int)

Compute the variance of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.var(x::AbstractUncertainValue, n::Int) = resample(StatsBase.var, x, n)

"""
	genmean(uv::AbstractUncertainValue, p, n::Int)

Compute the generalized/power mean with exponent `p` of an uncertain value over an 
`n`-draw sample of it.
"""
StatsBase.genmean(x::AbstractUncertainValue, p, n::Int) = resample(StatsBase.genmean, x, n, p)

"""
	genvar(uv::AbstractUncertainValue, n::Int)

Compute the generalized sample variance of an uncertain value over an 
`n`-draw sample of it.
"""
StatsBase.genvar(x::AbstractUncertainValue, n::Int) = resample(StatsBase.genvar, x, n)

"""
	harmmean(uv::AbstractUncertainValue, n::Int)

Compute the harmonic mean of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.harmmean(x::AbstractUncertainValue, n::Int) = resample(StatsBase.harmmean, x, n)

"""
	geomean(uv::AbstractUncertainValue, n::Int)

Compute the geometric mean of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.geomean(x::AbstractUncertainValue, n::Int) = resample(StatsBase.geomean, x, n)

"""
	kurtosis(uv::AbstractUncertainValue, n::Int, m = mean(uv, n))

Compute the excess kurtosis of an uncertain value over an `n`-draw sample of it,
optionally specifying a center `m`).
"""
StatsBase.kurtosis(x::AbstractUncertainValue, n::Int; m = mean(x, n)) = resample(StatsBase.kurtosis, x, n, m)

"""
	moment(x::AbstractUncertainValue, k, n::Int, m = mean(x, n))

Compute the `k`-th order central moment of an uncertain value over an 
`n`-draw sample of it, optionally specifying a center `m`.
"""
StatsBase.moment(x::AbstractUncertainValue, k, n::Int, m = mean(x, n)) = resample(StatsBase.moment, x, n, k, m)

"""
	percentile(x::AbstractUncertainValue, p, n::Int)

Compute the percentile(s) `p` of an uncertain value over an `n`-draw sample of it.
"""
StatsBase.percentile(x::AbstractUncertainValue, p, n::Int) = resample(StatsBase.percentile, x, n, p)

"""
	renyientropy(uv::AbstractUncertainValue, α, n::Int)

Compute the Rényi (generalized) entropy of order `α` of an uncertain value over an 
`n`-draw sample of it.
"""
StatsBase.renyientropy(x::AbstractUncertainValue, α, n::Int) = resample(StatsBase.quantile, x, n, α)

"""
	rle(x::AbstractUncertainValue, n::Int)

Compute the run-length encoding of an uncertain value over a `n`-draw 
sample of it as a tuple. The first element of the tuple is a vector of 
values of the input and the second is the number of consecutive occurrences of
each element.
"""
StatsBase.rle(x::AbstractUncertainValue, n::Int) = resample(StatsBase.rle, x, n)

"""
	sem(x::AbstractUncertainValue, n::Int)

Compute the standard error of the mean of an uncertain value over a `n`-draw 
sample of it, optionally specifying a center `m`, i.e. 
`sqrt(var(x_draw, corrected = true) / length(x_draw))`.
"""
StatsBase.sem(x::AbstractUncertainValue, n::Int) = resample(StatsBase.sem, x, n)

"""
	skewness(x::AbstractUncertainValue, n::Int, m = mean(x, n))

Compute the standardized skewness of an uncertain value over an `n`-draw sample of 
it, optionally specifying a center `m`.
"""
StatsBase.skewness(x::AbstractUncertainValue, n::Int; m = mean(x, n)) = resample(StatsBase.skewness, x, n, m)

"""
	span(x::AbstractUncertainValue, n::Int)

Compute the span of a collection, i.e. the range `minimum(x):maximum(x)`, of an 
uncertain value over an `n`-draw sample of it.  The minimum and 
maximum of the draws of `x` are computed in one pass using extrema.
"""
StatsBase.span(x::AbstractUncertainValue, n::Int) = resample(StatsBase.span, x, n)

"""
	summarystats(uv::AbstractUncertainValue, n::Int)

Compute summary statistics of an uncertain value over an `n`-draw sample of it. Returns 
a `SummaryStats` object containing the mean, minimum, 25th percentile, median, 
75th percentile, and maximum.
"""
StatsBase.summarystats(x::AbstractUncertainValue, n::Int) = resample(StatsBase.summarystats, x, n)


"""
	totalvar(uv::AbstractUncertainValue, n::Int)

Compute the total sample variance of an uncertain value over an 
`n`-draw sample of it. For a single uncertain value, this is 
equivalent to the sample variance.
"""
StatsBase.totalvar(x::AbstractUncertainValue, n::Int) = resample(StatsBase.totalvar, x, n)
