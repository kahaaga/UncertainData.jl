using Reexport

@reexport module UncertainStatistics
    using StatsBase
    using Distributions
    using ..UncertainValues
    using ..UncertainDatasets

    # Definitions of statistical methods for UncertainDatasets
    include("statsbase/core_stats.jl")
    include("hypothesis_tests/mann_whitney.jl")
    include("hypothesis_tests/t_tests.jl")
    include("hypothesis_tests/HypothesisTests.jl")
    include("hypothesis_tests/HypothesisTests_timeseries.jl")

    #include("StatsBase_meanfunctions.jl")
    #include("StatsBase_scalarstatistics_moments.jl")
    #include("StatsBase_variation.jl")
    #include("StatsBase_zscores.jl")
    #include("StatsBase_entropies.jl")
    #include("StatsBase_quantiles.jl")
end
