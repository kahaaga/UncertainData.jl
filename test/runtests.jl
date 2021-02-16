using Test
using UncertainData
using Distributions
using StaticArrays
using StatsBase
using KernelDensity



#############################################
# UncertainValues module
#############################################
@testset "Uncertain values" begin 
    @testset "Assign distributions" begin
        include("uncertain_values/test_assign_distributions.jl")

        @testset "Uncertain values" begin 
            include("uncertain_values/test_uncertain_values.jl")
        end

        @testset "minmax" begin
            include("uncertain_values/test_minmax.jl")
        end

        @testset "CertainValue" begin
            include("uncertain_values/test_certain_values.jl")
        end

        @testset "Merging" begin
            include("uncertain_values/test_merging.jl")
        end
    end
end

@testset "Populations" begin 
    include("uncertain_values/populations/test_UncertainScalarPopulation.jl")
    include("uncertain_values/populations/test_ConstrainedUncertainScalarPopulation.jl")
end


#############################################
# UncertainDatasets module
#############################################
@testset "Uncertain datasets" begin
    include("uncertain_datasets/test_uncertain_datasets.jl")
end

#############################################
# Resampling uncertain values
#############################################
@testset "Uncertain values" begin 
    include("resampling/test_resampling_uncertain_values.jl")
end
#############################################
# Resampling uncertain tuples
#############################################
@testset "Uncertain tuples" begin 
    include("resampling/test_resampling_uncertain_tuples.jl")
end

#############################################
# Resampling uncertain datasets
#############################################

# Resampling schemes
@testset "Resampling" begin 

    @testset "BinnedResampling" begin
        include("resampling/resampling_schemes/test_BinnedResampling.jl")
    end

    @testset "BinnedWeightedResampling" begin
        include("resampling/resampling_schemes/test_BinnedWeightedResampling.jl")
    end

    @testset "BinnedMeanResampling" begin
        include("resampling/resampling_schemes/test_BinnedMeanResampling.jl")
    end
    
    @testset "BinnedMeanWeightedResampling" begin
        include("resampling/resampling_schemes/test_BinnedMeanWeightedResampling.jl")
    end

    @testset "ConstrainedIndexValueResampling" begin
        include("resampling/resampling_schemes/test_ConstrainedIndexValueResampling.jl")
    end
    
    @testset "ContrainedValueResampling" begin
        include("resampling/resampling_schemes/test_ConstrainedValueResampling.jl")
    end
    
    @testset "SequentialResampling" begin
        include("resampling/resampling_schemes/test_SequentialResampling.jl")
    end
    
    @testset "SequentialInterpolatedResampling" begin 
        include("resampling/resampling_schemes/test_SequentialInterpolatedResampling.jl")
    end 
    
    @testset "RandomSequences" begin
        include("resampling/resampling_schemes/test_RandomSequences.jl")
    end

    # Define an array of uncertain values `uvals` that we can construct datasets from.
    include("resampling/define_uncertain_values.jl")

    @testset "Vectors of uncertain values" begin

        # Resampling vectors of uncertain values
        #---------------------------------------
        include("resampling/uncertain_vectors/test_resampling_vectors.jl")
        include("resampling/uncertain_vectors/test_resampling_vectors_apply_funcs.jl")
        include("resampling/uncertain_vectors/test_resampling_vectors_constraints.jl")
    end


    # Resampling uncertain datasets
    #-------------------------------
    @testset "UncertainDataset" begin
        include("resampling/uncertain_datasets/test_resampling_datasets.jl")
    end

    # Resampling uncertain value datasets
    #-------------------------------------
    @testset "UncertainValueDataset" begin
        include("resampling/uncertain_datasets/test_resampling_datasets_uncertainvaluedataset.jl")
        include("resampling/uncertain_datasets/test_resampling_datasets_uncertainvaluedataset_apply_funcs.jl")
        include("resampling/uncertain_datasets/test_resampling_datasets_uncertainvaluedataset_constraints.jl")
    end
    # Resampling uncertain index datasets
    #-------------------------------------
    @testset "UncertainIndexDataset" begin
        include("resampling/uncertain_datasets/test_resampling_datasets_uncertainindexdataset.jl")
        include("resampling/uncertain_datasets/test_resampling_datasets_uncertainindexdataset_apply_funcs.jl")
        include("resampling/uncertain_datasets/test_resampling_datasets_uncertainindexdataset_constraints.jl")
    end

    # Resampling uncertain index-value datasets
    #-------------------------------------
    @testset "UncertainIndexValueDataset" begin
        include("resampling/uncertain_datasets/test_resampling_uncertainindexvaluedataset.jl")
        include("resampling/uncertain_datasets/test_resampling_with_schemes.jl")
    end

    # Special resampling constraints
    #-----------------------------
    @testset "Special resampling constraints" begin
        @testset "Sequential" begin
            include("resampling/uncertain_datasets/sequential/test_resampling_sequential_increasing.jl")
            include("resampling/uncertain_datasets/sequential/test_resampling_sequential_decreasing.jl")
        end
    end

    # Resampling inplace.
    #-----------------------------
    @testset "Inplace resampling" begin
        include("resampling/test_resampling_inplace.jl")
    end

    #############################################
    # Resampling uncertain datasets element-wise
    #############################################
    @testset "Element-wise" begin
        include("resampling/uncertain_datasets/test_resampling_abstractuncertainvaluedataset_elwise.jl")
    end
end

############################################
# Interpolation and binning
#############################################
@testset "Interpolation/binning" begin
    include("generic_interpolation/test_findall_nan_chunks.jl")
    include("generic_interpolation/test_interpolate_nans.jl")
    include("resampling/uncertain_datasets/test_interpolation.jl")
    include("binning/test_binning.jl")

    # Interpolation with resampling schemes
    @testset "Intp w/ resampling scheme" begin
    include("resampling/binning/test_bin_BinnedResampling.jl")
    include("resampling/binning/test_bin_BinnedWeightedResampling.jl")
    end
end

#############################
# Mathematics
#############################
@testset "Mathematics" begin 
    include("mathematics/test_mathematics.jl")
end

############################################
# Uncertain statistics
#############################################
@testset "Statistics" begin 
    include("uncertain_statistics/uncertain_values/test_core_stats_values_point_estimates.jl")
    include("uncertain_statistics/uncertain_values/test_core_stats_values_pair_estimates.jl")

    include("uncertain_statistics/uncertain_datasets/test_core_stats_datasets_single_dataset_estimates.jl")
    include("uncertain_statistics/uncertain_datasets/test_core_stats_datasets_pairwise_estimates.jl")

    include("uncertain_statistics/test_hypothesistests.jl")
end
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
@testset "Resampling with constraints" begin
    include("sampling_constraints/test_sampling_constraints.jl")
    include("sampling_constraints/test_constrain_certainvalue.jl")
    include("sampling_constraints/test_constrain_population.jl")
    include("sampling_constraints/test_constrain_uncertainvalues.jl")
    include("sampling_constraints/test_constrain_uncertainvalues_kde.jl")
    include("sampling_constraints/test_constrain_uncertaindatasets.jl")
    include("sampling_constraints/test_constrain_uncertainvaluedatasets.jl")
    include("sampling_constraints/test_constrain_uncertainindexdatasets.jl")

    include("sampling_constraints/test_constrain_with_schemes.jl")

end