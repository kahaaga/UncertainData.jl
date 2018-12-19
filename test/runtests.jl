using Test
using UncertainData
using Distributions
using StaticArrays
using StatsBase
using KernelDensity

include("test_assign_distributions.jl")

include("test_uncertain_values.jl")

include("test_uncertain_datasets.jl")

include("test_constrain_uncertainvalues.jl")
#include("test_constrain_uncertainvalues_kde.jl")

include("test_resampling_uncertainvalues.jl")
include("test_resampling_uncertainvalues_kde.jl")
include("test_resampling_datasets.jl")

include("uncertain_statistics/test_UncertainStatistics.jl")
