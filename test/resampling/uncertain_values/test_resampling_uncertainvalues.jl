
########################################################################
# Uncertain values constructed from distributions with known parameters
########################################################################
o1 = UncertainValue(Normal, 0, 0.5)
o2 = UncertainValue(Normal, 2.0, 0.1)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(Beta, 4, 5)
o6 = UncertainValue(Gamma, 4, 5)
o7 = UncertainValue(Frechet, 1, 2)
o8 = UncertainValue(BetaPrime, 1, 2)
o9 = UncertainValue(BetaBinomial, 10, 3, 2)
o10 = UncertainValue(Binomial, 10, 0.3)


@test resample(o1) isa Float64
@test resample(o2) isa Float64
@test resample(o3) isa Float64
@test resample(o4) isa Float64
@test resample(o5) isa Float64
@test resample(o6) isa Float64
@test resample(o7) isa Float64
@test resample(o8) isa Float64
@test resample(o9) isa Int
@test resample(o10) isa Int


########################################################################
# Resampling uncertain values with constraints
########################################################################

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
@test maximum(c) <= 0 + std(u)
@test minimum(c) >= 0 - std(u)

# range truncation
c = resample(u, TruncateRange(-0.2, 0.2))
@test maximum(c) <= 0.2
@test minimum(c) >= -0.2

# range truncation
c = resample(u, TruncateRange(-0.2, 0.2), 100)
@test maximum(c) <= 0.2
@test minimum(c) >= -0.2


# Resampling once
using StatsBase
@test maximum(resample(u, TruncateLowerQuantile(0.2))) >= quantile(u.distribution, 0.2)
@test maximum(resample(u, TruncateUpperQuantile(0.7))) <= quantile(u.distribution, 0.7)
@test maximum(resample(u, TruncateMinimum(-0.1))) >= -0.1
@test maximum(resample(u, TruncateMaximum(0.1))) <= 0.1
c = resample(u, TruncateQuantiles(0.3, 0.9))
@test minimum(c) >= quantile(u.distribution, 0.3)
@test maximum(c) <= quantile(u.distribution, 0.9)
