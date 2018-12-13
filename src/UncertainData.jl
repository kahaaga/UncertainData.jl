module UncertainData

using Distributions
using IntervalArithmetic
using RecipesBase
using StatsBase
using StaticArrays
using Statistics

# UncertainValues submodule
include("uncertain_values/uncertain_values.jl")


# UncertainDataset submodule
include("uncertain_datasets/uncertain_datasets.jl")

resample(uv::AbstractUncertainValue) = UncertainValues.resample(uv)
resample(uv::AbstractUncertainValue, n::Int) = UncertainValues.resample(uv, n)
resample(uv::AbstractUncertainDataset) = UncertainDatasets.resample(uv)
resample(uv::AbstractUncertainDataset, n::Int) = UncertainDatasets.resample(uv, n)

# Uncertain statistics 
include("uncertain_statistics/UncertainStatistics.jl")


export resample
# Uncertain statistics
#include("uncertain_statistics/UncertainStatistics.jl")

end # module
