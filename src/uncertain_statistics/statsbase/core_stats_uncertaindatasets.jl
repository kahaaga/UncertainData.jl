import ..Resampling.resample
import ..UncertainValues.AbstractUncertainScalarKDE
import Statistics


#########################################
# Statistics on `AbstractUncertainValueDataset`s
#########################################

"""
    mean(d::AbstractUncertainValueDataset, n::Int)

Computes the element-wise mean of a dataset of uncertain values. Takes
the mean of an `n`-draw sample for each element.
"""
Statistics.mean(d::AbstractUncertainValueDataset, n::Int; kwargs...) =
	[mean(resample(d[i], n), kwargs...) for i = 1:length(d)]

"""
    median(d::AbstractUncertainValueDataset, n::Int)

Computes the element-wise median of a dataset of uncertain values. Takes
the median of an `n`-draw sample for each element.
"""
Statistics.median(d::AbstractUncertainValueDataset, n::Int; kwargs...) =
	[median(resample(d[i], n), kwargs...) for i = 1:length(d)]

"""
    middle(d::AbstractUncertainValueDataset, n::Int)

Compute the middle of `n` realisations of an `AbstractUncertainValueDataset`.
"""
Statistics.middle(d::AbstractUncertainValueDataset, n::Int; kwargs...) =
	[middle(resample(d[i], n), kwargs...) for i = 1:length(d)]


"""
    quantile(d::AbstractUncertainValueDataset, p, n::Int; kwargs...)

Compute element-wise quantile(s) `p `of a dataset consisting of uncertain
values. Takes the quantiles of an `n`-draw sample for each element.
"""
Statistics.quantile(d::AbstractUncertainValueDataset, p, n::Int; kwargs...) =
    [quantile(resample(d[i], n), p, kwargs...) for i = 1:length(d)]

"""
    std(d::AbstractUncertainValueDataset, n::Int; kwargs...)

Computes the element-wise standard deviation of a dataset of uncertain values.
Takes the standard deviation of an `n`-draw sample for each element.
"""
Statistics.std(d::AbstractUncertainValueDataset, n::Int; kwargs...) =
	[std(resample(d[i], n), kwargs...) for i = 1:length(d)]

"""
    var(d::AbstractUncertainValueDataset, n::Int; kwargs...)

Computes the element-wise sample variance of a dataset of uncertain values.
Takes the sample variance of an `n`-draw sample for each element.
"""
Statistics.var(d::AbstractUncertainValueDataset, n::Int; kwargs...) =
	[var(resample(d[i], n), kwargs...) for i = 1:length(d)]

"""
    cor(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `AbstractUncertainValueDataset`s by realising
both datasets `n` times.
"""
Statistics.cor(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int; kwargs...) =
    [cor(resample(d1), resample(d2), kwargs...) for i = 1:n]

"""
    cov(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int; kwargs...)

Compute the covariance between two `AbstractUncertainValueDataset`s by realising
both datasets `n` times.
"""
Statistics.cov(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int; kwargs...) =
    [cov(resample(d1), resample(d2), kwargs...) for i = 1:n]


export cor, cov, var, std, quantile, mean, median
