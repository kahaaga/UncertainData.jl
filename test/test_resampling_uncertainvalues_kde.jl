
################################################
# Uncertain values represented by KDE estimates
################################################

# Create a random sample
d = Normal()
some_sample = rand(d, 1000)

# Create an uncertain value from the random sample by kernel density
# estimation.
uv = UncertainValue(some_sample)

@test resample(uv) isa Float64
@test resample(uv, 10) isa Vector{Float64}

@test resample(uv, NoConstraint()) isa Float64
@test resample(uv, NoConstraint(), 10) isa Vector{Float64}

@test resample(uv, TruncateLowerQuantile(0.2)) isa Float64
@test resample(uv, TruncateLowerQuantile(0.2), 10) isa Vector{Float64}


r1a = resample(uv, TruncateQuantiles(0.2, 0.8))
r1b = resample(uv, TruncateQuantiles(0.2, 0.8), 10)

@test r1a isa Float64
@test r1b isa Vector{Float64}
@test quantile(uv, 0.2) <≈ r1a <≈ quantile(uv, .8)
@test quantile(uv, 0.2) <≈ r1b <≈ quantile(uv, .8)
