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
# Resampling uncertain values
#############################################
include("resampling/test_resampling_uncertain_values.jl")

#############################################
# Resampling uncertain tuples
#############################################
include("resampling/test_resampling_uncertain_tuples.jl")

#############################################
# Resampling uncertain datasets
#############################################

# Resampling schemes
include("resampling/resampling_schemes/test_BinnedResampling.jl")
include("resampling/resampling_schemes/test_BinnedWeightedResampling.jl")
include("resampling/resampling_schemes/test_BinnedMeanResampling.jl")
include("resampling/resampling_schemes/test_BinnedMeanWeightedResampling.jl")

include("resampling/resampling_schemes/test_ConstrainedIndexValueResampling.jl")
include("resampling/resampling_schemes/test_ConstrainedValueResampling.jl")
include("resampling/resampling_schemes/test_SequentialResampling.jl")
include("resampling/resampling_schemes/test_SequentialInterpolatedResampling.jl")
include("resampling/resampling_schemes/test_RandomSequences.jl")

# Define an array of uncertain values `uvals` that we can construct datasets from.
include("resampling/define_uncertain_values.jl")

# Resampling vectors of uncertain values
#---------------------------------------
include("resampling/uncertain_vectors/test_resampling_vectors.jl")
include("resampling/uncertain_vectors/test_resampling_vectors_apply_funcs.jl")
include("resampling/uncertain_vectors/test_resampling_vectors_constraints.jl")


# Resampling uncertain datasets
#-------------------------------
include("resampling/uncertain_datasets/test_resampling_datasets.jl")

# Resampling uncertain value datasets
#-------------------------------------
include("resampling/uncertain_datasets/test_resampling_datasets_uncertainvaluedataset.jl")
include("resampling/uncertain_datasets/test_resampling_datasets_uncertainvaluedataset_apply_funcs.jl")
include("resampling/uncertain_datasets/test_resampling_datasets_uncertainvaluedataset_constraints.jl")

# Resampling uncertain index datasets
#-------------------------------------
include("resampling/uncertain_datasets/test_resampling_datasets_uncertainindexdataset.jl")
include("resampling/uncertain_datasets/test_resampling_datasets_uncertainindexdataset_apply_funcs.jl")
include("resampling/uncertain_datasets/test_resampling_datasets_uncertainindexdataset_constraints.jl")

# Resampling uncertain index-value datasets
#-------------------------------------
include("resampling/uncertain_datasets/test_resampling_uncertainindexvaluedataset.jl")
include("resampling/uncertain_datasets/test_resampling_with_schemes.jl")

# Resampling uncertain vectors
#-----------------------------
include("resampling/uncertain_vectors/test_resampling_vectors.jl")

# Special resampling constraints
#-----------------------------
include("resampling/uncertain_datasets/sequential/test_resampling_sequential_increasing.jl")
include("resampling/uncertain_datasets/sequential/test_resampling_sequential_decreasing.jl")

# Resampling inplace.
#-----------------------------
include("resampling/test_resampling_inplace.jl")

#############################################
# Resampling uncertain datasets element-wise
#############################################
include("resampling/uncertain_datasets/test_resampling_abstractuncertainvaluedataset_elwise.jl")


############################################
# Interpolation and binning
#############################################
include("generic_interpolation/test_findall_nan_chunks.jl")
include("generic_interpolation/test_interpolate_nans.jl")
include("resampling/uncertain_datasets/test_interpolation.jl")
include("binning/test_binning.jl")

# Interpolation with resampling schemes
include("resampling/binning/test_bin_BinnedResampling.jl")
include("resampling/binning/test_bin_BinnedWeightedResampling.jl")

#############################
# Mathematics
#############################
include("mathematics/test_mathematics.jl")

############################################
# Uncertain statistics
#############################################
include("uncertain_statistics/uncertain_values/test_core_stats_values_point_estimates.jl")
include("uncertain_statistics/uncertain_values/test_core_stats_values_pair_estimates.jl")

include("uncertain_statistics/uncertain_datasets/test_core_stats_datasets_single_dataset_estimates.jl")
include("uncertain_statistics/uncertain_datasets/test_core_stats_datasets_pairwise_estimates.jl")

include("uncertain_statistics/test_hypothesistests.jl")
#include("uncertain_statistics/test_hypothesistests_timeseries.jl")


#########################################
# Resampling with constraints and models
#########################################

# #####################
# # Resampling schemes
# #####################
# include("resampling/resampling_schemes/test_ConstrainedResampling.jl")

# #######################
# # Sampling constraints
# #######################
include("sampling_constraints/test_sampling_constraints.jl")
include("sampling_constraints/test_constrain_certainvalue.jl")
include("sampling_constraints/test_constrain_population.jl")
include("sampling_constraints/test_constrain_uncertainvalues.jl")
include("sampling_constraints/test_constrain_uncertainvalues_kde.jl")
include("sampling_constraints/test_constrain_uncertaindatasets.jl")
include("sampling_constraints/test_constrain_uncertainvaluedatasets.jl")
include("sampling_constraints/test_constrain_uncertainindexdatasets.jl")

include("sampling_constraints/test_constrain_with_schemes.jl")

