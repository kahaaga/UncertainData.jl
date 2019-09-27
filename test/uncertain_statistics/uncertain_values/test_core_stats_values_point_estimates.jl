import StatsBase

pointestimate_funcs = [
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

@testset "Point-estimate statistics" begin  
    @testset "point-estimate statistic: $(pointestimate_funcs[i])" for i = 1:length(pointestimate_funcs)
        f = pointestimate_funcs[i]
        @testset for (i, uval) in enumerate(example_uvals)
            if f == StatsBase.summarystats
                @test f(uval, n) isa StatsBase.SummaryStats{T} where T
            elseif f == StatsBase.percentile 
                @test f(uval, 10, n) isa T where T <: Real
                @test f(uval, [10, 20], n) isa Vector{T} where T <: Real
            elseif f == StatsBase.quantile
                @test f(uval, 0.1, n) isa T where T <: Real
                @test f(uval, [0.2, 0.5], n) isa Vector{T} where T <: Real
            elseif f == StatsBase.moment
                @test f(uval, 1, n) isa T where T <: Real
                @test f(uval, 2, n) isa T where T <: Real
            elseif f == StatsBase.genmean
                @test f(uval, 4, n) isa T where T <: Real
            elseif f == StatsBase.rle
                @test rle(uval, n) isa Tuple{Vector{T} where T, Vector{T2} where T2}
            elseif f == StatsBase.span
                @test f(uval, n) isa AbstractRange{T} where T <: Real
            elseif f == StatsBase.renyientropy
                @test f(uval, 1, n) isa T where T <: Real
            else
                @test f(uval, n) isa T where T <: Real
            end
        end
    end;
end
