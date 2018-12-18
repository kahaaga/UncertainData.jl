# Dispatch standard statistical methods on UncertainDatasets

import Statistics.std
import Statistics.var
import Statistics.cor
import Statistics.cov
import Statistics.mean
import Statistics.median
import Statistics.middle
import Statistics.quantile
import ..Resampling.resample

#########################################
# Statistics on `UncertainValue`s
#########################################

StatsBase.mean(uv::AbstractUncertainValue) = mean(uv.distribution)
StatsBase.median(uv::AbstractUncertainValue) = median(uv.distribution)
StatsBase.quantile(uv::AbstractUncertainValue, q) = quantile(uv.distribution, q)
StatsBase.std(uv::AbstractUncertainValue) = std(uv.distribution)
StatsBase.var(uv::AbstractUncertainValue) = var(uv.distribution)


# Providing an extra integer argument n triggers resampling.
"""
	mean(uv::AbstractUncertainValue, n::Int)

Compute the mean of an uncertain value over an `n`-draw sample of it.
"""
mean(uv::AbstractUncertainValue, n::Int) = mean(resample(uv, n))

"""
	median(uv::AbstractUncertainValue, n::Int)

Compute the median of an uncertain value over an `n`-draw sample of it.
"""
median(uv::AbstractUncertainValue, n::Int) = median(resample(uv, n))

"""
	middle(uv::AbstractUncertainValue, n::Int)

Compute the middle of an uncertain value over an `n`-draw sample of it.
"""
middle(uv::AbstractUncertainValue, n::Int = 1000) = middle(resample(uv, n))

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


#########################################
# Statistics on `UncertainDataset`s
#########################################
"""
    mean(d::UncertainDataset)

Computes the element-wise mean of a dataset of uncertain values.
"""
mean(d::UncertainDataset) = mean.(d)


"""
    mean(d::UncertainDataset, n::Int)

Computes the element-wise mean of a dataset of uncertain values. Takes
the mean of an `n`-draw sample for each element.
"""
mean(d::UncertainDataset, n::Int; kwargs...) = mean.(d, n, kwargs...)

"""
    median(d::UncertainDataset)

Computes the element-wise median of a dataset of uncertain values.
"""
medians(d::UncertainDataset) = median.(d)


"""
    median(d::UncertainDataset, n::Int)

Computes the element-wise median of a dataset of uncertain values. Takes
the median of an `n`-draw sample for each element.
"""
median(d::UncertainDataset, n::Int; kwargs...) = median.(d, n, kwargs...)


"""
    middle(d::UncertainDataset)

Computes the element-wise middle of a dataset of uncertain values.
"""
middle(d::UncertainDataset) = middle.(d)


"""
    middle(d::UncertainDataset, n::Int)

Compute the middle of `n` realisations of an `UncertainDataset`.
"""
middle(d::UncertainDataset, n::Int; kwargs...) = middle.(d, n, kwargs...)


"""
    quantile(d::UncertainDataset, p)

Compute element-wise quantile(s) `p `of a dataset consisting of uncertain
values. 
"""
quantile(d::UncertainDataset, p) = quantile.(d, p)


"""
    quantile(d::UncertainDataset, p, n::Int; kwargs...)

Compute element-wise quantile(s) `p `of a dataset consisting of uncertain
values. Takes the quantiles of an `n`-draw sample for each element.
"""
quantile(d::UncertainDataset, p, n::Int; kwargs...) =
    quantile.(d, p, n, kwargs...)


"""
    std(d::UncertainDataset)

Computes the element-wise standard deviation of a dataset of uncertain values.
"""
std(d::UncertainDataset) = std.(d)


"""
    std(d::UncertainDataset, n::Int; kwargs...)

Computes the element-wise standard deviation of a dataset of uncertain values.
Takes the standard deviation of an `n`-draw sample for each element.
"""
std(d::UncertainDataset, n::Int; kwargs...) = std.(d, n, kwargs...)

"""
    var(d::UncertainDataset)

Computess the element-wise sample variance of a dataset of uncertain values.
"""
var(d::UncertainDataset) = var.(d)


"""
    var(d::UncertainDataset, n::Int; kwargs...)

Computes the element-wise sample variance of a dataset of uncertain values.
Takes the sample variance of an `n`-draw sample for each element.
"""
var(d::UncertainDataset, n::Int; kwargs...) = var.(d, n, kwargs...)


"""
    cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets once.
"""
function cor(d1::UncertainDataset, d2::UncertainDataset; kwargs...)
    cor(resample(d1), resample(d2), kwargs...)
end

"""
    cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets `n` times.
"""
function cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)
    [cor(resample(d1), resample(d2), kwargs...) for i = 1:n]
end

"""
    cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising
both datasets once.
"""
function cov(d1::UncertainDataset, d2::UncertainDataset;
        kwargs...)
    cov(resample(d1), resample(d2), kwargs...)
end


"""
    cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising
both datasets `n` times.
"""
function cov(d1::UncertainDataset, d2::UncertainDataset, n::Int;
        kwargs...)
    [cov(resample(d1), resample(d2), kwargs...) for i = 1:n]
end

export
std,
var,
cor,
cov,
mean,
median,
middle,
quantile
