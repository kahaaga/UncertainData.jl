module UncertainData

using Distributions
using IntervalArithmetic
using RecipesBase
using StatsBase
using StaticArrays
using Statistics
using KernelDensity

# UncertainValues submodule
include("uncertain_values/uncertain_values.jl")

# UncertainDataset submodule
include("uncertain_datasets/uncertain_datasets.jl")

# Resampling
include("resampling/Resampling.jl")


# Uncertain statistics
include("uncertain_statistics/UncertainStatistics.jl")

# Plot recipes
include("plot_recipes/recipes_uncertainvalues.jl")

end # module
