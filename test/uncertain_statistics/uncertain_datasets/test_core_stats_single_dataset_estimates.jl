import StatsBase

single_estimate_funcs = [
    StatsBase.var,
    StatsBase.std,
    StatsBase.middle,
    StatsBase.median,
    StatsBase.mean,
    StatsBase.genmean,
    StatsBase.genvar,
    StatsBase.harmmean,
    StatsBase.mode,
    StatsBase.percentile,
    StatsBase.quantile,
    StatsBase.rle,
    StatsBase.sem,
    StatsBase.span,
    StatsBase.summarystats,
    StatsBase.totalvar,
    StatsBase.kurtosis,
    StatsBase.moment,
    StatsBase.skewness,
    StatsBase.renyientropy
]

n = 10

udata = UncertainValueDataset(example_uvals)

@testset "Single-estimate statistic for dataset" begin
    @testset "$(single_estimate_funcs[i])" for i = 1:length(single_estimate_funcs)
        f = single_estimate_funcs[i]

        if f == StatsBase.summarystats
            @test f(udata, n) isa Vector{StatsBase.SummaryStats{T}} where T
        elseif f == StatsBase.percentile 
            @test f(udata, 10, n) isa Vector{T} where T <: Real
            @test f(udata, [10, 20], n) isa Vector{Vector{T}} where T <: Real
        elseif f == StatsBase.quantile
            @test f(udata, 0.1, n) isa Vector{T} where T <: Real
            @test f(udata, [0.2, 0.5], n) isa Vector{Vector{T}} where T <: Real
        elseif f == StatsBase.moment
            @test f(udata, 1, n) isa Vector{T} where T <: Real
            @test f(udata, 2, n) isa Vector{T} where T <: Real
        elseif f == StatsBase.genmean
            @test f(udata, 4, n) isa Vector{T} where T <: Real
        elseif f == StatsBase.rle
            @test rle(udata, n) isa Vector{Tuple{Vector{T1}, Vector{T2}}} where {T1, T2}
        elseif f == StatsBase.span
            @test f(udata, n) isa Vector{T} where {T <: AbstractRange{S}} where S
        elseif f == StatsBase.renyientropy
            @test f(udata, 1, n) isa Vector{T} where T <: Real
        else
            @test f(udata, n) isa Vector{T} where T <: Real
        end
    end;
end

