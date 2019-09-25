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

Obtain a distribution for the Pearson correlation between two uncertain datasets `d1` and `d2`.
This is done by resampling both datasets multiple times and compute the correlation between 
those draws. This yields a distribution of correlation estimates. 

The procedure is as follows. 

1. First, draw a realisation of `d1` according to the distributions furnishing its uncertain values. 
2. Then, draw a realisation `d2` according to its furnishing distributions. 
3. Compute the correlation between those two draws/realisations, both of which are vectors of 
    length `L = length(d1) = length(d2)`. 
4. Repeat the procedure `n` times, drawing `n` separate pairs of realisations of `d1` and `d2`.
    This yields `n` estimates of the correlation between `d1` and `d2`, which is returned as 
    a vector.
"""
Statistics.cor(d1::DT, d2::DT, n::Int; kwargs...) where {DT <: AbstractUncertainValueDataset} =
    [cor(resample(d1), resample(d2), kwargs...) for i = 1:n]

"""
    cor(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset; kwargs...)

Obtain a single estimate of the Pearson correlation between two uncertain datasets `d1` and `d2`.
This is done by resampling both datasets independently, that is: First draw a realisation of 
`d1` according to the distributions furnishing its uncertain values. Then, draw a realisation 
`d2` according to its furnishing distributions. These those two draws/realisations are now 
both vectors of length `L = length(d1) = length(d2)`. Finally, compute the correlation between 
those draws. This yields a single estimates of the correlation between `d1` and `d2`.
"""
Statistics.cor(d1::DT, d2::DT, kwargs...) where {DT <: AbstractUncertainValueDataset} =
    cor(resample(d1), resample(d2), kwargs...)

"""
    cov(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset, n::Int; kwargs...)

Obtain a distribution for the covariance between two uncertain datasets `d1` and `d2`.
This is done by resampling both datasets multiple times and compute the covariance between 
those draws. This yields a distribution of covariance estimates. 

The procedure is as follows. 

1. First, draw a realisation of `d1` according to the distributions furnishing its uncertain values. 
2. Then, draw a realisation `d2` according to its furnishing distributions. 
3. Compute the covariance between those two draws/realisations, both of which are vectors of 
    length `L = length(d1) = length(d2)`. 
4. Repeat the procedure `n` times, drawing `n` separate pairs of realisations of `d1` and `d2`.
    This yields `n` estimates of the covariance between `d1` and `d2`, which is returned as 
    a vector.
"""
Statistics.cov(d1::DT, d2::DT, n::Int; kwargs...) where DT <: AbstractUncertainValueDataset =
    [cov(resample(d1), resample(d2), kwargs...) for i = 1:n]


"""
    cov(d1::AbstractUncertainValueDataset, d2::AbstractUncertainValueDataset; kwargs...)

Obtain a single estimate for the covariance between two uncertain datasets `d1` and `d2`.
This is done by resampling both datasets independently, that is: First draw a realisation of 
`d1` according to the distributions furnishing its uncertain values. Then, draw a realisation 
`d2` according to its furnishing distributions. These those two draws/realisations are now 
both vectors of length `L = length(d1) = length(d2)`. Finally, compute the covariance between 
those draws. This yields a single estimates of the covariance between `d1` and `d2`.
"""
Statistics.cov(d1::DT, d2::DT, kwargs...) where {DT <: AbstractUncertainValueDataset} =
    cov(resample(d1), resample(d2), kwargs...)

export cor, cov, var, std, quantile, mean, median
