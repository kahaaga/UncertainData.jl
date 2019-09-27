n = 5
using Test 

pairwise_funcs = [
    StatsBase.cov,
    StatsBase.cor,
    StatsBase.countne,
    StatsBase.counteq,
    StatsBase.corkendall,
    StatsBase.corspearman,
    StatsBase.maxad,
    StatsBase.meanad,
    StatsBase.msd,
    StatsBase.psnr,
    StatsBase.rmsd,
    StatsBase.sqL2dist,
    StatsBase.crosscor,
    StatsBase.crosscov
]

@testset "pairwise statistic: $(pairwise_funcs[i])" for i = 1:length(pairwise_funcs)
    f = pairwise_funcs[i]
    @testset for (i, uval) in enumerate(example_uvals)
        if f == StatsBase.psnr
            maxv = 100
            @test f(uval, uval, maxv, n) isa T where T <: Real
            
        elseif f ∈ [StatsBase.crosscor, StatsBase.crosscov]
            @test f(uval, uval, n) isa AbstractVector{T} where T <: Real
            
        else
            @test f(uval, uval, n) isa T where T <: Real
        end
    end
end;

# Functions that under the hood use functions with strictly positive domains
# special_pairwise_funcs = [
#     StatsBase.gkldiv,
#     StatsBase.kldivergence,
# ]

# @testset "$(pairwise_funcs[i])" for i = 1:length(pairwise_funcs)
#     f = pairwise_funcs[i]
#     @testset for (i, uval) in enumerate(example_uvals)
#         @test f(uval, uval, n) isa T where T <: Real
#     end
# end;