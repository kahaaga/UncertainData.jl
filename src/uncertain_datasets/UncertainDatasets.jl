using Reexport

@reexport module UncertainDatasets
    using ..UncertainValues
    using Distributions
    using IntervalArithmetic
    using RecipesBase
    using StatsBase
    using StaticArrays
    using Statistics

    include("AbstractUncertainDataset.jl")
    include("AbstractUncertainValueDataset.jl")
    include("AbstractUncertainIndexValueDataset.jl")
    include("UncertainDataset.jl")
    include("UncertainValueDataset.jl")
    include("UncertainIndexValueDataset.jl")
end # module

"""
	UncertainDatasets

A module defining uncertain datasets, which are collections of uncertain values
defined in the `UncertainValues` module.
"""
UncertainDatasets
