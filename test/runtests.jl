using Test
using UncertainData
using Distributions
using StaticArrays

include("test_assign_distributions.jl")
include("test_uncertain_values.jl")
include("test_uncertain_datasets.jl")
include("test_sampling.jl")
include("test_resampling.jl")
include("uncertain_statistics/test_UncertainStatistics.jl")
