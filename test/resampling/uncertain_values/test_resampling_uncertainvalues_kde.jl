tol = 1e-7
################################################
# Uncertain values represented by KDE estimates
################################################

# Create a random sample
d = Normal()
some_sample = rand(d, 2000)

# Create an uncertain value from the random sample by kernel density
# estimation.
uv = UncertainValue(some_sample)

@test resample(uv) isa Float64
@test resample(uv, 10) isa Vector{Float64}

@test resample(uv, NoConstraint()) isa Float64
@test resample(uv, NoConstraint(), 10) isa Vector{Float64}


r1a = resample(uv, TruncateLowerQuantile(0.2))
r1b = resample(uv, TruncateLowerQuantile(0.2), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
#@test quantile(uv, 0.2) <= r1a + tol
##@test all(quantile(uv, 0.2) .<= r1b .+ tol)


r1a = resample(uv, TruncateUpperQuantile(0.8))
r1b = resample(uv, TruncateUpperQuantile(0.8), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
#@test r1a <= quantile(uv, 0.8) + tol
#@test all(r1b .<= quantile(uv, 0.8) + tol)


r1a = resample(uv, TruncateQuantiles(0.2, 0.8))
r1b = resample(uv, TruncateQuantiles(0.2, 0.8), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
#@test quantile(uv, 0.2) - tol <= r1a <= quantile(uv, .8) + tol
#@test all(quantile(uv, 0.2) - tol .<= r1b .<= quantile(uv, .8) + tol)


r1a = resample(uv, TruncateMinimum(-0.5))
r1b = resample(uv, TruncateMinimum(-0.5), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
#@test -0.5 <= r1a + tol
#@test all(-0.5 .<= r1b .+ tol)


r1a = resample(uv, TruncateMaximum(0.5))
r1b = resample(uv, TruncateMaximum(0.5), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
#@test r1a <= 0.5 + tol
#@test all(r1b .<= 0.5 + tol)


r1a = resample(uv, TruncateRange(-0.5, 0.5))
r1b = resample(uv, TruncateRange(-0.5, 0.5), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
#@test -0.5 - tol <= r1a <= 0.5 + tol
#@test all(-0.5 - tol .<= r1b .<= 0.5 + tol)

# TruncateStd will not work, but with the default fallback we should still be able
# to resample.
r1a = resample(uv, TruncateStd(1))
r1b = resample(uv, TruncateStd(1), 10)
@test r1a isa Float64
@test r1b isa Vector{Float64}
