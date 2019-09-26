"""
    countne(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Count the number of indices at which the elements of two independent length-`n`
draws of `x` and for `y` are not equal. 
"""
StatsBase.countne(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.countne, x, y, n)

"""
    counteq(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Count the number of indices at which the elements of two independent length-`n`
draws of `x` and for `y` are equal. 
"""
StatsBase.counteq(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.counteq, x, y, n)

"""
    corkendall(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute Kendalls's rank correlation coefficient between two uncertain values by 
independently drawing `n` samples from `x` and `n` samples from `y`, then computing 
Kendalls's rank correlation coefficient between those length-`n` draws.
"""
StatsBase.corkendall(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.corspearman, x, y, n)

"""
    corspearman(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute Spearman's rank correlation coefficient between two uncertain values by 
independently drawing `n` samples from `x` and `n` samples from `y`, then computing 
the Spearman's rank correlation coefficient between those length-`n` draws.
"""
StatsBase.corspearman(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.corspearman, x, y, n)

"""
    cor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute the Pearson correlation between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, then computing 
the Pearson correlation between those length-`n` draws.
"""
StatsBase.cor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.cor, x, y, n)

"""
    cov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; 
        corrected::Bool = true)

Compute the covariance between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y` , then computing 
the covariance between those length-`n` draws.
"""
StatsBase.cov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; corrected::Bool = true) = 
    resample(StatsBase.cov, x, y, n; corrected = corrected)

"""
    crosscor(x::AbstractUncertainValue, y::AbstractUncertainValue, [lags], 
        n::Int; demean = true)

Compute the cross correlation between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, `x_draw` and `y_draw`, then computing 
the cross correlation between those length-`n` draws. `demean` specifies whether the respective 
means of the `x_draw` and `y_draw` should be subtracted from them before computing 
their cross correlation.

When left unspecified, the `lags` used are `-min(n-1, 10*log10(n))` to `min(n, 10*log10(n))`.

The output is normalized by `sqrt(var(x_draw)*var(y_draw))`. See `crosscov` for the unnormalized form.
"""
StatsBase.crosscor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true) = 
    resample(StatsBase.crosscor, x, y, n; demean = demean)

StatsBase.crosscor(x::AbstractUncertainValue, y::AbstractUncertainValue, lags, n::Int; demean = true) = 
    resample(StatsBase.crosscor, x, y, n, lags; demean = demean)

"""
    crosscov(x::AbstractUncertainValue, y::AbstractUncertainValue, [lags], 
        n::Int; demean = true)

Compute the cross covariance function (CCF) between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, `x_draw` and `y_draw`, then computing 
the cross correlation between those length-`n` draws. `demean` specifies whether the respective 
means of the `x_draw` and `y_draw` should be subtracted from them before computing 
their CCF.

When left unspecified, the `lags` used are `-min(n-1, 10*log10(n))` to `min(n, 10*log10(n))`.

The output is not normalized. See `crosscor` for a function with normalization.
"""
StatsBase.crosscov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true) = 
    resample(StatsBase.crosscov, x, y, n; demean = demean)

StatsBase.crosscov(x::AbstractUncertainValue, y::AbstractUncertainValue, lags, n::Int; demean = true) = 
    resample(StatsBase.crosscov, x, y, n, lags; demean = demean)

"""
    gkldiv(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute the generalized Kullback-Leibler divergence between two uncertain 
values by independently drawing `n` samples from `x` and `n` samples from `y`, 
then computing the generalized Kullback-Leibler divergence between those 
length-`n` draws. 
"""
StatsBase.gkldiv(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.gkldiv, x, y, n)

"""
    kldivergence(x::AbstractUncertainValue, y::AbstractUncertainValue, [b], 
        n::Int)

Compute the Kullback-Leibler divergence between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, then computing the 
Kullback-Leibler divergence between those length-`n` draws. Optionally a real number 
`b` can be specified such that the divergence is scaled by `1/log(b)`.
"""
StatsBase.kldivergence(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.kldivergence, x, y, n)

StatsBase.kldivergence(x::AbstractUncertainValue, y::AbstractUncertainValue, b, n::Int) = 
    resample(StatsBase.kldivergence, x, y, n, b)

"""
    maxad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute the maximum absolute deviation between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, then computing the 
maximum absolute deviation between those length-`n` draws.
"""
StatsBase.maxad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.maxad, x, y, n)


"""
    meanad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute the mean absolute deviation between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, then computing the 
mean absolute deviation between those length-`n` draws.
"""
StatsBase.meanad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.meanad, x, y, n)


"""
    msd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute the mean squared deviation between two uncertain values by independently 
drawing `n` samples from `x` and `n` samples from `y`, then computing the 
mean squared deviation between those length-`n` draws.
"""
StatsBase.msd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.msd, x, y, n)


"""
    psnr(x::AbstractUncertainValue, y::AbstractUncertainValue, maxv, n::Int)

Compute the peak signal-to-noise ratio between two uncertain values by independently 
drawing `n` samples from `x` and from `y`, yielding `x_draw` and `y_draw`, then 
computing the peak signal-to-noise ratio between those length-`n` draws. 

The PSNR is computed as `10 * log10(maxv^2 / msd(x_draw, y_draw))`, where `maxv` is 
the maximum possible value `x` or `y` can take
"""
StatsBase.psnr(x::AbstractUncertainValue, y::AbstractUncertainValue, maxv, n::Int) = 
    resample(StatsBase.psnr, x, y, n, maxv)

"""
    rmsd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int, 
        normalize = false)

Compute the root mean squared deviation between two uncertain values by independently 
drawing `n` samples from `x` and from `y`, yielding `x_draw` and `y_draw`, then 
computing the the root mean squared deviation between those length-`n` draws. 
The root mean squared deviation is computed as `sqrt(msd(x_draw, y_draw))`.
Optionally, `x_draw` and `y_draw` may be normalised.
"""
StatsBase.rmsd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; normalize = false) = 
    resample(StatsBase.rmsd, x, y, n; normalize = normalize)

"""
    sqL2dist(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)

Compute the squared L2 distance between two uncertain values by independently 
drawing `n` samples from `x` and from `y`, then computing the  
squared L2 distance between those length-`n` draws: ``\\sum_{i=1}^n |a_i - b_i|^2``.
"""
StatsBase.sqL2dist(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int) = 
    resample(StatsBase.sqL2dist, x, y, n)