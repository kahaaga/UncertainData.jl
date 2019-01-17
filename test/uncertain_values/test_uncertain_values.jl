##################################################
# Uncertain populations 
################################################
vals = rand(10) 
weights = rand(10)
@test UncertainValue(vals, weights) isa UncertainScalarPopulation

# Uncertain normally distributed values
@test UncertainValue(Normal, 1, 0.2, nσ = 2, trunc_lower = -5) isa UncertainScalarNormallyDistributed
@test UncertainValue(Normal, -3, 0.2) isa UncertainScalarNormallyDistributed
@test UncertainValue(Normal, 0, 2) isa UncertainScalarNormallyDistributed
@test UncertainValue(Normal, -1, 0.1) isa UncertainScalarNormallyDistributed
@test UncertainValue(Normal, -1, 0.1, nσ = 2, trunc_upper = 4) isa UncertainScalarNormallyDistributed
@test UncertainValue(Normal, 5.0, 0.2) isa UncertainScalarNormallyDistributed

# Uncertain uniformly distributed values
@test UncertainValue(Uniform, 1, 7) isa UncertainScalarUniformlyDistributed
@test UncertainValue(Uniform, -1, 7) isa UncertainScalarUniformlyDistributed
@test UncertainValue(Uniform, -6, -2) isa UncertainScalarUniformlyDistributed


# Uncertain beta-distributed values
@test UncertainValue(Beta, 1, 7) isa UncertainScalarBetaDistributed
@test_broken UncertainValue(Beta, -1, 7) isa UncertainScalarBetaDistributed
@test_broken UncertainValue(Beta, -1, -2) isa UncertainScalarBetaDistributed
@test_broken UncertainValue(Beta, 4, -2) isa UncertainScalarBetaDistributed

# Uncertain beta-distributed values
@test UncertainValue(BetaBinomial, 10, 1, 7) isa UncertainScalarBetaBinomialDistributed
@test_broken UncertainValue(BetaBinomial, 10, -1, 7) isa UncertainScalarBetaBinomialDistributed
@test_broken UncertainValue(BetaBinomial, 10, -1, -2) isa UncertainScalarBetaBinomialDistributed
@test_broken UncertainValue(BetaBinomial, 1, 2) isa UncertainScalarBetaBinomialDistributed

# Uncertain beta prime-distributed values
@test UncertainValue(BetaPrime, 1, 7) isa UncertainScalarBetaPrimeDistributed
@test_broken UncertainValue(BetaPrime, -1, 7) isa UncertainScalarBetaPrimeDistributed
@test_broken UncertainValue(BetaPrime, -1, -2) isa UncertainScalarBetaPrimeDistributed
@test_broken UncertainValue(BetaPrime, 2, -2) isa UncertainScalarBetaPrimeDistributed


# Uncertain gamma-distributed values
@test UncertainValue(Gamma, 1, 7) isa UncertainScalarGammaDistributed
@test UncertainValue(Gamma, 1, 7, trunc_upper = 4, trunc_lower = 1) isa UncertainScalarGammaDistributed
@test_broken UncertainValue(Gamma, -1, 7) isa UncertainScalarGammaDistributed
@test_broken UncertainValue(Gamma, -1, -2) isa UncertainScalarGammaDistributed
@test_broken UncertainValue(Gamma, -1, -2) isa UncertainScalarGammaDistributed

# Uncertain Fréchet-distributed values
@test UncertainValue(Frechet, 1, 7) isa UncertainScalarFrechetDistributed

# Uncertain Binomial-distributed values
@test UncertainValue(Binomial, 50, 0.4) isa UncertainScalarBinomialDistributed

################################################
# Uncertain values from empirical distributions
################################################
empirical_uniform = rand(Uniform(), 100)
empirical_normal = rand(Normal(), 100)
empirical_beta = rand(Beta(), 100)

@test UncertainValue(Uniform, empirical_uniform) isa UncertainScalarTheoreticalFit
@test UncertainValue(Normal, empirical_normal) isa UncertainScalarTheoreticalFit
@test UncertainValue(Beta, empirical_beta) isa UncertainScalarTheoreticalFit

##################################################
# Uncertain values from kernel density estimates
################################################

# Implicit constructor
@test UncertainValue(empirical_uniform) isa UncertainScalarKDE
@test UncertainValue(empirical_normal) isa UncertainScalarKDE
@test UncertainValue(empirical_beta) isa UncertainScalarKDE

# Explicit constructor
@test UncertainValue(UnivariateKDE, empirical_uniform) isa UncertainScalarKDE
@test UncertainValue(UnivariateKDE, empirical_normal) isa UncertainScalarKDE
@test UncertainValue(UnivariateKDE, empirical_beta) isa UncertainScalarKDE

# Empirical cumulative distribution function
d = Normal()
some_sample = rand(d, 1000)
uv = UncertainValue(some_sample)
uv_ecdf = UncertainData.UncertainValues.ecdf(uv)

tol = 1e-7
@test all(uv_ecdf .>= 0.0 - tol)
@test all(uv_ecdf .<= 1.0 + tol)


# Quantiles (empirical and true qantiles should be close for large samples)
large_sample = rand(d, Int(1e6))
uv = UncertainValue(UnivariateKDE, large_sample)
@test abs(quantile(uv, 0.8) - quantile(d, 0.8)) < 1e-2
