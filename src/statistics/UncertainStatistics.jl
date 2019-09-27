using Reexport

@reexport module UncertainStatistics
    using StatsBase
    using Distributions

    # Uncertain values and datasets types
    using ..UncertainValues
    using ..UncertainDatasets

    # Sampling constraints and resampling functions
    using ..Resampling

    # Definitions of statistical methods for UncertainDatasets
    include("statsbase/uncertain_values/core_stats_point_estimates.jl")
    include("statsbase/uncertain_values/core_stats_pair_estimates.jl")
	include("statsbase/uncertain_datasets/core_stats_uncertaindatasets.jl")
    include("statsbase/uncertain_datasets/core_stats_uncertaindatasets_single_estimates.jl")
    
    include("hypothesis_tests/mann_whitney.jl")
    include("hypothesis_tests/t_tests.jl")
    include("hypothesis_tests/anderson_darling.jl")
    include("hypothesis_tests/kolmogorov_smirnov.jl")
    include("hypothesis_tests/jarque_bera.jl")

    include("hypothesis_tests/timeseries_tests.jl")

    #include("StatsBase_meanfunctions.jl")
    #include("StatsBase_scalarstatistics_moments.jl")
    #include("StatsBase_variation.jl")
    #include("StatsBase_zscores.jl")
    #include("StatsBase_entropies.jl")
    #include("StatsBase_quantiles.jl")
end

"""
    UncertainStatistics

A module defining function to compute various statistics for uncertain values
and uncertain datasets.
"""
