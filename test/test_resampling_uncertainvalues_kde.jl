
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
