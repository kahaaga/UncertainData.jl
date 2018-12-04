import StatsBase.geomean
import StatsBase.harmmean
import StatsBase.genmean

"""
    geomean(d::UncertainDataset)

Compute the geometric mean of a realisation of an `UncertainDataset` by
realising it once.
"""
function geomean(d::UncertainDataset)
    geomean(realise(d))
end

"""
    geomean(d::UncertainDataset, n::Int)

Compute the geometric mean of a realisation of an `UncertainDataset` by
realising it once.
"""
function geomean(d::UncertainDataset, n::Int)
    [geomean(realise(d)) for i = 1:n]
end

"""
    harmmean(d::UncertainDataset)

Compute the harmonic mean of a realisation of an `UncertainDataset` by
realising it once.
"""
function harmmean(d::UncertainDataset)
    harmmean(realise(d))
end

"""
    harmmean(d::UncertainDataset, n::Int)

Compute the harmonic mean of an `UncertainDataset` by realising it `n` times.
"""
function harmmean(d::UncertainDataset, n::Int)
    harmmean.(realise(d, n))
end

"""
    genmean(d::UncertainDataset, p)

Compute the generalised/power mean with exponent `p` of a realisation of an
`UncertainDataset` by realising it once.
"""
function genmean(d::UncertainDataset, p)
    genmean(realise(d), p)
end

"""
    genmean(d::UncertainDataset, p, n::Int)

Compute the generalised/power mean with exponent `p` of an `UncertainDataset`
by realising it `n` times.
"""
function genmean(d::UncertainDataset, p, n::Int)
    genmean.(realise(d, n), p)
end




export
geomean,
harmmean,
genmean
