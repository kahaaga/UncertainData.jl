import ..UncertainValues.TheoreticalDistributionScalarValue

import ..UncertainValues.AbstractUncertainOneParameterScalarValue
import ..UncertainValues.AbstractUncertainTwoParameterScalarValue
import ..UncertainValues.AbstractUncertainThreeParameterScalarValue

import ..UncertainValues.ConstrainedUncertainScalarValueOneParameter
import ..UncertainValues.ConstrainedUncertainScalarValueTwoParameter
import ..UncertainValues.ConstrainedUncertainScalarValueThreeParameter
import ..UncertainValues.TruncatedUncertainScalarKDE
import ..UncertainValues.AbstractUncertainScalarKDE

import Distributions.ValueSupport
import Distributions.Univariate
import Distributions.Distribution
import KernelDensity.UnivariateKDE

import Base.truncate

################################################################
# Truncating uncertain values based on theoretical distributions
################################################################

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::NoConstraint)
    s = support(uv.distribution)
    lower_bound, upper_bound = s.lb, s.ub
    return Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateQuantiles)
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)

    Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateLowerQuantile)
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = support(uv.distribution).ub

    Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateUpperQuantile)
    lower_bound = support(uv.distribution).lb
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)

    Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateMinimum)
    lower_bound = constraint.min
    upper_bound = support(uv.distribution).ub

    Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateMaximum)
    lower_bound = support(uv.distribution).lb
    upper_bound = constraint.max

    Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateRange)
    lower_bound = constraint.min
    upper_bound = constraint.max

    Truncated(uv.distribution, lower_bound, upper_bound)
end

################################################################
# Truncating uncertain values based on kernel density estimates
################################################################

function uncertainscalarKDE(range_subset, pdf_subset, uv::AbstractUncertainScalarKDE)
    TruncatedUncertainScalarKDE(
        UnivariateKDE(range_subset, pdf_subset),
        uv.values,
        range_subset,
        Weights(pdf_subset)
    )
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile)

    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Subset the values and weights (values of the pdf at those values)
    range_subset = uv.range[idx_lower_quantile:end]
    pdf_subset = uv.pdf[idx_lower_quantile:end]

    idx_min = idx_lower_quantile
    idx_max = length(uv.pdf)

    range_subset, pdf_subset, idx_min, idx_max
end


function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)

    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Subset the values and weights (values of the pdf at those values)
    range_subset = uv.range[1:idx_upper_quantile]
    pdf_subset = uv.pdf[1:idx_upper_quantile]

    idx_min = 1
    idx_max = idx_upper_quantile

    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles)

    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Subset the values and weights (values of the pdf at those values)
    range_subset = uv.range[idx_lower_quantile:idx_upper_quantile]
    pdf_subset = uv.pdf[idx_lower_quantile:idx_upper_quantile]

    idx_min = idx_lower_quantile
    idx_max = idx_upper_quantile

    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum)
    idx_min = findfirst(uv.range .>= constraint.min)

    # Subset the values and weights (values of the pdf at those values)
    range_subset = uv.range[idx_min:end]
    pdf_subset = uv.pdf[idx_min:end]

    idx_max = length(uv.pdf)

    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum)
    idx_max = findlast(uv.range .<= constraint.max)

    # Subset the values and weights (values of the pdf at those values)
    range_subset = uv.range[1:idx_max]
    pdf_subset = uv.pdf[1:idx_max]

    idx_min = 1

    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateRange)
    idx_min = findfirst(uv.range .>= constraint.min)
    idx_max = findlast(uv.range .<= constraint.max)

    # Subset the values and weights (values of the pdf at those values)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    range_subset, pdf_subset, idx_min, idx_max
end




#############################################################
# Constraining values
############################################################
"""
    constrain(uv::AbstractUncertainValue, c::SamplingConstraint)

Constrain an uncertain value.

If the value `uv` is represented by a distribution, `constrain` returns a
truncated version of the original distribution.  If the value is represented by
a kernel density estimated distribution, then a new `UncertainScalarKDE`
containing only a subset of the original KDE is returned.
"""
function constrain_theoretical_distribution(uv::AbstractUncertainValue,
    c::SamplingConstraint)

end


function constrain_empirical_distribution(uv::AbstractUncertainScalarKDE,
        constraint::SamplingConstraint)
    range_subset, pdf_subset, idx_min, idx_max = truncate(uv, constraint)

    TruncatedUncertainScalarKDE(
        UnivariateKDE(range_subset, pdf_subset),
        uv.values,
        range_subset,
        Weights(pdf_subset)
        )
end


#############################################################
# Uncertain values represented by theoretical distributions
############################################################

"""
    constrain_theoretical_distribution(
        uv::AbstractUncertainOneParameterScalarValue,
        truncated_dist::Distribution)

Return a constrained (truncated) version of an uncertain value represented
by a one-parameter theoretical distribution.
"""
function constrain_theoretical_distribution(
        uv::AbstractUncertainOneParameterScalarValue,
        truncated_dist::Distribution)

    # Get parameters of original distribution
    p1 = fieldnames(typeof(uv))[2]

    ConstrainedUncertainScalarValueOneParameter(
        truncated_dist,
        getfield(uv, p1)
    )
end

"""
    constrain_theoretical_distribution(
        uv::AbstractUncertainTwoParameterScalarValue,
        truncated_dist::Distribution)

Return a constrained (truncated) version of an uncertain value represented
by a two-parameter theoretical distribution.
"""
function constrain_theoretical_distribution(
        uv::AbstractUncertainTwoParameterScalarValue,
        truncated_dist::Distribution)

    # Get parameters of original distribution
    p1, p2 = (fieldnames(typeof(uv))[2:3]...,)

    ConstrainedUncertainScalarValueTwoParameter(
        truncated_dist,
        getfield(uv, p1),
        getfield(uv, p2)
    )
end

"""
    constrain_theoretical_distribution(
        uv::AbstractUncertainTwoParameterScalarValue,
        truncated_dist::Distribution)

Return a constrained (truncated) version of an uncertain value represented
by a two-parameter theoretical distribution.
"""
function constrain_theoretical_distribution(
        uv::AbstractUncertainThreeParameterScalarValue,
        truncated_dist::Distribution)

    # Get parameters of original distribution
    p1, p2, p3 = (fieldnames(typeof(uv))[2:4]...,)

    ConstrainedUncertainScalarValueThreeParameter(
        truncated_dist,
        getfield(uv, p1),
        getfield(uv, p2),
        getfield(uv, p3)
    )
end

#############################################################
# Generated functions to truncate uncertain values defined by
# theoretical distributions
############################################################
function constrain(uv::TheoreticalDistributionScalarValue,
        constraint::SamplingConstraint)
    constrain_theoretical_distribution(uv, truncate(uv, constraint))
end

function constrain(uv::AbstractUncertainScalarKDE,
        constraint::SamplingConstraint)
    constrain_empirical_distribution(uv, constraint)
end

export
ConstrainedUncertainScalarValueTwoParameter,
ConstrainedUncertainScalarValueThreeParameter,
truncate,
constrain
