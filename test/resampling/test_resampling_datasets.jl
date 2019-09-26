# Define an array of uncertain values `uvals` that we can construct datasets from.
include("define_uncertain_values.jl")

# Resampling vectors of uncertain values
#---------------------------------------
include("uncertain_vectors/test_resampling_vectors.jl")
include("uncertain_vectors/test_resampling_vectors_apply_funcs.jl")
#include("uncertain_vectors/test_resampling_vectors_constraints.jl")


# Resampling uncertain datasets
#-------------------------------
include("uncertain_datasets/test_resampling_datasets.jl")

# Resampling uncertain value datasets
#-------------------------------------
include("uncertain_datasets/test_resampling_datasets_uncertainvaluedataset.jl")
include("uncertain_datasets/test_resampling_datasets_uncertainvaluedataset_apply_funcs.jl")
#include("uncertain_datasets/test_resampling_datasets_uncertainvaluedataset_constraints.jl")

# Resampling uncertain index datasets
#-------------------------------------
include("uncertain_datasets/test_resampling_datasets_uncertainindexdataset.jl")
include("uncertain_datasets/test_resampling_datasets_uncertainindexdataset_apply_funcs.jl")
#include("uncertain_datasets/test_resampling_datasets_uncertainindexdataset_constraints.jl")

# # Resampling uncertain index-value datasets
# #-------------------------------------
# include("resampling/uncertain_datasets/test_resampling_uncertainindexvaluedataset.jl")

# # Resampling uncertain vectors
# #-----------------------------
# include("resampling/uncertain_vectors/test_resampling_vectors.jl")

# # Special resampling constraints
# #-----------------------------
# include("resampling/uncertain_datasets/sequential/test_resampling_sequential_increasing.jl")
# include("resampling/uncertain_datasets/sequential/test_resampling_sequential_decreasing.jl")

#############################################
# Resampling uncertain datasets element-wise
#############################################
#include("resampling/uncertain_datasets/test_resampling_abstractuncertainvaluedataset_elwise.jl")

