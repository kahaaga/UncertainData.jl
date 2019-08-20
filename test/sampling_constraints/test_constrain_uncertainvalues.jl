
import KernelDensity.UnivariateKDE


######################################################################
# Resampling datasets consisting of uncertain values furnished by
# theoretical distributions
######################################################################
tol = 1e-7

uv = UncertainValue(Normal, 1, 0.5)

uvc_lq = constrain(uv, TruncateLowerQuantile(0.2))
uvc_uq = constrain(uv, TruncateUpperQuantile(0.8))
uvc_q = constrain(uv, TruncateQuantiles(0.2, 0.8))
uvc_min = constrain(uv, TruncateMinimum(0.5))
uvc_max = constrain(uv, TruncateMaximum(1.5))
uvc_range = constrain(uv, TruncateRange(0.5, 1.5))

@test minimum(resample(uvc_lq, 1000)) >= quantile(uv, 0.2) - tol
@test maximum(resample(uvc_uq, 1000)) <= quantile(uv, 0.8) + tol
@test all(quantile(uv, 0.2) - tol .<= resample(uvc_q, 1000) .<= quantile(uv, 0.8) + tol)
@test minimum(resample(uvc_min, 1000)) >= 0.5 - tol
@test maximum(resample(uvc_max, 1000)) <= 1.5 + tol
@test all(0.5 - tol .<= resample(uvc_range, 1000) .<= 1.5 + tol)

##########################################################################
# Resampling datasets consisting of uncertain values furnished by
# theoretical distributions with parameters estimated from empirical data
##########################################################################
tol = 1e-7

uv = UncertainValue(Normal, rand(Normal(-1, 0.2), 1000))

uvc_lq = constrain(uv, TruncateLowerQuantile(0.2))
uvc_uq = constrain(uv, TruncateUpperQuantile(0.8))
uvc_q = constrain(uv, TruncateQuantiles(0.2, 0.8))
uvc_min = constrain(uv, TruncateMinimum(0.5))
uvc_max = constrain(uv, TruncateMaximum(1.5))
uvc_range = constrain(uv, TruncateRange(0.5, 1.5))

@test minimum(resample(uvc_lq, 1000)) >= quantile(uv, 0.2) - tol
@test maximum(resample(uvc_uq, 1000)) <= quantile(uv, 0.8) + tol
@test all(quantile(uv, 0.2) - tol .<= resample(uvc_q, 1000) .<= quantile(uv, 0.8) + tol)
@test minimum(resample(uvc_min, 1000)) >= 0.5 - tol
@test maximum(resample(uvc_max, 1000)) <= 1.5 + tol
@test all(0.5 - tol .<= resample(uvc_range, 1000) .<= 1.5 + tol)

##########################################################################
# Resampling datasets consisting of uncertain values furnished by
# kernel density estimations to the distributions.
##########################################################################

# quantile estimates for `uv` is not precise for KDE estimates,
# so we need to lower the tolerance.
tol = 1e-2
uv = UncertainValue(UnivariateKDE, rand(Uniform(10, 15), 1000))
#uv = UncertainValue(rand(Normal(15, 2), 1000)) # does the same

# Verify that we get errors if trying to sample outside the support of the
# distributon furnishing the data point
@test_throws ArgumentError constrain(uv, TruncateMaximum(-100))
@test_throws ArgumentError constrain(uv, TruncateMinimum(100))
@test_throws DomainError constrain(uv, TruncateRange(100, -100))


uvc_lq = constrain(uv, TruncateLowerQuantile(0.2))
uvc_uq = constrain(uv, TruncateUpperQuantile(0.8))
uvc_q = constrain(uv, TruncateQuantiles(0.2, 0.8))
uvc_min = constrain(uv, TruncateMinimum(13))
uvc_max = constrain(uv, TruncateMaximum(13))
uvc_range = constrain(uv, TruncateRange(11, 12))

@test minimum(resample(uvc_lq, 1000)) >= quantile(uv, 0.2) - tol
@test maximum(resample(uvc_uq, 1000)) <= quantile(uv, 0.8) + tol
@test all(quantile(uv, 0.2) - tol .<= resample(uvc_q, 1000) .<= quantile(uv, 0.8) + tol)
@test minimum(resample(uvc_min, 1000)) >= 13 - tol
@test maximum(resample(uvc_max, 1000)) <= 13 + tol
@test all(11 - tol .<= resample(uvc_range, 1000) .<= 12 + tol)
