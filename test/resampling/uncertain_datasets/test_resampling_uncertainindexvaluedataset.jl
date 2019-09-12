a = [UncertainValue(Normal, 1, 0.5) for i = 1:10]
b = UncertainValue(rand(1000))
c = UncertainValue(Uniform, rand(10000))
s = rand(-20:20, 100)
e = UncertainValue(s, rand(length(s)))
f = UncertainValue(2)
g = UncertainValue(3.1)

uidxs =  UncertainIndexDataset([a; b; c; e; f; g])
uvals = UncertainValueDataset([a; b; c; e; f; g])
iv = UncertainIndexValueDataset(uidxs, uvals)

@test resample(iv, NoConstraint()) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateLowerQuantile(0.2)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateUpperQuantile(0.2)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateQuantiles(0.2, 0.8)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateMaximum(10)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateMinimum(-20)) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, TruncateRange(-20, 20)) isa Tuple{Vector{Float64}, Vector{Float64}}

@test resample(iv, NoConstraint(), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateLowerQuantile(0.2), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateUpperQuantile(0.2), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateQuantiles(0.2, 0.8), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateMaximum(10), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateMinimum(-20), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test resample(iv, TruncateRange(-20, 20), 5) isa Vector{Tuple{Vector{Float64}, Vector{Float64}}}

@test length(resample(iv, NoConstraint(), 5)) == 5
@test length(resample(iv, TruncateLowerQuantile(0.2), 5)) == 5
@test length(resample(iv, TruncateUpperQuantile(0.2), 5)) == 5
@test length(resample(iv, TruncateQuantiles(0.2, 0.8), 5)) == 5
@test length(resample(iv, TruncateMaximum(10), 5)) == 5
@test length(resample(iv, TruncateMinimum(-20), 5)) == 5
@test length(resample(iv, TruncateRange(-20, 20), 5)) == 5

