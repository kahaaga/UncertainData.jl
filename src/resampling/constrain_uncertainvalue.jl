import ..UncertainValues.TheoreticalDistributionScalarValue

import ..UncertainValues.AbstractUncertainOneParameterScalarValue
import ..UncertainValues.AbstractUncertainTwoParameterScalarValue
import ..UncertainValues.AbstractUncertainThreeParameterScalarValue

import ..UncertainValues.ConstrainedUncertainScalarValueOneParameter
import ..UncertainValues.ConstrainedUncertainScalarValueTwoParameter
import ..UncertainValues.ConstrainedUncertainScalarValueThreeParameter
import ..UncertainValues.TruncatedUncertainScalarKDE
import ..UncertainValues.AbstractUncertainScalarKDE

import ..UncertainValues.TheoreticalFittedUncertainScalar
import ..UncertainValues.ConstrainedUncertainScalarTheoreticalFit

import Distributions.ValueSupport
import Distributions.Univariate
import Distributions.Distribution
import KernelDensity.UnivariateKDE

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
truncate(uv::TheoreticalDistributionScalarValue, constraint::SamplingConstraint)

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

"""
    truncate(uv::AbstractUncertainScalarKDE, constraint::SamplingConstraint)

Truncate an uncertain value `uv` furnished by a kernel density estimated
distribution using the supplied `constraint`.
"""
truncate(uv::AbstractUncertainScalarKDE, constraint::SamplingConstraint)

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile)

    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Subset the values and weights (values of the pdf at those values)
    idx_min = idx_lower_quantile
    idx_max = length(uv.pdf)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
end


function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)

    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Subset the values and weights (values of the pdf at those values)
    idx_min = 1
    idx_max = idx_upper_quantile
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles)

    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Subset the values and weights (values of the pdf at those values)
    idx_min = idx_lower_quantile
    idx_max = idx_upper_quantile
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum;
        test_support = true)

    # Is the support empty after applying the constraint? If so, throw error.
    test_support ? verify_nonempty_support(uv, constraint) : nothing

    # Subset the values and weights (values of the pdf at those values)
    idx_min = findfirst(uv.range .>= constraint.min)
    idx_max = length(uv.pdf)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
end


function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum;
        test_support = true)

    # Is the support empty after applying the constraint? If so, throw error.
    test_support ? verify_nonempty_support(uv, constraint) : nothing

    # Subset the values and weights (values of the pdf at those values)
    idx_min = 1
    idx_max = findlast(uv.range .<= constraint.max)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
end

function truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateRange;
        test_support = true)

    # Is the support empty after applying the constraint? If so, throw error.
    test_support ? verify_nonempty_support(uv, constraint) : nothing

    # Subset the values and weights (values of the pdf at those values)
    idx_min = findfirst(uv.range .>= constraint.min)
    idx_max = findlast(uv.range .<= constraint.max)
    range_subset = uv.range[idx_min:idx_max]
    pdf_subset = uv.pdf[idx_min:idx_max]

    # Return truncated KDE and the indices used to subset
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

function constrain_kde_distribution(uv::AbstractUncertainScalarKDE,
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
# with parameters fitted to empirical data
############################################################

"""
    constrain_theoretical_fitted_distribution(
        uv::TheoreticalFittedUncertainScalar,
        truncated_dist::Distribution)

Return a constrained (truncated) version of an uncertain value represented
by a theoretical distribution with parameters fitted to empirical data.
"""
function constrain_theoretical_fitted_distribution(
        uv::TheoreticalFittedUncertainScalar,
        truncated_dist::Distribution)

    ConstrainedUncertainScalarTheoreticalFit(FittedDistribution(truncated_dist), uv.values)
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
# Truncate uncertain values
############################################################
"""
    constrain(uv::TheoreticalDistributionScalarValue,
        constraint::SamplingConstraint)

Constrain an uncertain value furnished by a theoretical distribution, given
`constraint`.
"""
function constrain(uv::TheoreticalDistributionScalarValue,
        constraint::SamplingConstraint)
    constrain_theoretical_distribution(uv, truncate(uv, constraint))
end


"""
    constrain(uv::TheoreticalFittedUncertainScalar,
        constraint::SamplingConstraint)

Constrain an uncertain value furnished by a theoretical distribution with
parameters fitted to empirical data, given `constraint`.
"""
function constrain(uv::TheoreticalFittedUncertainScalar,
            constraint::SamplingConstraint)

    truncated_dist = truncate(uv, constraint)
    constrain_theoretical_fitted_distribution(uv, truncated_dist)
end


"""
    constrain(uv::AbstractUncertainScalarKDE,
        constraint::SamplingConstraint)

Constrain an uncertain value `uv` represented by a kernel density estimate,
given `constraint`.
"""
function constrain(uv::AbstractUncertainScalarKDE,
            constraint::SamplingConstraint)
    constrain_kde_distribution(uv, constraint)
end


export
ConstrainedUncertainScalarValueTwoParameter,
ConstrainedUncertainScalarValueThreeParameter,
truncate,
constrain
