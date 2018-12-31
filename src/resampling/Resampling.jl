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

    ###################################
    # Resampling uncertain datasets
    ###################################
    include("resample_uncertaindataset.jl")
	include("resample_uncertaindataset_withconstraint.jl")

    include("resample_uncertaindataset_value.jl")
    include("resample_uncertaindataset_indexvalue.jl")


    export resample
end # module


"""
	Resampling

A module defining resampling methods for uncertain values defined in the
`UncertainValues` module and uncertain datasets defined in the
`UncertainDatasets` module.
"""
Resampling
