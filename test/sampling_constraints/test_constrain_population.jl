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
pop5 = UncertainValue([pop1, pop2, 2, UncertainValue(Normal, -2, 3)], Weights(rand(4)));

uncertain_scalar_populations = [pop1, pop2, pop3, pop4, pop5];

# pop1.values = CertainValue{Float64}(3.0)                                                                    
# UncertainScalarNormallyDistributed{Int64,Int64,Distributions.Continuous}(μ = 0.000, σ = 1.000)
# UncertainScalarGammaDistributed{Int64,Int64,Distributions.Continuous}(α = 2.000, θ = 3.000)   
# UncertainScalarTheoreticalFit{Uniform{Float64},Float64} 
# pop1.values = CertainValue{Float64}(3.0)                                                                    
# UncertainScalarNormallyDistributed{Int64,Int64,Distributions.Continuous}(μ = 0.000, σ = 1.000)
# UncertainScalarGammaDistributed{Int64,Int64,Distributions.Continuous}(α = 2.000, θ = 3.000)   
# UncertainScalarTheoreticalFit{Uniform{Float64},Float64} 
@test constrain(pop1, TruncateMinimum(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop1, TruncateMaximum(3.0)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop1, TruncateRange(0.0, 3.0)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop1, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop1, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop1, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation

# pop2.values = [1, 2, 3]
@test constrain(pop2, TruncateMinimum(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop2, TruncateMaximum(2.5)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop2, TruncateRange(0.5, 2.5)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop2, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop2, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop2, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation

# pop3.values = [1.0, 2.0, 3.0]
@test constrain(pop3, TruncateMinimum(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop3, TruncateMaximum(2.5)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop3, TruncateRange(0.5, 2.5)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop3, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop3, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop3, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation

@test constrain(pop4, TruncateMinimum(-10)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop4, TruncateMaximum(10)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop4, TruncateRange(-10, 10)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop4, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop4, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop4, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation

@test constrain(pop5, TruncateMinimum(-10)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop5, TruncateMaximum(10)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop5, TruncateRange(-10, 10)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop5, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop5, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(pop5, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation





