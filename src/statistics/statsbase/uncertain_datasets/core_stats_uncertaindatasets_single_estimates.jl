import StatsBase

"""
    median(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the median of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the median is computed for each of those length-`L`
realisations, yielding a distribution of median estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the median for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the median of `x`, which is returned as 
    a vector.
"""
function StatsBase.median(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.median, x, n)
end

"""
    mean(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the mean of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the mean is computed for each of those length-`L`
realisations, yielding a distribution of mean estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the mean for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the mean of `x`, which is returned as 
    a vector.
"""
function StatsBase.mean(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.mean, x, n)
end

"""
    mode(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the mode of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the mode is computed for each of those length-`L`
realisations, yielding a distribution of mode estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the mode for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the mode of `x`, which is returned as 
    a vector.
"""
function StatsBase.mode(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.mode, x, n)
end

"""
    quantile(x::UVAL_COLLECTION_TYPES, q, n::Int)

Obtain a distribution for the quantile(s) `q` of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the quantile is computed for each of those length-`L`
realisations, yielding a distribution of quantile estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the quantile for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the quantile of `x`, which is returned as 
    a vector.
"""
function StatsBase.quantile(x::UVAL_COLLECTION_TYPES, q, n::Int) 
    resample(StatsBase.quantile, x, n, q)
end


"""
    iqr(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the interquartile range (IQR), i.e. the 75th 
percentile minus the 25th percentile, of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the IQR is computed for each of those length-`L`
realisations, yielding a distribution of IQR estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the IQR for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the IQR of `x`, which is returned as 
    a vector.
"""
function StatsBase.iqr(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.iqr, x, n)
end

"""
    middle(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the middle of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the middle is computed for each of those length-`L`
realisations, yielding a distribution of middle estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the middle for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the middle of `x`, which is returned as 
    a vector.
"""
function StatsBase.middle(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.middle, x, n)
end

"""
    std(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the standard deviation of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the standard deviation is computed for each of those length-`L`
realisations, yielding a distribution of standard deviation estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the std for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the standard deviation of `x`, which is returned as 
    a vector.
"""
function StatsBase.std(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.std, x, n)
end

"""
    var(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the variance of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the variance is computed for each of those length-`L`
realisations, yielding a distribution of variance estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the variance for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the variance of `x`, which is returned as 
    a vector.
"""
function StatsBase.var(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.var, x, n)
end

"""
    genmean(x::UVAL_COLLECTION_TYPES, p, n::Int)

Obtain a distribution for the generalized/power mean with exponent `p` of a 
collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the generalized mean is computed for each of those length-`L`
realisations, yielding a distribution of generalized mean estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the generalized mean for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the generalized mean of `x`, which is returned as 
    a vector.
"""
function StatsBase.genmean(x::UVAL_COLLECTION_TYPES, p, n::Int) 
    resample(StatsBase.genmean, x, n, p)
end

"""
    genvar(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the generalized sample variance of a collection of 
uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the generalized sample variance is computed for each of 
those length-`L`
realisations, yielding a distribution of generalized sample variance estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the generalized sample variance for the realisation, which is a 
    vector of length `L`.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the generalized sample variance of `x`, 
    which is returned as a vector.
"""
function StatsBase.genvar(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.genvar, x, n)
end

"""
    harmmean(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the harmonic mean of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the harmonic mean is computed for each of those length-`L`
realisations, yielding a distribution of harmonic mean estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the harmonic mean for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the harmonic mean of `x`, which is returned as 
    a vector.
"""
function StatsBase.harmmean(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.harmmean, x, n)
end

"""
    geomean(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the geometric mean of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the geometric mean is computed for each of those length-`L`
realisations, yielding a distribution of geometric mean estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the geometric mean for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the geometric mean of `x`, which is returned as 
    a vector.
"""
function StatsBase.geomean(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.geomean, x, n)
end

"""
    kurtosis(x::UVAL_COLLECTION_TYPES, n::Int, f = StatsBase.mean)

Obtain a distribution for the kurtosis of a collection of uncertain values.

This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the kurtosis is computed for each of those length-`L`
realisations, yielding a distribution of kurtosis estimates. 

Optionally, a center function `f` can be specified. This function is used 
to compute the center of each draw, i.e. for the i-th draw, call
`StatsBase.kurtosis(draw_i, f(draw_i))`.

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the kurtosis for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the kurtosis of `x`, which is returned as a vector.
"""
function StatsBase.kurtosis(x::UVAL_COLLECTION_TYPES, n::Int, f = StatsBase.mean) 
    
    kurtosis_estimates = zeros(Float64, n)

    for i = 1:n
        draw = resample(x)
        kurtosis_estimates[i] = StatsBase.kurtosis(draw, f(draw))
    end

    return kurtosis_estimates
end

"""
    moment(x::UVAL_COLLECTION_TYPES, k, n::Int)

Obtain a distribution for the `k`-th order central moment of a collection 
of uncertain values.

This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the `k`-th order central moment is computed for each 
of those length-`L`realisations, yielding a distribution of `k`-th 
order central moment estimates. 

The procedure is as follows. 

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the `k`-th order central moment for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the `k`-th order central moment of `x`, 
    which is returned as a vector.
"""
function StatsBase.moment(x::UVAL_COLLECTION_TYPES, k, n::Int) 
    resample(StatsBase.moment, x, n, k)
end

"""
    percentile(x::UVAL_COLLECTION_TYPES, p, n::Int)

Obtain a distribution for the percentile(s) `p` of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the percentile is computed for each of those length-`L`
realisations, yielding a distribution of percentile estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the percentile for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the percentile of `x`, which is returned as 
    a vector.
"""
function StatsBase.percentile(x::UVAL_COLLECTION_TYPES, p, n::Int) 
    resample(StatsBase.percentile, x, n, p)
end

"""
    renyientropy(x::UVAL_COLLECTION_TYPES, α, n::Int)

Obtain a distribution for the Rényi (generalized) entropy of 
order `α` of a collection of uncertain values.

This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the generalized entropy is computed for each 
of those length-`L`realisations, yielding a distribution of 
generalized entropy estimates. 

The procedure is as follows. 

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the Rényi (generalized) entropy of order `α` for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the Rényi (generalized) entropy of 
    order `α` of `x`, which is returned as a vector.
"""
function StatsBase.renyientropy(x::UVAL_COLLECTION_TYPES, α, n::Int) 
    resample(StatsBase.renyientropy, x, n, α)
end

"""
    rle(x::UVAL_COLLECTION_TYPES, α, n::Int)

Obtain a distribution for the run-length encoding of a 
collection of uncertain values.

This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the run-length encoding is computed for each 
of those length-`L`realisations, yielding a distribution of 
run-length encoding estimates. 

Returns a vector of tuples of run-length encodings.

The procedure is as follows. 

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the run-length encoding for the realisation. This gives a 
    tuple, where the first element of the tuple is a vector of 
    values of the input and the second is the number of consecutive occurrences of
    each element.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the run-length encoding of `x`, 
    which is returned as a vector of the run-length encoding tuples.
"""
function StatsBase.rle(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.rle, x, n)
end

"""
    sem(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the standard error of the mean of a 
collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the standard error of the mean is computed for 
each of those length-`L`
realisations, yielding a distribution of standard error of the 
mean estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the standard error of the mean for the realisation, which is 
    a vector of length `L`.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the standard error of the mean of `x`, 
    which is returned as a vector.
"""
function StatsBase.sem(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.sem, x, n)
end


"""
    skewness(x::UVAL_COLLECTION_TYPES, n::Int, f = StatsBase.mean)

Obtain a distribution for the skewness of a collection of uncertain values.

This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the skewness is computed for each of those length-`L`
realisations, yielding a distribution of skewness estimates. 

Optionally, a center function `f` can be specified. This function is used 
to compute the center of each draw, i.e. for the i-th draw, call
`StatsBase.skewness(draw_i, f(draw_i))`.

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the skewness for the realisation.
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the skewness of `x`, 
    which is returned as a vector.
"""
function StatsBase.skewness(x::UVAL_COLLECTION_TYPES, n::Int, f = StatsBase.mean) 
    skewness_estimates = zeros(Float64, n)

    for i = 1:n
        draw = resample(x)
        skewness_estimates[i] = StatsBase.skewness(draw, f(draw))
    end

    return skewness_estimates
end

"""
    span(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the span of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the span is computed for each of those length-`L`
realisations, yielding a distribution of span estimates. 

Returns a length-`L` vector of `span`s, where the i-th span is the range
`minimum(draw_x_i):maximum(draw_x_i)`.

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the span for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the span of `x`, which is returned as 
    a vector.
"""
function StatsBase.span(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.span, x, n)
end

"""
    totalvar(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the total variance of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the total variance is computed for each of those length-`L`
realisations, yielding a distribution of total variance estimates. 

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the total variance for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the total variance of `x`, which is returned as 
    a vector.
"""
function StatsBase.totalvar(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.totalvar, x, n)
end

"""
    summarystats(x::UVAL_COLLECTION_TYPES, n::Int)

Obtain a distribution for the summary statistics of a collection of uncertain values.
This is done by first drawing `n` length-`L` realisations of `x`, where 
`L = length(x)`. Then, the summary statistics is computed for each of those length-`L`
realisations, yielding a distribution of summary statistics estimates. 

Returns a length-`L` vector of `SummaryStats` objects containing the mean, minimum, 
25th percentile, median, 75th percentile, and maximum for each draw of `x`.

Detailed steps:

1. First, draw a length-`L` realisation of `x` by drawing one random 
    number from  each uncertain value furnishing the dataset. The draws are 
    independent, so that no element-wise dependencies (e.g. sequential
    correlations) that are not already present in the data are introduced in 
    the realisation.
2. Compute the summary statistics for the realisation, which is a vector of length `L`
3. Repeat the procedure `n` times, drawing `n` independent realisations of `x`.
    This yields `n` estimates of the summary statistics of `x`, which is returned as 
    a vector.
"""
function StatsBase.summarystats(x::UVAL_COLLECTION_TYPES, n::Int) 
    resample(StatsBase.summarystats, x, n)
end