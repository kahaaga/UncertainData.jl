include("truncation/truncate.jl")

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
