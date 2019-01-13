using Reexport

@reexport module UncertainDatasets
    using ..UncertainValues
    using Distributions
    using IntervalArithmetic
    using RecipesBase
    using StatsBase
    using StaticArrays
    using Statistics

    # The abstract type for all types of dataset holding uncertain values
    include("AbstractUncertainDataset.jl")

    # An abstract type for uncertain datasets containing uncertain values yielding scalar 
    # values when resampled. 
    include("AbstractUncertainValueDataset.jl")
    include("AbstractUncertainIndexDataset.jl")


    # One composite type for indices, another one for values. This distinction allows more 
    # flexibility when applying sampling constraints (some constraints may be meaningful 
    # only for indices, for example).
    include("UncertainValueDataset.jl")
    include("UncertainIndexDataset.jl")

      # A generic type with all the functionality of `AbstractUncertainValueDataset`, if you 
    # can't be bothered with specifying 
    include("UncertainDataset.jl")

    # An abstract type for datasets containing both indices and data values.
    include("AbstractUncertainIndexValueDataset.jl")

    # A composite type with two fields: `indices` and `values`. Both fields may be 
    # any subtype of AbstractUncertainValueDataset. 
    include("UncertainIndexValueDataset.jl")


    # Conversion and promotion 
    include("conversions.jl")

end # module

"""
	UncertainDatasets

A module defining uncertain datasets, which are collections of uncertain values
defined in the `UncertainValues` module.
"""
UncertainDatasets
