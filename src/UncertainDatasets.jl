module UncertainDatasets

using Distributions
using IntervalArithmetic
using RecipesBase
using StatsBase
using StaticArrays
using Statistics

include("distributions/assign_dist.jl")
include("uncertain_values/uncertain_values.jl")
include("uncertain_datasets/uncertain_datasets.jl")
include("sampling/sampling.jl")

end # module
