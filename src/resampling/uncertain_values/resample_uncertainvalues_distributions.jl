import ..UncertainValues:
	TheoreticalDistributionScalarValue,
    AbstractUncertainTwoParameterScalarValue,
    AbstractUncertainThreeParameterScalarValue,
    UncertainScalarTheoreticalTwoParameter,
    UncertainScalarTheoreticalThreeParameter,
    UncertainScalarNormallyDistributed,
    UncertainScalarUniformlyDistributed,
    UncertainScalarBetaDistributed,
    UncertainScalarBetaPrimeDistributed,
    UncertainScalarBetaBinomialDistributed,
    UncertainScalarBinomialDistributed,
    UncertainScalarGammaDistributed,
    UncertainScalarFrechetDistributed

# Resample for generic
resample(uv::TheoreticalDistributionScalarValue) = rand(uv.distribution)
resample(uv::TheoreticalDistributionScalarValue, n::Int) = rand(uv.distribution, n)


# Custom resample methods for each type of uncertain scalars based on
# distributions (in case we want to implement custom sampling for some of them)
resample(uv::UncertainScalarTheoreticalThreeParameter) = rand(uv.distribution)
resample(uv::UncertainScalarTheoreticalTwoParameter) = rand(uv.distribution)
resample(uv::UncertainScalarNormallyDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarUniformlyDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBetaDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBetaPrimeDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBetaBinomialDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarGammaDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarFrechetDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBinomialDistributed) = rand(uv.distribution)


resample(uv::UncertainScalarTheoreticalThreeParameter, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarTheoreticalTwoParameter, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarNormallyDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarUniformlyDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarBetaDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarBetaPrimeDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarBetaBinomialDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarGammaDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarFrechetDistributed, n::Int) = rand(uv.distribution, n)
resample(uv::UncertainScalarBinomialDistributed, n::Int) = rand(uv.distribution, n)
