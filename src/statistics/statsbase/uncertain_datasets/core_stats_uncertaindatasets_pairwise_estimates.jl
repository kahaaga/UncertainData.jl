"""
    countne(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
            y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
            n::Int)

Estimate a `n`-member distribution on the number of indices at which the elements of 
two collections of uncertain values are not equal. 

This is done by repeating the following procedure `n` times:
    
1. Draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Draw a length-`L` realisation of `y` in the same manner.
3. Count the number of indices at which the elements of the two length-`L`
    draws are not equal.

This yields `n` counts of non-equal values between `n` pairs of independent 
realisations of `x` and `y`. The `n`-member distribution of nonequal-value counts 
is returned as a vector.
"""
StatsBase.countne(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.countne, x, y, n)

"""
    counteq(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
            y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
            n::Int)

Estimate a `n`-member distribution on the number of indices at which the elements of 
two collections of uncertain values are equal.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Count the number of indices at which the elements of the two length-`L`
    draws are equal.

This yields `n` counts of non-equal values between `n` pairs of independent 
realisations of `x` and `y`. The `n`-member distribution of equal-value counts 
is returned as a vector.
"""
StatsBase.counteq(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.counteq, x, y, n)

"""
    corkendall(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
            y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
            n::Int)

Estimate a `n`-member distribution on Kendalls's rank correlation 
coefficient between two collections of uncertain values.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute Kendall's rank correlation coefficient between the two length-`L`
    draws.

This yields `n` computations of Kendall's rank correlation coefficient 
between `n` independent pairs of realisations of `x` and `y`. The 
`n`-member distribution of correlation estimates is returned as a vector.
"""
StatsBase.corkendall(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.corspearman, x, y, n)

"""
    corspearman(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Estimate a `n`-member distribution on Spearman's rank correlation 
coefficient between two collections of uncertain values.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute Spearman's rank correlation coefficient between the two length-`L`
    draws.

This yields `n` estimates of Spearman's rank correlation coefficient 
between `n` independent pairs of realisations of `x` and `y`. The 
`n`-member distribution of correlation estimates is returned as a vector.
"""
StatsBase.corspearman(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.corspearman, x, y, n)

"""
    cor(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Estimate a distribution on Pearson's rank correlation coefficient between 
two collections of uncertain values.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute Pearson's rank correlation coefficient between the two length-`L`
    draws.

This yields `n` estimates of Pearson's rank correlation coefficient 
between `n` independent pairs of realisations of `x` and `y`. The 
`n`-member distribution of correlation estimates is returned as a vector.
"""
StatsBase.cor(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.cor, x, y, n)

"""
    cov(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int; corrected::Bool = true)

Obtain a distribution on the covariance between two collections of 
uncertain values.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the covariance between the two length-`L` draws.

This yields `n` estimates of the covariance between `n` independent pairs 
of realisations of `x` and `y`. The `n`-member distribution of covariance 
estimates is returned as a vector.

If `corrected` is `true` (the default) then the sum is scaled with `n - 1` for 
each pair of draws, whereas the sum is scaled with `n` if `corrected` is `false` 
where `n = length(x)`.
"""
StatsBase.cov(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; corrected::Bool = true) = 
    resample(StatsBase.cov, x, y, n; corrected = corrected)

"""
    crosscor(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
            y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
            [lags], n::Int; demean = true)

Obtain a distribution over the cross correlation between two collections of 
uncertain values.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the cross correlation between the two length-`L` draws.

This yields `n` estimates of the cross correlation between `n` independent pairs 
of realisations of `x` and `y`. The `n`-member distribution of cross correlation
estimates is returned as a vector.

`demean` specifies whether, at each iteration, the respective means of the draws 
should be subtracted from them before computing their cross correlation.

When left unspecified, the `lags` used are `-min(n-1, 10*log10(n))` to `min(n, 10*log10(n))`.

The output is normalized by `sqrt(var(x_draw)*var(y_draw))`. See `crosscov` for the unnormalized form.
"""
function StatsBase.crosscor(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; 
        demean = true)
    
    crosscor_estimates = Vector{Vector{Float64}}(undef, n)
    
    for i = 1:n
        draw_x = float.(resample(x))
        draw_y = float.(resample(y))
        crosscor_estimates[i] = StatsBase.crosscor(draw_x, draw_y, demean = demean)
    end
    
    return crosscor_estimates
end

function StatsBase.crosscor(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, lags, n::Int; 
        demean = true)

    crosscor_estimates = Vector{Vector{Float64}}(undef, n)
    
    for i = 1:n
        draw_x = float.(resample(x))
        draw_y = float.(resample(y))
        crosscor_estimates[i] = StatsBase.crosscor(draw_x, draw_y, lags, demean = demean)
    end
    
    return crosscor_estimates
end

"""
    crosscov(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        [lags], n::Int; demean = true)

Obtain a distribution over the cross covariance function (CCF) between two 
collections of uncertain values.

This is done by repeating the following procedure `n` times:
    
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the CCF between the two length-`L` draws.

This yields `n` estimates of the CCF between `n` independent pairs 
of realisations of `x` and `y`. The `n`-member distribution of CCF estimates
 is returned as a vector.

`demean` specifies whether, at each iteration, the respective means of the draws 
should be subtracted from them before computing their CCF.

When left unspecified, the `lags` used are `-min(n-1, 10*log10(n))` to `min(n, 10*log10(n))`.

The output is not normalized. See `crosscor` for a function with normalization.
"""
function StatsBase.crosscov(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; 
        demean = true)
    
    crosscov_estimates = Vector{Vector{Float64}}(undef, n)
    
    for i = 1:n
        draw_x = float.(resample(x))
        draw_y = float.(resample(y))
        crosscov_estimates[i] = StatsBase.crosscov(draw_x, draw_y, demean = demean)
    end
    
    return crosscov_estimates
end


function StatsBase.crosscov(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, lags, n::Int;
        demean = true)
    
    crosscov_estimates = Vector{Vector{Float64}}(undef, n)
    
    for i = 1:n
        draw_x = float.(resample(x))
        draw_y = float.(resample(y))
        crosscov_estimates[i] = StatsBase.crosscov(draw_x, draw_y, lags, demean = demean)
    end
    
    return crosscov_estimates
end

"""
    gkldiv(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Obtain a distribution over the generalized Kullback-Leibler divergence between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the  generalized Kullback-Leibler divergence between the two 
    length-`L` draws.
    
This yields `n` estimates of the  generalized Kullback-Leibler divergence 
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of generalized Kullback-Leibler divergence estimates is 
returned as a vector.
"""
StatsBase.gkldiv(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.gkldiv, x, y, n)

"""
    kldivergence(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        [b], n::Int)

Obtain a distribution over the Kullback-Leibler divergence between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the Kullback-Leibler divergence between the two 
    length-`L` draws.
    
This yields `n` estimates of the Kullback-Leibler divergence 
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of Kullback-Leibler divergence estimates is 
returned as a vector.

Optionally a real number `b` can be specified such that the divergence is 
scaled by `1/log(b)`.
"""
StatsBase.kldivergence(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.kldivergence, x, y, n)

StatsBase.kldivergence(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, b, n::Int) = 
    resample(StatsBase.kldivergence, x, y, n, b)

"""
    maxad(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Obtain a distribution over the maximum absolute deviation between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the maximum absolute deviation between the two 
    length-`L` draws.
    
This yields `n` estimates of the maximum absolute deviation
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of maximum absolute deviation estimates is 
returned as a vector.
"""
StatsBase.maxad(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.maxad, x, y, n)


"""
    meanad(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Obtain a distribution over the mean absolute deviation between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the mean absolute deviation between the two 
    length-`L` draws.
    
This yields `n` estimates of the mean absolute deviation
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of mean absolute deviation estimates is 
returned as a vector.
"""
StatsBase.meanad(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.meanad, x, y, n)


"""
    msd(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Obtain a distribution over the mean squared deviation between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the mean squared deviation between the two 
    length-`L` draws.
    
This yields `n` estimates of the mean squared deviation
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of mean squared deviation estimates is 
returned as a vector.
"""
StatsBase.msd(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.msd, x, y, n)


"""
    psnr(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        maxv, n::Int)

Obtain a distribution over the peak signal-to-noise ratio (PSNR) between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the PSNR between the two length-`L` draws.
    
This yields `n` estimates of the peak signal-to-noise ratio
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of PSNR estimates is returned as a vector.

The PSNR is computed as `10 * log10(maxv^2 / msd(x_draw, y_draw))`, where `maxv` is 
the maximum possible value `x` or `y` can take
"""
StatsBase.psnr(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, maxv, n::Int) = 
    resample(StatsBase.psnr, x, y, n, maxv)

"""
    rmsd(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int, normalize = false)

Obtain a distribution over the root mean squared deviation between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the root mean squared deviation between the two 
    length-`L` draws.
    
This yields `n` estimates of the root mean squared deviation
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of root mean squared deviation estimates is 
returned as a vector.

The root mean squared deviation is computed as `sqrt(msd(x_draw, y_draw))` 
at each iteration. Optionally, `x_draw` and `y_draw` may be normalised.
"""
StatsBase.rmsd(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int; normalize = false) = 
    resample(StatsBase.rmsd, x, y, n; normalize = normalize)

"""
    sqL2dist(x::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}},
        y::Union{AbstractUncertainValueDataset, Vector{AbstractUncertainValue}}, 
        n::Int)

Obtain a distribution over the squared L2 distance between two 
collections of uncertain values.
    
This is done by repeating the following procedure `n` times:
        
1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Second, draw a length-`L` realisation of `y` in the same manner.
3. Compute the squared L2 distance between the two 
    length-`L` draws.
    
This yields `n` estimates of the squared L2 distance
between `n` independent pairs of realisations of `x` and `y`. The `n`-member 
distribution of squared L2 distance estimates is returned as a vector.

The squared L2 distance is computed as ``\\sum_{i=1}^n |x_i - y_i|^2``.
"""
StatsBase.sqL2dist(x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int) = 
    resample(StatsBase.sqL2dist, x, y, n)