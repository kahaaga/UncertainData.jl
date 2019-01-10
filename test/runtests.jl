using Test
using UncertainData
using Distributions
using StaticArrays
using StatsBase
using KernelDensity

# UncertainValues module tests
include("uncertain_values/test_assign_distributions.jl")
include("uncertain_values/test_uncertain_values.jl")
include("uncertain_values/test_minmax.jl")

include("mathematics/test_elementary_mathetmatics_uncertainvalues.jl")
include("mathematics/test_trig_funcs_uncertainvalues.jl")

# UncertainDatasets module tests
include("uncertain_datasets/test_uncertain_datasets.jl")

# SamplingConstraints module tests
include("sampling_constraints/test_constrain_uncertainvalues.jl")
include("sampling_constraints/test_constrain_uncertainvalues_kde.jl")
include("sampling_constraints/test_constrain_uncertaindatasets.jl")

# Resampling module tests
include("resampling/test_resampling_uncertainvalues.jl")
include("resampling/test_resampling_uncertainvalues_kde.jl")
include("resampling/test_resampling_datasets.jl")
include("resampling/test_resampling_with_constraints.jl")


# UncertainStatistics tests
include("uncertain_statistics/test_UncertainStatistics.jl")
