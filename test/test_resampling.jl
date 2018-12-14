u = UncertainValue(Normal, 0, 1)

# Resampling many times
@test maximum(resample(u, TruncateLowerQuantile(0.2), 1000)) >= quantile(u.distribution, 0.2)
@test maximum(resample(u, TruncateUpperQuantile(0.7), 1000)) <= quantile(u.distribution, 0.7)

c = resample(u, TruncateQuantiles(0.3, 0.9), 1000)
@test minimum(c) >= quantile(u.distribution, 0.3)
@test maximum(c) <= quantile(u.distribution, 0.9)

# Resampling
@test maximum(resample(u, TruncateLowerQuantile(0.2))) >= quantile(u.distribution, 0.2)
@test maximum(resample(u, TruncateUpperQuantile(0.7))) <= quantile(u.distribution, 0.7)

c = resample(u, TruncateQuantiles(0.3, 0.9))
@test minimum(c) >= quantile(u.distribution, 0.3)
@test maximum(c) <= quantile(u.distribution, 0.9)