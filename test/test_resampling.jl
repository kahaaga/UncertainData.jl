u = UncertainValue(Normal, 0, 1)

# Resampling many times
@test maximum(resample(u, TruncateLowerQuantile(0.2), 1000)) >= quantile(u.distribution, 0.2)
@test maximum(resample(u, TruncateUpperQuantile(0.7), 1000)) <= quantile(u.distribution, 0.7)
@test maximum(resample(u, TruncateMinimum(-0.1), 10)) >= -0.1
@test maximum(resample(u, TruncateMaximum(0.1), 10)) <= 0.1

# quantile truncation
c = resample(u, TruncateQuantiles(0.3, 0.9), 1000)
@test minimum(c) >= quantile(u.distribution, 0.3)
@test maximum(c) <= quantile(u.distribution, 0.9)

# standard deviation truncation
c = resample(u, TruncateStd(1))

@test maximum(c) <= 0 + 1
@test minimum(c) >= 0 - 1


# Resampling once
@test maximum(resample(u, TruncateLowerQuantile(0.2))) >= quantile(u.distribution, 0.2)
@test maximum(resample(u, TruncateUpperQuantile(0.7))) <= quantile(u.distribution, 0.7)
@test maximum(resample(u, TruncateMinimum(-0.1))) >= -0.1
@test maximum(resample(u, TruncateMaximum(0.1))) <= 0.1
c = resample(u, TruncateQuantiles(0.3, 0.9))
@test minimum(c) >= quantile(u.distribution, 0.3)
@test maximum(c) <= quantile(u.distribution, 0.9)
