import ..UncertainValues:
    AbstractUncertainTwoParameterScalarValue,
    AbstractUncertainThreeParameterScalarValue,
    UncertainScalarGenericTwoParameter,
    UncertainScalarGenericThreeParameter,
    UncertainScalarNormallyDistributed,
    UncertainScalarUniformlyDistributed,
    UncertainScalarBetaDistributed,
    UncertainScalarBetaPrimeDistributed,
    UncertainScalarBetaBinomialDistributed,
    UncertainScalarBinomialDistributed,
    UncertainScalarGammaDistributed,
    UncertainScalarFrechetDistributed

# Custom resample methods for each type of uncertain scalars based on
# distributions (in case we want to implement custom sampling for some of them)
resample(uv::UncertainScalarGenericThreeParameter) = rand(uv.distribution)
resample(uv::UncertainScalarGenericTwoParameter) = rand(uv.distribution)
resample(uv::UncertainScalarNormallyDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarUniformlyDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBetaDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBetaPrimeDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBetaBinomialDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarGammaDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarFrechetDistributed) = rand(uv.distribution)
resample(uv::UncertainScalarBinomialDistributed) = rand(uv.distribution)
