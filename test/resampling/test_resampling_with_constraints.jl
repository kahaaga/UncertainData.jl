a, b, c = [UncertainValue(Normal, 1, 0.5) for i = 1:20], 
            UncertainValue(rand(1000)), 
            UncertainValue(Uniform, rand(10000))
uvals = [a; b; c]
udata = UncertainDataset(uvals)

@test resample(udata, NoConstraint(), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateLowerQuantile(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateUpperQuantile(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateQuantiles(0.2, 0.8), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateMaximum(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateMinimum(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateRange(0.2, 0.6), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateStd(1), 10) isa Vector{Vector{Float64}}
