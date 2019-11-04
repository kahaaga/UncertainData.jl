using Reexport

@reexport module Resampling

    import ..UVAL_COLLECTION_TYPES
    import ..UncertainDatasets: 
        AbstractUncertainValueDataset,
        UncertainIndexValueDataset
    import ..UncertainValues:
        UncertainValue,
        AbstractUncertainValue

    function resample end

    ###################################
    # Resampling schemes
    ###################################
    include("resampling_schemes/AbstractUncertainDataResampling.jl")
    include("resampling_schemes/BinnedResamplings.jl")
    include("resampling_schemes/ConstrainedResampling.jl")
    include("resampling_schemes/ConstrainedValueResampling.jl")
    include("resampling_schemes/ConstrainedIndexValueResampling.jl")
    include("resampling_schemes/SequentialResampling.jl")
    include("resampling_schemes/SequentialInterpolatedResampling.jl")
    include("resampling_schemes/binned_resamplings.jl")
    include("resampling_schemes/InterpolateAndBin.jl")
    include("resampling_schemes/RandomSequences.jl")

    # Extend some methods to allow easier resampling.
    include("resampling_with_schemes/constrain_with_schemes.jl")

    ###################################
    # Resampling uncertain values
    ###################################
    # Uncertain values based on distributions
    include("uncertain_values/resample_uncertainvalues_distributions.jl")

    # With constraints
    include("uncertain_values/resample_uncertainvalues_theoretical.jl")
    include("uncertain_values/resample_uncertainvalues_theoretical_withconstraints.jl")

    include("uncertain_values/resample_uncertainvalues_kde.jl")
    include("uncertain_values/resample_uncertainvalues_kde_withconstraints.jl")

    include("uncertain_values/resample_certainvalues.jl")
    include("uncertain_values/resample_uncertainvalues_populations.jl")

    include("uncertain_values/resample_measurements.jl")

    #########################################
    # Resampling tuples of uncertain values
    #########################################
    include("uncertain_tuples/uncertain_tuples.jl")

    #########################################
    # Resampling vectors of uncertain values
    #########################################
    include("uncertain_values/resampling_vector_uncertainvalues.jl")

    ###################################
    # Resampling uncertain datasets
    ###################################

    # Element-wise resampling for all subtypes of AbstractUncertainValueDataset
    include("uncertain_dataset/resample_abstractuncertainvaluedataset_elwise.jl")

    # Specialized resampling for each type of dataset.
    include("uncertain_dataset/resample_uncertaindataset_index.jl")
    include("uncertain_dataset/resample_uncertaindataset_value.jl")
    include("uncertain_dataset/resample_uncertaindataset_indexvalue.jl")

    # Resampling vectors of uncertain values 
    include("uncertain_vectors/resample_uncertain_vectors.jl")

    #########################################
    # Ordered resampling
    #########################################
    include("ordered_resampling/resample_sequential.jl")
    include("ordered_resampling/resample_uncertaindataset_strictlyincreasing.jl")
    include("ordered_resampling/resample_uncertaindataset_strictlydecreasing.jl")

    #########################################
    # Resampling with interpolation 
    #########################################
    include("resampling_with_interpolation/resample_linear_interpolation.jl")

    ################################
    # Apply function with resampling
    ################################
    include("apply_func.jl")

    ################################
    # Resampling in-place
    ################################
    include("resampling_inplace.jl")

    ################################
    # Resampling with schemes 
    ################################
    include("resampling_with_schemes/resampling_schemes_binned.jl")
    include("resampling_with_schemes/resampling_schemes_interpolated_binned.jl")
    include("resampling_with_schemes/resampling_schemes_constrained.jl")
    include("resampling_with_schemes/resampling_schemes_sequential.jl")

    export resample, resample!, resample_elwise
end # module


"""
	Resampling

A module defining resampling methods for uncertain values defined in the
`UncertainValues` module and uncertain datasets defined in the
`UncertainDatasets` module.
"""
Resampling
