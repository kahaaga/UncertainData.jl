a, b, c = [UncertainValue(Normal, 1, 0.5) for i = 1:20], 
            UncertainValue(rand(1000)), 
            UncertainValue(Uniform, rand(10000))
uvals = [a; b; c]
udata = UncertainDataset(uvals)
iv = UncertainIndexValueDataset(udata, udata)

@test resample(udata, NoConstraint(), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateLowerQuantile(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateUpperQuantile(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateQuantiles(0.2, 0.8), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateMaximum(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateMinimum(0.2), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateRange(0.2, 0.6), 10) isa Vector{Vector{Float64}}
@test resample(udata, TruncateStd(1), 10) isa Vector{Vector{Float64}}




@test resample(iv, NoConstraint()) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateLowerQuantile(0.2)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateUpperQuantile(0.2)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateQuantiles(0.2, 0.8)) isa Tuple{Vector{Float64}, Vector{Float64}}

@test resample(iv, NoConstraint(), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateLowerQuantile(0.2), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateUpperQuantile(0.2), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateQuantiles(0.2, 0.8), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}

@test length(resample(iv, NoConstraint(), 5)) == 5
@test length(resample(iv, TruncateLowerQuantile(0.2), 5)) == 5
@test length(resample(iv, TruncateUpperQuantile(0.2), 5)) == 5
@test length(resample(iv, TruncateQuantiles(0.2, 0.8), 5)) == 5
