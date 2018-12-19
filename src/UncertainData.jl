module UncertainData

using Distributions
using IntervalArithmetic
using RecipesBase
using StatsBase
using StaticArrays
using Statistics
using KernelDensity

# Uncertain values
include("uncertain_values/UncertainValues.jl")

# Uncertain datasets
include("uncertain_datasets/UncertainDatasets.jl")

# Sampling constraints
include("sampling_constraints/SamplingConstraints.jl")

# Resampling
include("resampling/Resampling.jl")

# Uncertain statistics
include("uncertain_statistics/UncertainStatistics.jl")

# Plot recipes
include("plot_recipes/UncertainDataPlotRecipes.jl")


export UncertainScalarBinomialDistributed

end # module
