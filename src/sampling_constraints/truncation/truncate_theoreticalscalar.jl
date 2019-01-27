
################################################################
# Truncating uncertain values based on theoretical distributions
# Operating on the union of both TheoreticalFittedUncertainScalar
# and TheoreticalDistributionScalarValue as the type of the
# uncertain value is ok, because Truncated is defined for
# FittedDistribution, which is the .distribution fild for
# fitted scalars.
################################################################
"""
    truncate(uv::TheoreticalDistributionScalarValue, constraint::SamplingConstraint)

Truncate an uncertain value `uv` represented by a theoretical distribution
according to the sampling `constraint`.
"""
Base.truncate(uv::TheoreticalDistributionScalarValue, constraint::SamplingConstraint)


"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::NoConstraint)

Truncate the theoretical distribution furnishing `uv` using a
`NoConstraint` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::NoConstraint)
    s = support(uv.distribution)
    lower_bound, upper_bound = s.lb, s.ub
    return Truncated(uv.distribution, lower_bound, upper_bound)
end

"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateQuantiles)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateQuantiles` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateQuantiles)
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)

    Truncated(uv.distribution, lower_bound, upper_bound)
end

"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateLowerQuantile)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateLowerQuantile` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateLowerQuantile)
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = support(uv.distribution).ub

    Truncated(uv.distribution, lower_bound, upper_bound)
end

"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateUpperQuantile)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateUpperQuantile` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateUpperQuantile)
    lower_bound = support(uv.distribution).lb
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)

    Truncated(uv.distribution, lower_bound, upper_bound)
end


"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateMinumum)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateMinimum` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateMinimum)
    
    lower_bound = constraint.min
    upper_bound = support(uv.distribution).ub

    Truncated(uv.distribution, lower_bound, upper_bound)
end

"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateMaximum)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateMaximum` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateMaximum)

    lower_bound = support(uv.distribution).lb
    upper_bound = constraint.max

    Truncated(uv.distribution, lower_bound, upper_bound)
end

"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateRange)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateRange` sampling constraint.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateRange)
    
    lower_bound = constraint.min
    upper_bound = constraint.max
    Truncated(uv.distribution, lower_bound, upper_bound)
end

"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateStd, n::Int = 10000)

Truncate the theoretical distribution furnishing `uv` using a
`TruncateStd` sampling constraint. 

This functions needs to compute the mean and standard deviation 
of a truncated distribution, so takes an extra optional argument `n_draws` to allow 
this.
"""
function Base.truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateStd)
    
    m = mean(uv.distribution)
    s = std(uv.distribution)
    lower_bound = m - s
    upper_bound = m + s

    Truncated(uv.distribution, lower_bound, upper_bound)
end


export truncate