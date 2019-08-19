using Reexport

@reexport module Resampling

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

    #########################################
    # Resampling vectors of uncertain values
    #########################################
    include("uncertain_values/resampling_vector_uncertainvalues.jl")

    ###################################
    # Resampling uncertain datasets
    ###################################

    # Supertype for all uncertain value datasets
    include("uncertain_dataset/resample_abstractuncertainvaluedataset.jl")

    # Specialized resampling for each type of dataset.
    include("uncertain_dataset/resample_uncertaindataset.jl")
	include("uncertain_dataset/resample_uncertaindataset_withconstraint.jl")
    include("uncertain_dataset/resample_uncertaindataset_index.jl")
    include("uncertain_dataset/resample_uncertaindataset_value.jl")
    include("uncertain_dataset/resample_uncertaindataset_indexvalue.jl")

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

    export resample, resample_elwise
end # module


"""
	Resampling

A module defining resampling methods for uncertain values defined in the
`UncertainValues` module and uncertain datasets defined in the
`UncertainDatasets` module.
"""
Resampling
