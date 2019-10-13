module UncertainData

using Distributions
using IntervalArithmetic
using RecipesBase
using StatsBase
using StaticArrays
using Statistics
using KernelDensity



display_update = true
version = "v0.6.0"
update_name = "update_$version"

if display_update
if !isfile(joinpath(@__DIR__, update_name))
printstyled(stdout,
"""
\nUpdate message: UncertainData $version
----------------
New features
----------------


### New features

- `UncertainValue` constructor for vectors of zero-dimensional arrays.

New resampling types for uncertain index-value datasets.
- `ConstrainedValueResampling` resampling type. Makes it easier to provide sampling 
    constraints to uncertain value collections, especially if there are many of 
    them and they need different sampling constraints.
- `ConstrainedIndexValueResampling` resampling type. Makes it easier to provide 
    sampling constraints to index-value datasets, especially if there are many of
    them and they need different sampling constraints.
- `SequentialResampling` resampling type.
- `SequentialInterpolationResampling` resampling type. Combines sequential 
    resampling and interpolation (in that order).

and their resampling methods: 

- `resample(x::AbstractUncertainIndexValueDataset, resampling::ConstrainedValueResampling`.
- `resample(x::AbstractUncertainIndexValueDataset, resampling::ConstrainedIndexValueResampling`.
- `resample(x::AbstractUncertainIndexValueDataset, resampling::SequentialResampling`, a
    method that resamples sequentially according to the indices of `x`.
- `resample(x::AbstractUncertainIndexValueDataset, resampling::SequentialInterpolatedResampling`, a 
    method that combines sequential sampling and interpolation (in that order).
"""; color = :light_magenta)
touch(joinpath(@__DIR__, update_name))
end
end

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
include("statistics/UncertainStatistics.jl")

# Plot recipes
include("plot_recipes/UncertainDataPlotRecipes.jl")

# Operations between uncertain UncertainValues
include("uncertain_values/operations/merging.jl")

# Example datasets 
include("example_datasets/example_uvals.jl")

export UncertainScalarBinomialDistributed

end # module
