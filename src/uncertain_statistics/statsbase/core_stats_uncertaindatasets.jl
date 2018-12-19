include("core_stats_uncertainvalues.jl")

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
import ..UncertainValues.AbstractUncertainScalarKDE



#########################################
# Statistics on `UncertainDataset`s
#########################################
"""
    mean(d::UncertainDataset)

Computes the element-wise mean of a dataset of uncertain values.
"""
Statistics.mean(d::UncertainDataset) = [mean(d[i]) for i = 1:length(d)]


"""
    mean(d::UncertainDataset, n::Int)

Computes the element-wise mean of a dataset of uncertain values. Takes
the mean of an `n`-draw sample for each element.
"""
Statistics.mean(d::UncertainDataset, n::Int; kwargs...) =
	[mean(resample(d[i], n), kwargs...) for i = 1:length(d)]

"""
    median(d::UncertainDataset)

Computes the element-wise median of a dataset of uncertain values.
"""
Statistics.median(d::UncertainDataset) = [median(d[i]) for i = 1:length(d)]


"""
    median(d::UncertainDataset, n::Int)

Computes the element-wise median of a dataset of uncertain values. Takes
the median of an `n`-draw sample for each element.
"""
Statistics.median(d::UncertainDataset, n::Int; kwargs...) =
	[median(resample(d[i], n), kwargs...) for i = 1:length(d)]


"""
    middle(d::UncertainDataset)

Computes the element-wise middle of a dataset of uncertain values.
"""
Statistics.middle(d::UncertainDataset) = [middle(d[i]) for i = 1:length(d)]


"""
    middle(d::UncertainDataset, n::Int)

Compute the middle of `n` realisations of an `UncertainDataset`.
"""
Statistics.middle(d::UncertainDataset, n::Int; kwargs...) =
	[middle(resample(d[i], n), kwargs...) for i = 1:length(d)]


"""
    quantile(d::UncertainDataset, p)

Compute element-wise quantile(s) `p `of a dataset consisting of uncertain
values.
"""
Statistics.quantile(d::UncertainDataset, p) = [quantile(d[i], p) for i = 1:length(d)]


"""
    quantile(d::UncertainDataset, p, n::Int; kwargs...)

Compute element-wise quantile(s) `p `of a dataset consisting of uncertain
values. Takes the quantiles of an `n`-draw sample for each element.
"""
Statistics.quantile(d::UncertainDataset, p, n::Int; kwargs...) =
    [quantile(resample(d[i], n), p, kwargs...) for i = 1:length(d)]


"""
    std(d::UncertainDataset)

Computes the element-wise standard deviation of a dataset of uncertain values.
"""
Statistics.std(d::UncertainDataset) = [std(d[i]) for i = 1:length(d)]


"""
    std(d::UncertainDataset, n::Int; kwargs...)

Computes the element-wise standard deviation of a dataset of uncertain values.
Takes the standard deviation of an `n`-draw sample for each element.
"""
Statistics.std(d::UncertainDataset, n::Int; kwargs...) =
	[std(resample(d[i], n), kwargs...) for i = 1:length(d)]

"""
    var(d::UncertainDataset)

Computess the element-wise sample variance of a dataset of uncertain values.
"""
Statistics.var(d::UncertainDataset) = [var(d[i]) for i = 1:length(d)]


"""
    var(d::UncertainDataset, n::Int; kwargs...)

Computes the element-wise sample variance of a dataset of uncertain values.
Takes the sample variance of an `n`-draw sample for each element.
"""
Statistics.var(d::UncertainDataset, n::Int; kwargs...) =
	[var(resample(d[i], n), kwargs...) for i = 1:length(d)]


"""
    cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets once.
"""
Statistics.cor(d1::UncertainDataset, d2::UncertainDataset; kwargs...) =
    cor(resample(d1), resample(d2), kwargs...)

"""
    cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets `n` times.
"""
Statistics.cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...) =
    [cor(resample(d1), resample(d2), kwargs...) for i = 1:n]

"""
    cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising
both datasets once.
"""
Statistics.cov(d1::UncertainDataset, d2::UncertainDataset; kwargs...) =
    cov(resample(d1), resample(d2), kwargs...)


"""
    cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising
both datasets `n` times.
"""
Statistics.cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...) =
    [cov(resample(d1), resample(d2), kwargs...) for i = 1:n]
