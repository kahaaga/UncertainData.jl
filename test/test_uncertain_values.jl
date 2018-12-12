# Uncertain normally distributed values
@test UncertainValue(1, 0.2, Normal, nσ = 2, trunc_lower = -5) isa UncertainScalarNormallyDistributed
@test UncertainValue(-3, 0.2, Normal) isa UncertainScalarNormallyDistributed
@test UncertainValue(0, 2, Normal) isa UncertainScalarNormallyDistributed
@test UncertainValue(-1, 0.1, Normal) isa UncertainScalarNormallyDistributed
@test UncertainValue(-1, 0.1, Normal, nσ = 2, trunc_upper = 4) isa UncertainScalarNormallyDistributed
@test UncertainValue(5.0, 0.2, Normal) isa UncertainScalarNormallyDistributed

# Uncertain uniformly distributed values
@test UncertainValue(1, 7, Uniform) isa UncertainScalarUniformlyDistributed
@test UncertainValue(-1, 7, Uniform) isa UncertainScalarUniformlyDistributed
@test UncertainValue(-6, -2, Uniform) isa UncertainScalarUniformlyDistributed


# Uncertain beta-distributed values
@test UncertainValue(1, 7, Beta) isa UncertainScalarBetaDistributed
@test_broken UncertainValue(-1, 7, Beta) isa UncertainScalarBetaDistributed
@test_broken UncertainValue(-1, -2, Beta) isa UncertainScalarBetaDistributed
@test_broken UncertainValue(4, -2, Beta) isa UncertainScalarBetaDistributed

# Uncertain beta-distributed values
@test UncertainValue(10, 1, 7, BetaBinomial) isa UncertainScalarBetaBinomialDistributed
@test_broken UncertainValue(10, -1, 7, BetaBinomial) isa UncertainScalarBetaBinomialDistributed
@test_broken UncertainValue(10, -1, -2, BetaBinomial) isa UncertainScalarBetaBinomialDistributed
@test_broken UncertainValue(1, 2, BetaBinomial) isa UncertainScalarBetaBinomialDistributed

# Uncertain beta prime-distributed values
@test UncertainValue(1, 7, BetaPrime) isa UncertainScalarBetaPrimeDistributed
@test_broken UncertainValue(-1, 7, BetaPrime) isa UncertainScalarBetaPrimeDistributed
@test_broken UncertainValue(-1, -2, BetaPrime) isa UncertainScalarBetaPrimeDistributed
@test_broken UncertainValue(2, -2, BetaPrime) isa UncertainScalarBetaPrimeDistributed


# Uncertain gamma-distributed values
@test UncertainValue(1, 7, Gamma) isa UncertainScalarGammaDistributed
@test UncertainValue(1, 7, Gamma, trunc_upper = 4, trunc_lower = 1) isa UncertainScalarGammaDistributed
@test_broken UncertainValue(-1, 7, Gamma) isa UncertainScalarGammaDistributed
@test_broken UncertainValue(-1, -2, Gamma) isa UncertainScalarGammaDistributed
@test_broken UncertainValue(-1, -2, Gamma) isa UncertainScalarGammaDistributed

# Uncertain Fréchet-distributed values
@test UncertainValue(1, 7, Frechet) isa UncertainScalarFrechetDistributed

# Uncertain Binomial-distributed values
@test UncertainValue(50, 0.4, Binomial) isa UncertainScalarBinomialDistributed


# Uncertain values from empirical distributions
@test UncertainScalarEmpiricallyDistributed(rand(100), Uniform) isa UncertainScalarEmpiricallyDistributed
@test UncertainScalarEmpiricallyDistributed(rand(Normal(), 100), Normal) isa UncertainScalarEmpiricallyDistributed
@test UncertainScalarEmpiricallyDistributed(rand(100), Uniform) isa UncertainScalarEmpiricallyDistributed
@test UncertainScalarEmpiricallyDistributed(rand(Normal(), 100), Normal) isa UncertainScalarEmpiricallyDistributed
@test UncertainValue(rand(100), Uniform) isa UncertainScalarEmpiricallyDistributed
@test UncertainValue(rand(Normal(), 100), Normal) isa UncertainScalarEmpiricallyDistributed

#@test @uncertainvalue(0, -2, 2, Normal()) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), nσ = 2) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), trunc_lower = 5) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), trunc_upper = 5) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), tolerance = 1e-4) isa AbstractUncertainObservation
