import Base.truncate

################################################################
# Verify that support is not empty after applying constraints
################################################################
"""
    verify_nonempty_support(uv::AbstractUncertainScalarKDE,
        constraint::SamplingConstraint)

Check if the support of the distribution furnishing the uncertain value
is empty after applying the sampling constraint.
"""
verify_nonempty_support(uv::AbstractUncertainScalarKDE,
    constraint::SamplingConstraint)


function verify_nonempty_support(uv::AbstractUncertainScalarKDE,
        constraint::TruncateMaximum)
    if constraint.max < minimum(uv.range)
        minrange = minimum(uv.range)
        truncmax = constraint.max

        e = "constraint.max = $truncmax < minimum(uv.range) = $minrange"
        throw(ArgumentError(e))
    end
end

function verify_nonempty_support(uv::AbstractUncertainScalarKDE,
        constraint::TruncateMinimum)

    if constraint.min > maximum(uv.range)
        truncmin = constraint.min
        maxrange = maximum(uv.range)

        e = "maximum(uv.range) = $maxrange < constraint.min = $truncmin"
        throw(ArgumentError(e))
    end
end

function verify_nonempty_support(uv::AbstractUncertainScalarKDE,
        constraint::TruncateRange)
    truncmin = constraint.min
    truncmax = constraint.max
    minrange = minimum(uv.range)
    maxrange = maximum(uv.range)

    if maxrange < truncmin && minrange > truncmax
        e1 = "maximum(uv.range) = $maxrange < TruncateMinimum.min = $truncmin and "
        e2 = "TruncateMaximum.max = $truncmax < minimum(uv.range) = $minrange"
        throw(ArgumentError(string(e1, e2)))
    elseif maxrange < truncmin
        e = "maximum(uv.range) = $maxrange < TruncateMinimum.min = $truncmin"
        throw(ArgumentError(e))
    elseif minrange > truncmax
        e = "TruncateMaximum.max = $truncmax < minimum(uv.range) = $minrange"
        throw(ArgumentError(e))
    end
end

export verify_nonempty_support




################################################################
# Truncating uncertain values based on kernel density estimates
################################################################

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::SamplingConstraint)

Truncate an uncertain value `uv` furnished by a kernel density estimated
distribution using the supplied `constraint`.
"""
truncate(uv::AbstractUncertainScalarKDE, constraint::SamplingConstraint)

truncate(uv::AbstractUncertainScalarKDE, constraint::NoConstraint) = uv

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile)

Truncate the kernel density estimate to `uv`s distribution using a
`TruncateLowerQuantile` sampling constraint.
"""
function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile)

    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Subset the values and weights (values of the pdf at those values)
    idx_min = idx_lower_quantile
    idx_max = length(uv.pdf)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset. We have to normalise the pdf 
    # here, so that we're still dealing with a probability distribution.
    range_subset, pdf_subset ./ sum(pdf_subset), idx_min, idx_max
end

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)

Truncate the kernel density estimate to `uv`s distribution using a
`TruncateUpperQuantile` sampling constraint.
"""
function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)

    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Subset the values and weights (values of the pdf at those values)
    idx_min = 1
    idx_max = idx_upper_quantile
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset. We have to normalise the pdf 
    # here, so that we're still dealing with a probability distribution.
    range_subset, pdf_subset ./ sum(pdf_subset), idx_min, idx_max
end

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles)

Truncate the kernel density estimate to `uv`s distribution using a
`TruncateQuantiles` sampling constraint.
"""
function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles)

    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Subset the values and weights (values of the pdf at those values)
    idx_min = idx_lower_quantile
    idx_max = idx_upper_quantile
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset. We have to normalise the pdf 
    # here, so that we're still dealing with a probability distribution.
    range_subset, pdf_subset ./ sum(pdf_subset), idx_min, idx_max
end

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum)

Truncate the kernel density estimate to `uv`s distribution using a
`TruncateMinimum` sampling constraint.
"""
function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum;
        test_support = true)

    # Is the support empty after applying the constraint? If so, throw error.
    test_support ? verify_nonempty_support(uv, constraint) : nothing

    # Subset the values and weights (values of the pdf at those values)
    idx_min = findfirst(uv.range .>= constraint.min)
    idx_max = length(uv.pdf)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset. We have to normalise the pdf 
    # here, so that we're still dealing with a probability distribution.
    range_subset, pdf_subset ./ sum(pdf_subset), idx_min, idx_max
end

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum)

Truncate the kernel density estimate to `uv`s distribution using a
`TruncateMaximum` sampling constraint.
"""
function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum;
        test_support = true)

    # Is the support empty after applying the constraint? If so, throw error.
    test_support ? verify_nonempty_support(uv, constraint) : nothing

    # Subset the values and weights (values of the pdf at those values)
    idx_min = 1
    idx_max = findlast(uv.range .<= constraint.max)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset. We have to normalise the pdf 
    # here, so that we're still dealing with a probability distribution.
    range_subset, pdf_subset ./ sum(pdf_subset), idx_min, idx_max
end

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateRange)

Truncate the kernel density estimate to `uv`s distribution using a
`TruncateRange` sampling constraint.
"""
function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateRange;
        test_support = true)

    # Is the support empty after applying the constraint? If so, throw error.
    test_support ? verify_nonempty_support(uv, constraint) : nothing

    # Subset the values and weights (values of the pdf at those values)
    idx_min = findfirst(uv.range .>= constraint.min)
    idx_max = findlast(uv.range .<= constraint.max)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset. We have to normalise the pdf 
    # here, so that we're still dealing with a probability distribution.
    range_subset, pdf_subset ./ sum(pdf_subset), idx_min, idx_max
end

truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateStd) = 
    truncate(uv, fallback(uv, constraint))

export truncate