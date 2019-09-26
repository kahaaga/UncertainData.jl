
pop1 = UncertainValue(
    [3.0, UncertainValue(Normal, 0, 1), 
    UncertainValue(Gamma, 2, 3), 
    UncertainValue(Uniform, rand(1000))], 
    [0.5, 0.5, 0.5, 0.5]
)

pop2 = UncertainValue([1, 2, 3], rand(3))
pop3 = UncertainValue([1.0, 2.0, 3.0], Weights(rand(3)))

# Uncertain population consisting of uncertain populations and other stuff
pop4 = UncertainValue([pop1, pop2], [0.1, 0.5])
pop5 = UncertainValue([pop1, pop2, 2], Weights(rand(3)));


uncertain_scalar_populations = [pop1, pop2, pop3, pop4, pop5]
    uncertain_theoretical_distributions = [
    UncertainValue(Uniform, -1, 1),
    UncertainValue(Normal, 0, 1),
    UncertainValue(Gamma, 1, 2),
    UncertainValue(Beta, 1, 2),
    UncertainValue(BetaPrime, 4, 5),
    UncertainValue(Frechet, 1, 1),
    UncertainValue(Binomial, 10, 0.3),
    UncertainValue(BetaBinomial, 100, 2, 3)
]
uncertain_kde_estimates = [
    UncertainValue(rand(100))
]

uncertain_fitted_distributions = [
    UncertainValue(Uniform, rand(Uniform(-2, 2), 100)),
    UncertainValue(Normal, rand(Normal(0, 1), 100))
]

uvals_alltypes = [
    uncertain_scalar_populations; 
    uncertain_theoretical_distributions; 
    uncertain_kde_estimates; 
    uncertain_fitted_distributions]

n = 10

@testset "Statistics on all types of uncertain values using resampling" begin
    @testset "$uval $i" for (i, uval) in enumerate(uvals_alltypes)
        @test mean(uval, n) isa Number
        @test median(uval, n) isa Number
        @test middle(uval, n) isa Number
        @test std(uval, n) isa Number
        @test var(uval, n) isa Number
        @test genmean(uval, 4, n) isa Number
        @test genvar(uval, n) isa Number
        @test harmmean(uval, n) isa Number
        @test kurtosis(uval, n) isa Number
        @test mode(uval, n) isa Number
        @test moment(uval, 1, n) isa Number
        @test moment(uval, 2, n) isa Number
        @test percentile(uval, 10, n) isa Number
        @test quantile(uval, 0.1, n) isa Number
        @test renyientropy(uval, 1, n) isa Number
        @test rle(uval, n) isa Tuple{Vector{T} where T, Vector{T2} where T2}
        @test sem(uval, n) isa Number
        @test skewness(uval, n) isa Number
        @test span(uval, n) isa AbstractRange{T} where T
        @test summarystats(uval, n) isa StatsBase.SummaryStats{T} where T
        @test totalvar(uval, n) isa Number
    end
end