
uv = UncertainValue(rand(1000))

#######################
# TruncateLowerQuantile
#######################
uvc = constrain(uv, TruncateLowerQuantile(0.2))
@test minimum(resample(uvc, 1000)) >= quantile(uv, 0.2) - tol

#######################
# TruncateUpperQuantile
#######################
uvc = constrain(uv, TruncateUpperQuantile(0.8))
@test maximum(resample(uvc, 1000)) <= quantile(uv, 0.8) + tol

#######################
# TruncateQuantiles
#######################
uvc = constrain(uv, TruncateQuantiles(0.2, 0.8))
@test all(quantile(uv, 0.2) - tol .<= resample(uvc, 1000) .<= quantile(uv, 0.8) + tol)

#######################
# TruncateMinimum
#######################
uvc = constrain(uv, TruncateMinimum(0.5))
@test minimum(resample(uvc, 1000)) >= 0.5 - tol

#######################
# TruncateMaximum
#######################
uvc = constrain(uv, TruncateMaximum(1.5))
@test maximum(resample(uvc, 1000)) <= 1.5 + tol

#######################
# TruncateRange
#######################
uvc = constrain(uv, TruncateRange(0.5, 1.5))
@test all(0.5 - tol .<= resample(uvc, 1000) .<= 1.5 + tol)
