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
include("uncertain_values/test_certain_values.jl")
include("uncertain_values/test_populations.jl")
include("uncertain_values/test_merging.jl")


# UncertainDatasets module tests
include("uncertain_datasets/test_uncertain_datasets.jl")

#############################
# Sampling constraints
#############################
include("sampling_constraints/test_sampling_constraints.jl")
include("sampling_constraints/test_constrain_certainvalue.jl")
include("sampling_constraints/test_constrain_population.jl")
include("sampling_constraints/test_constrain_uncertainvalues.jl")
include("sampling_constraints/test_constrain_uncertainvalues_kde.jl")
include("sampling_constraints/test_constrain_uncertaindatasets.jl")
include("sampling_constraints/test_constrain_uncertainvaluedatasets.jl")
include("sampling_constraints/test_constrain_uncertainindexdatasets.jl")

#############################
# Resampling uncertain values
#############################
include("resampling/uncertain_values/test_resampling_certain_value.jl")
include("resampling/uncertain_values/test_resampling_uncertainvalues.jl")
include("resampling/uncertain_values/test_resampling_uncertainvalues_kde.jl")

#############################################
# Resampling uncertain datasets element-wise
#############################################
include("resampling/uncertain_datasets/test_resampling_abstractuncertainvaluedataset_elwise.jl")

#############################################
# Resampling
#############################################

# Resampling uncertain datasets
#-------------------------------
include("resampling/uncertain_datasets/test_resampling_datasets.jl")

# Resampling uncertain value datasets
#-------------------------------------
include("resampling/uncertain_datasets/test_resampling_uncertainvaluedataset.jl")

# Resampling uncertain index datasets
#-------------------------------------
include("resampling/uncertain_datasets/test_resampling_uncertainindexdataset.jl")

# Resampling uncertain index-value datasets
#-------------------------------------
include("resampling/uncertain_datasets/test_resampling_uncertainindexvaluedataset.jl")

# Resampling uncertain vectors
#-----------------------------
include("resampling/uncertain_vectors/test_resampling_vectors.jl")

# Special resampling constraints
#-----------------------------
include("resampling/uncertain_datasets/sequential/test_resampling_sequential_increasing.jl")
include("resampling/uncertain_datasets/sequential/test_resampling_sequential_decreasing.jl")

############################################
# Interpolation
#############################################
include("resampling/uncertain_datasets/test_interpolation.jl")

############################################
# Uncertain statistics
#############################################
include("uncertain_statistics/test_UncertainStatistics.jl")

#############################
# Mathematics
#############################
include("mathematics/test_mathematics.jl")
