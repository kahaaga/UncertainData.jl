# Dispatch standard statistical methods on UncertainDatasets

import Statistics.std
import Statistics.var
import Statistics.cor
import Statistics.cov
import Statistics.mean
import Statistics.median
import Statistics.middle
import Statistics.quantile

"""
    std(d::UncertainDataset; kwargs...)

Compute the standard deviation of an `UncertainDataset` by realising it once.
"""
function std(d::UncertainDataset; kwargs...)
    std(realise(d), kwargs...)
end

"""
    std(d::UncertainDataset, n::Int; kwargs...)

Compute the standard deviation of an `UncertainDataset` by realising it
`n` times.
"""
function std(d::UncertainDataset, n::Int; kwargs...)
    std.(realise(d, n), kwargs...)
end


"""
    var(d::UncertainDataset; kwargs...)

Compute the sample variance of an `UncertainDataset` by realising it once.
"""
function var(d::UncertainDataset; kwargs...)
    var(realise(d), kwargs...)
end

"""
    var(d::UncertainDataset, n::Int; kwargs...)

Compute the sample variance of an `UncertainDataset` by realising it `n` times.
"""
function var(d::UncertainDataset, n::Int; kwargs...)
    var(realise(d, n), kwargs...)
end


"""
    cor(d1::UncertainDataset, d2::UncertainDataset; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets once.
"""
function cor(d1::UncertainDataset, d2::UncertainDataset; kwargs...)
    cor(realise(d1), realise(d2), kwargs...)
end

"""
    cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the Pearson correlation between two `UncertainDataset`s by realising
both datasets `n` times.
"""
function cor(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)
    [cor(realise(d1), realise(d2), kwargs...) for i = 1:n]
end

"""
    cov(d1::UncertainDataset, d2::UncertainDataset; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising both
datasets once.
"""
function cov(d1::UncertainDataset, d2::UncertainDataset; kwargs...)
    cov(realise(d1), realise(d2), kwargs...)
end

"""
    cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)

Compute the covariance between two `UncertainDataset`s by realising
both datasets `n` times.
"""
function cov(d1::UncertainDataset, d2::UncertainDataset, n::Int; kwargs...)
    [cov(realise(d1), realise(d2), kwargs...) for i = 1:n]
end

"""
    mean(d::UncertainDataset)

Compute the mean of a single realisation of an `UncertainDataset`.
"""
function mean(d::UncertainDataset)
    mean(realise(d))
end

"""
    mean(d::UncertainDataset, n::Int)

Compute the means of `n` realisations of an `UncertainDataset`.
"""
function mean(d::UncertainDataset, n::Int)
    mean.(realise(d, n))
end

"""
    median(d::UncertainDataset)

Compute the median of a single realisation of an `UncertainDataset`.
"""
function median(d::UncertainDataset)
    median(realise(d))
end

"""
    median(d::UncertainDataset, n::Int)

Compute the median of `n` realisations of an `UncertainDataset`.
"""
function median(d::UncertainDataset, n::Int)
    median.(realise(d, n))
end


"""
    middle(d::UncertainDataset)

Compute the middle of a single realisation of an `UncertainDataset`.
"""
function middle(d::UncertainDataset)
    middle(realise(d))
end


"""
    quantile(d::UncertainDataset, p; kwargs...)

Compute the quantile(s) of a realisation of an `UncertainDataset`.
"""
function quantile(d::UncertainDataset, p; kwargs...)
    quantile(realise(d), kwargs...)
end

"""
    quantile(d::UncertainDataset, p, n::Int; kwargs...)

Compute the quantile(s) of a `n` realisations of an `UncertainDataset`.
"""
function quantile(d::UncertainDataset, p, n::Int; kwargs...)
    [quantile(realise(d), kwargs...) for i = 1:n]
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
