import ..SamplingConstraints: SamplingConstraint
import ..UncertainValues: CertainScalar
import Measurements: Measurement
import ..UncertainValues: UncertainValue
import Distributions: Normal


#################################
# Values without uncertainties
#################################

resample(x::Number) = x
resample(v::CertainScalar) = v.value 
resample(v::CertainScalar, n::Int) = [v.value for i = 1:n]
resample(v::CertainScalar, s::SamplingConstraint) = v.value 
resample(v::CertainScalar, s::SamplingConstraint, n::Int) = [v.value for i = 1:n]

# constraints = [
#     :(NoConstraint), 
#     :(TruncateLowerQuantile), 
#     :(TruncateUpperQuantile),
#     :(TruncateQuantiles),
#     :(TruncateMaximum),
#     :(TruncateMinimum),
#     :(TruncateRange),
#     :(TruncateStd)
# ]

# for constraint in constraints
#     funcs = quote 
#         resample(x::CertainScalar, constraint::$(constraint)) = x.value
#         resample(x::CertainScalar, constraint::$(constraint), n::Int) = [x.value for i = 1:n]
#     end
#     eval(funcs)
# end

#################################
# Measurements
#################################

resample(m::Measurement{T}) where T = resample(UncertainValue(Normal, m.val, m.err))
function resample(m::Measurement{T}, n::Int) where T
    uval = UncertainValue(Normal, m.val, m.err)

    [resample(uval) for i = 1:n]
end

#################################
# Theoretical distributions 
#################################
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
import Distributions 

# Resample for generic
resample(uv::TheoreticalDistributionScalarValue) = rand(uv.distribution)
resample(uv::TheoreticalDistributionScalarValue, n::Int) = rand(uv.distribution, n)


# Custom resample methods for each type of uncertain scalars based on
# distributions (in case we want to implement custom sampling for some of them)
# resample(uv::UncertainScalarTheoreticalThreeParameter) = rand(uv.distribution)
# resample(uv::UncertainScalarTheoreticalTwoParameter) = rand(uv.distribution)
# resample(uv::UncertainScalarNormallyDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarUniformlyDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarBetaDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarBetaPrimeDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarBetaBinomialDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarGammaDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarFrechetDistributed) = rand(uv.distribution)
# resample(uv::UncertainScalarBinomialDistributed) = rand(uv.distribution)


# resample(uv::UncertainScalarTheoreticalThreeParameter, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarTheoreticalTwoParameter, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarNormallyDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarUniformlyDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarBetaDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarBetaPrimeDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarBetaBinomialDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarGammaDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarFrechetDistributed, n::Int) = rand(uv.distribution, n)
# resample(uv::UncertainScalarBinomialDistributed, n::Int) = rand(uv.distribution, n)

resample(x::Distributions.Truncated) = rand(x)
resample(x::Distributions.Truncated, n::Int) = rand(x, n)
resample(x::Distributions.Distribution) = rand(x)
resample(x::Distributions.Distribution, n::Int) = rand(x, n)