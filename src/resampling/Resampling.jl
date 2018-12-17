using Reexport

@reexport module Resampling

    import ..UncertainDatasets.AbstractUncertainValueDataset
    import ..UncertainDatasets.UncertainDataset
    import ..UncertainValues.UncertainScalarKDE


    abstract type SamplingConstraint end

    """
        NoConstraint <: SamplingConstraint

    A (non)constraint indicating that
    the full distributions for each uncertain value should be sampled fully
    when sampling an `AbstractUncertainValue` or an `UncertainDataset`.
    """
    struct NoConstraint <: SamplingConstraint end


    #########################################################################
    # Sampling constraints for regular data (i.e. not age/depth/time index...,
    # but the values associated to those indices).
    #########################################################################

    abstract type ValueSamplingConstraint <: SamplingConstraint end


    """
        TruncateLowerQuantile <: ValueSamplingConstraint

    A constraint indicating that the
    distributions for each uncertain value should be truncated below at some
    quantile when sampling an `AbstractUncertainValue` or
    an `UncertainDataset`.
    """
    struct TruncateLowerQuantile <: ValueSamplingConstraint
        lower_quantile::Float64
    end

    """
        TruncateUpperQuantile <: ValueSamplingConstraint

    A constraint indicating that
    the distributions for each uncertain value should be truncated above at some
    quantile when sampling an `AbstractUncertainValue` or
    an `UncertainDataset`.
    """
    struct TruncateUpperQuantile <: ValueSamplingConstraint
        upper_quantile::Float64
    end

    """
        TruncateQuantiles <: ValueSamplingConstraint

    A constraint indicating that
    the distributions for each uncertain value should be truncated above at some
    quantile when sampling an `AbstractUncertainValue` or
    an `UncertainDataset`.
    """
    struct TruncateQuantiles <: ValueSamplingConstraint
        lower_quantile::Float64
        upper_quantile::Float64
    end

    """
        TruncateStd <: ValueSamplingConstraint

    A constraint indicating that
    distributions should be truncated at `nσ` (`n` standard deviations).
    quantile when sampling an `AbstractUncertainValue` or an `UncertainDataset`.
    """
    struct TruncateStd <: ValueSamplingConstraint
        nσ::Int
    end

    """
        TruncateMinimum{T<:Number} <: ValueSamplingConstraint

    A constraint indicating that the
    distributions for each uncertain value should be truncated below at some
    specified minimum value when sampling an `AbstractUncertainValue` or an
    `UncertainDataset`.
    """
    struct TruncateMinimum{T<:Number} <: ValueSamplingConstraint
        min::T
    end

    """
        TruncateMaximum{T<:Number} <: ValueSamplingConstraint

    A constraint indicating that
    the distributions for each uncertain value should be truncated above at some
    specified maximum value when sampling an `AbstractUncertainValue` or an
    `UncertainDataset`.
    """
    struct TruncateMaximum{T<:Number} <: ValueSamplingConstraint
        max::T
    end

    """
        TruncateRange{T<:Number} <: ValueSamplingConstraint

    A constraint indicating that
    the distributions for each uncertain value should be truncated at some range
    `[min, max]`  when sampling an `AbstractUncertainValue` or an
    `UncertainDataset`.
    """
    struct TruncateRange{T} <: ValueSamplingConstraint
        min::T
        max::T
    end



    #########################################################################
    # Sampling constraints for sample indices (time index, age, depth, etc...)
    # Often, these need to be sampled to obey some physical criteria (i.e.,
    # observations are from physical samples lying above each other, so the order
    # of the observations cannot be mixed).
    #########################################################################

    abstract type IndexSamplingConstraint <: SamplingConstraint end

    struct StrictlyIncreasing <: IndexSamplingConstraint end

    struct StrictlyDecreasing <: IndexSamplingConstraint end

    struct StrictlyIncreasingWherePossible <: IndexSamplingConstraint end

    struct StrictlyDecreasingWherePossible<: IndexSamplingConstraint end


    struct ConstrainedUncertainValueDataset <: AbstractUncertainValueDataset
        values::UncertainDataset
        constraints::Vector{SamplingConstraint}
    end

    export
    SamplingConstraint,
    NoConstraint,

    ValueSamplingConstraint,
    TruncateLowerQuantile,
    TruncateUpperQuantile,
    TruncateQuantiles,
    TruncateMinimum,
    TruncateMaximum,
    TruncateRange,
    TruncateStd,

    IndexSamplingConstraint,
    StrictlyIncreasing,
    StrictlyDecreasing

	#####################################################################
	# Fallbacks when encountering incompatible sampling constraints
	#####################################################################
    include("fallback_constraints.jl")

    ###################################
    # Resampling uncertain values
    ###################################
    # Uncertain values based on distributions
    include("resample_uncertainvalues_distributions.jl")

    # Without constraints
    include("resample_uncertainvalues_noconstraints.jl")

    # With constraints
    include("resample_uncertainvalues.jl")
    include("resample_uncertainvalues_kde.jl")

    ###################################
    # Resampling uncertain datasets
    ###################################
    include("resample_uncertaindataset.jl")
    include("resample_uncertaindataset_value.jl")
    include("resample_uncertaindataset_indexvalue.jl")


    export resample
end # module
