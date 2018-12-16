# Dispatch standard statistical methods on UncertainDatasets

import Statistics.std
import Statistics.var
import Statistics.cor
import Statistics.cov
import Statistics.mean
import Statistics.median
import Statistics.middle
import Statistics.quantile

#########################################
# Statistics on `UncertainValue`s
#########################################

mean(uv::AbstractUncertainValue, n::Int = 1000) = mean(resample(uv, n))
median(uv::AbstractUncertainValue, n::Int = 1000) = median(resample(uv, n))
middle(uv::AbstractUncertainValue, n::Int = 1000) = middle(resample(uv, n))
quantile(uv::AbstractUncertainValue, q, n::Int = 1000) = quantile(resample(uv, n), q)
std(uv::AbstractUncertainValue, n::Int = 1000) = std(resample(uv, n))
var(uv::AbstractUncertainValue, n::Int = 1000) = var(resample(uv, n))


#########################################
# Statistics on `UncertainDataset`s
#########################################
"""
    mean(d::UncertainDataset, n::Int)

Compute the means of `n` realisations of an `UncertainDataset`.
"""
mean(d::UncertainDataset, n::Int = 1000; kwargs...) = mean.(d, n, kwargs...)

"""
    median(d::UncertainDataset, n::Int)

Compute the median of `n` realisations of an `UncertainDataset`.
"""
median(d::UncertainDataset, n::Int = 1000; kwargs...) = median.(d, n, kwargs...)

"""
    middle(d::UncertainDataset, n::Int)

Compute the middle of `n` realisations of an `UncertainDataset`.
"""
middle(d::UncertainDataset, n::Int = 1000; kwargs...) = middle.(d, n, kwargs...)

"""
    quantile(d::UncertainDataset, p, n::Int; kwargs...)

Compute the quantile(s) of a `n` realisations of an `UncertainDataset`.
"""
quantile(d::UncertainDataset, p, n::Int = 1000; kwargs...) =
    quantile.(d, p, n, kwargs...)

"""
    std(d::UncertainDataset, n::Int; kwargs...)

Compute the standard deviation of an `UncertainDataset` by realising it
`n` times.
"""
std(d::UncertainDataset, n::Int = 1000; kwargs...) = std.(d, n, kwargs...)

"""
    var(d::UncertainDataset, n::Int; kwargs...)

Compute the sample variance of an `UncertainDataset` by realising it `n` times.
"""
var(d::UncertainDataset, n::Int = 1000; kwargs...) = var.(d, n, kwargs...)


"""
    cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets `n` times.
"""
function cor(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; kwargs...)
    [cor(resample(d1), resample(d2), kwargs...) for i = 1:n]
end

"""
    cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising
both datasets `n` times.
"""
function cov(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000; kwargs...)
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
