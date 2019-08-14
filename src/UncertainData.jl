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

# Interpolation and interpolation grids 
include("interpolation/InterpolationsAndGrids.jl")

# Resampling
include("resampling/Resampling.jl")

# Mathematics 
include("mathematics/UncertainMathematics.jl")

# Uncertain statistics
include("uncertain_statistics/UncertainStatistics.jl")

# Plot recipes
include("plot_recipes/UncertainDataPlotRecipes.jl")

# Operations between uncertain UncertainValues
include("uncertain_values/operations/merging.jl")

export UncertainScalarBinomialDistributed

end # module
