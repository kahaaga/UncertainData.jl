import StatsBase.skewness
import StatsBase.kurtosis
import StatsBase.moment

"""
    skewness(d::UncertainDataset)

Compute the standardized skewness of a realisation of an `UncertainDataset` by
realising it once.
"""
function skewness(d::UncertainDataset)
    skewness(realise(d))
end

"""
    skewness(d::UncertainDataset, n::Int)

Compute the standardized skewness of an `UncertainDataset` by realising it `n`
times.
"""
function skewness(d::UncertainDataset, n::Int)
    skewness.(realise(d, n))
end


"""
    kurtosis(d::UncertainDataset)

Compute the excess kurtosis of a realisation of an `UncertainDataset` by
realising it once.
"""
function kurtosis(d::UncertainDataset)
    kurtosis(realise(d))
end

"""
    kurtosis(d::UncertainDataset, n::Int)

Compute the excess kurtosis of an `UncertainDataset` by realising it `n`
times.
"""
function kurtosis(d::UncertainDataset, n::Int)
    kurtosis.(realise(d, n))
end



export
skewness,
kurtosis,
moment
