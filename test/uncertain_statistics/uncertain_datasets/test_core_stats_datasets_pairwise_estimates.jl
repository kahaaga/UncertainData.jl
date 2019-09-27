n = 10
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

uvals = example_uvals

@testset "Pairwise statistics on datasets" begin
    @testset "$(pairwise_funcs[i])" for i = 1:length(pairwise_funcs)
        f = pairwise_funcs[i]
        if f == StatsBase.psnr
            maxv = 100
            @test f(uvals, uvals, maxv, n) isa Vector{T} where T <: Real
                
        elseif f ∈ [StatsBase.crosscor, StatsBase.crosscov]
            @test f(uvals, uvals, n) isa Vector{Vector{T}} where T <: Real
            @test f(uvals, uvals, 1:5, n) isa Vector{Vector{T}} where T <: Real
        else
            @test f(uvals, uvals, n) isa Vector{T} where T <: Real
        end
    end
end


UV = UncertainValueDataset(example_uvals)

@testset "Pairwise statistics on datasets" begin
    @testset "$(pairwise_funcs[i])" for i = 1:length(pairwise_funcs)
        f = pairwise_funcs[i]
        if f == StatsBase.psnr
            maxv = 100
            @test f(UV, UV, maxv, n) isa Vector{T} where T <: Real
                
        elseif f ∈ [StatsBase.crosscor, StatsBase.crosscov]
            @test f(UV, UV, n) isa Vector{Vector{T}} where T <: Real
            @test f(UV, UV, 1:5, n) isa Vector{Vector{T}} where T <: Real
        else
            @test f(UV, UV, n) isa Vector{T} where T <: Real
        end
    end
end

UI = UncertainIndexDataset(example_uvals)

@testset "Pairwise statistics on datasets" begin
    @testset "$(pairwise_funcs[i])" for i = 1:length(pairwise_funcs)
        f = pairwise_funcs[i]
        if f == StatsBase.psnr
            maxv = 100
            @test f(UI, UI, maxv, n) isa Vector{T} where T <: Real
                
        elseif f ∈ [StatsBase.crosscor, StatsBase.crosscov]
            @test f(UI, UI, n) isa Vector{Vector{T}} where T <: Real
            @test f(UI, UI, 1:5, n) isa Vector{Vector{T}} where T <: Real
        else
            @test f(UI, UI, n) isa Vector{T} where T <: Real
        end
    end
end

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