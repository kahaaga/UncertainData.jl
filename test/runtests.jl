using Test
using UncertainData
using Distributions
using StaticArrays
using StatsBase
using KernelDensity


#############################################
# UncertainValues module
#############################################
include("uncertain_values/test_assign_distributions.jl")
include("uncertain_values/test_uncertain_values.jl")
include("uncertain_values/test_minmax.jl")
include("uncertain_values/test_certain_values.jl")
include("uncertain_values/test_merging.jl")

include("uncertain_values/populations/test_UncertainScalarPopulation.jl")
include("uncertain_values/populations/test_ConstrainedUncertainScalarPopulation.jl")

#############################################
# UncertainDatasets module
#############################################
include("uncertain_datasets/test_uncertain_datasets.jl")



#############################################
# Resampling
#############################################
include("resampling/test_resampling_uncertain_values.jl")
include("resampling/test_resampling_uncertain_tuples.jl")
include("resampling/test_resampling_datasets.jl")


############################################
# Interpolation
#############################################
include("resampling/uncertain_datasets/test_interpolation.jl")

#############################
# Mathematics
#############################
include("mathematics/test_mathematics.jl")

############################################
# Uncertain statistics
#############################################
include("uncertain_statistics/uncertain_values/test_core_stats_point_estimates.jl")
include("uncertain_statistics/uncertain_values/test_core_stats_pair_estimates.jl")
include("uncertain_statistics/test_hypothesistests.jl")
#include("uncertain_statistics/test_hypothesistests_timeseries.jl")


#############################################
# Resampling with constraints and models
#############################################

# #############################
# # Resampling schemes
# #############################
# include("resampling/resampling_schemes/test_ConstrainedResampling.jl")

#############################
# Distribution truncation
#############################
#include("sampling_constraints/test_truncate_UncertainScalarPopulation.jl")

# #############################
# # Sampling constraints
# #############################
# include("sampling_constraints/test_sampling_constraints.jl")
# include("sampling_constraints/test_constrain_certainvalue.jl")
# #include("sampling_constraints/test_constrain_population.jl")
# include("sampling_constraints/test_constrain_uncertainvalues.jl")
# include("sampling_constraints/test_constrain_uncertainvalues_kde.jl")
# include("sampling_constraints/test_constrain_uncertaindatasets.jl")
# include("sampling_constraints/test_constrain_uncertainvaluedatasets.jl")
# include("sampling_constraints/test_constrain_uncertainindexdatasets.jl")

