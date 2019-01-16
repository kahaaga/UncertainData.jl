using Reexport

@reexport module Resampling

    
    ###################################
    # Resampling uncertain values
    ###################################
    # Uncertain values based on distributions
    include("resample_uncertainvalues_distributions.jl")

    # With constraints
    include("resample_uncertainvalues_theoretical.jl")
    include("resample_uncertainvalues_theoretical_withconstraints.jl")

    include("resample_uncertainvalues_kde.jl")
    include("resample_uncertainvalues_kde_withconstraints.jl")

    include("resample_certainvalues.jl")

    #########################################
    # Resampling vectors of uncertain values
    #########################################
    include("resampling_vector_uncertainvalues.jl")

    ###################################
    # Resampling uncertain datasets
    ###################################
    include("resample_uncertaindataset.jl")
	include("resample_uncertaindataset_withconstraint.jl")

    include("resample_uncertaindataset_value.jl")
    include("resample_uncertaindataset_indexvalue.jl")

    # Ordered resampling 
    include("ordered_resampling/resample_sequential.jl")
    include("ordered_resampling/resample_uncertaindataset_strictlyincreasing.jl")
    include("ordered_resampling/resample_uncertaindataset_strictlydecreasing.jl")

    export resample
end # module


"""
	Resampling

A module defining resampling methods for uncertain values defined in the
`UncertainValues` module and uncertain datasets defined in the
`UncertainDatasets` module.
"""
Resampling
