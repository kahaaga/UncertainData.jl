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
mean(uv::AbstractUncertainValue, n::Int) = mean(resample(uv, n))
median(uv::AbstractUncertainValue, n::Int) = median(resample(uv, n))
middle(uv::AbstractUncertainValue, n::Int = 1000) = middle(resample(uv, n))
quantile(uv::AbstractUncertainValue, q, n::Int) = quantile(resample(uv, n), q)
std(uv::AbstractUncertainValue, n::Int) = std(resample(uv, n))
var(uv::AbstractUncertainValue, n::Int) = var(resample(uv, n))


#########################################
# Statistics on `UncertainDataset`s
#########################################
"""
    mean(d::UncertainDataset)

Compute the means of an `UncertainDataset` by finding the mean of
the distribution furnishing each of the uncertain values in it.
"""
mean(d::UncertainDataset) = mean.(d)


"""
    mean(d::UncertainDataset, n::Int)

Compute the means of `n` realisations of an `UncertainDataset`.
"""
mean(d::UncertainDataset, n::Int; kwargs...) = mean.(d, n, kwargs...)

"""
    median(d::UncertainDataset)

Compute the medians of an `UncertainDataset` by finding the mean of
the distribution furnishing each of the uncertain values in it.
"""
medians(d::UncertainDataset) = median.(d)


"""
    median(d::UncertainDataset, n::Int)

Compute the median of `n` realisations of an `UncertainDataset`.
"""
median(d::UncertainDataset, n::Int; kwargs...) = median.(d, n, kwargs...)


"""
    middle(d::UncertainDataset)

Compute the middle values of an `UncertainDataset` by finding the mean of
the distribution furnishing each of the uncertain values in it.
"""
middle(d::UncertainDataset) = middle.(d)


"""
    middle(d::UncertainDataset, n::Int)

Compute the middle of `n` realisations of an `UncertainDataset`.
"""
middle(d::UncertainDataset, n::Int; kwargs...) = middle.(d, n, kwargs...)


"""
    quantile(d::UncertainDataset, p)

Compute the quantile(s) `p `of an `UncertainDataset` by finding the quantiles
of the distributions furnishing each of the uncertain values in it.
"""
quantile(d::UncertainDataset, p) = quantile.(d, p)


"""
    middle(d::UncertainDataset)

Compute the middle values of an `UncertainDataset` by finding the mean of
the distribution furnishing each of the uncertain values in it.
"""
middle(d::UncertainDataset) = middle.(d)


"""
    quantile(d::UncertainDataset, p, n::Int; kwargs...)

Compute the quantile(s) of a `n` realisations of an `UncertainDataset`.
"""
quantile(d::UncertainDataset, p, n::Int; kwargs...) =
    quantile.(d, p, n, kwargs...)


"""
    std(d::UncertainDataset)

Compute the standard deviations of an `UncertainDataset` by finding the standard
deviation for each of the distributions furnishing the uncertain values in it.
"""
std(d::UncertainDataset) = std.(d)


"""
    std(d::UncertainDataset, n::Int; kwargs...)

Compute the standard deviation of an `UncertainDataset` by realising it
`n` times.
"""
std(d::UncertainDataset, n::Int; kwargs...) = std.(d, n, kwargs...)

"""
    var(d::UncertainDataset)

Compute the variance of an `UncertainDataset` by finding the variance for each
of the distributions furnishing the uncertain values in it.
"""
var(d::UncertainDataset) = var.(d)


"""
    var(d::UncertainDataset, n::Int; kwargs...)

Compute the sample variance of an `UncertainDataset` by realising it `n` times.
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
