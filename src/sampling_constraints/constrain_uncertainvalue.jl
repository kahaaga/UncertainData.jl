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
import ..UncertainValues.FittedDistribution

import ..UncertainValues.getquantileindex

import Distributions.ValueSupport
import Distributions.Univariate
import Distributions.Distribution
import Distributions.support
import Distributions.Truncated
import Distributions: mean, std

import KernelDensity.UnivariateKDE

import StatsBase: quantile, Weights, mean, std

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


"""
    truncate(uv::TheoreticalDistributionScalarValue,
        constraint::NoConstraint)

Truncate the theoretical distribution furnishing `uv` using a
`NoConstraint` sampling constraint.
"""
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
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
function truncate(uv::TheoreticalDistributionScalarValue,
        constraint::TruncateStd; n_draws::Int = 10000)
    m = mean(rand(uv.distribution, n_draws))
    s = std(rand(uv.distribution, n_draws))
    lower_bound = m - s
    upper_bound = m + s

    Truncated(uv.distribution, lower_bound, upper_bound)
end

function truncate(uv::TheoreticalFittedUncertainScalar,
    constraint::TruncateStd)
    m = mean(uv.distribution.distribution)
    s = std(uv.distribution.distribution)
    lower_bound = m - s
    upper_bound = m + s

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

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
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

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
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

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
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

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
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

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
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

    # Return truncated KDE and the indices used to subset
    range_subset, pdf_subset, idx_min, idx_max
end

truncate(uv::AbstractUncertainScalarKDE, constraint::TruncateStd) = 
    truncate(uv, fallback(uv, constraint))



#############################################################
# Constraining values
############################################################
"""
    constrain_kde_distribution(uv::AbstractUncertainScalarKDE,
        constraint::SamplingConstraint)

Return the TruncatedUncertainScalarKDE resulting from applying `constraint`
to `uv`.
"""
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

constrain_kde_distribution(uv::AbstractUncertainScalarKDE, constraint::NoConstraint) = uv

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
	constrain(uv::AbstractUncertainValue, constraint::SamplingConstraint)

Apply the `constraint` and truncate the support of the distribution
furnishing the uncertain value `uv`. Returns a constrained uncertain value.
"""
constrain(uv::AbstractUncertainValue, constraint::SamplingConstraint)


"""
    constrain(uv::TheoreticalDistributionScalarValue,
        constraint::SamplingConstraint) -> TheoreticalDistributionScalarValue

Apply the `constraint` and truncate the support of an uncertain value `uv`
furnished by a theoretical distribution.
"""
function constrain(uv::TheoreticalDistributionScalarValue,
        constraint::SamplingConstraint)
    constrain_theoretical_distribution(uv, truncate(uv, constraint))
end


"""
    constrain(uv::TheoreticalFittedUncertainScalar,
        constraint::SamplingConstraint) -> ConstrainedUncertainScalarTheoreticalFit

Apply the `constraint` and truncate the support of an uncertain value `uv`
furnished by a theoretical distribution where parameters are fitted to empirical
data.
"""
function constrain(uv::TheoreticalFittedUncertainScalar,
            constraint::SamplingConstraint)

    truncated_dist = truncate(uv, constraint)
    constrain_theoretical_fitted_distribution(uv, truncated_dist)
end


"""
    constrain(uv::AbstractUncertainScalarKDE,
        constraint::SamplingConstraint) -> TruncatedUncertainScalarKDE

Apply the `constraint` and truncate the support of an uncertain value `uv`
represented by a kernel density estimate.
"""
function constrain(uv::AbstractUncertainScalarKDE,
            constraint::SamplingConstraint)
    constrain_kde_distribution(uv, constraint)
end


constrain(uvals::Vector{AbstractUncertainValue}, constraint::SamplingConstraint) = 
    [constrain(uval, constraint) for uval in uvals]


function constrain(uvals::Vector{AbstractUncertainValue}, 
                constraints::Vector{SamplingConstraint})
    [constrain(uvals[i], constraints[i]) for i = 1:length(uvals)]
end

export
ConstrainedUncertainScalarValueTwoParameter,
ConstrainedUncertainScalarValueThreeParameter,
truncate,
constrain
