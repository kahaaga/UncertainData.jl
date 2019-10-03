constraints = [TruncateStd(1 + rand()) for i in 1:length(example_uvals)]

UV = UncertainValueDataset(example_uvals)

# A single constraint applied to each element of the dataset
n = 5
@test resample(UV, NoConstraint()) isa Vector{Real}
@test resample(UV, TruncateLowerQuantile(0.2)) isa Vector{Real}
@test resample(UV, TruncateUpperQuantile(0.2)) isa Vector{Real}
@test resample(UV, TruncateQuantiles(0.2, 0.8)) isa Vector{Real}
@test resample(UV, TruncateMaximum(2)) isa Vector{Real}
@test resample(UV, TruncateMinimum(0.0)) isa Vector{Real}
@test resample(UV, TruncateRange(-40, 10)) isa Vector{Real}
@test resample(UV, TruncateStd(1)) isa Vector{Real}

@test resample(UV, NoConstraint(), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateLowerQuantile(0.2), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateUpperQuantile(0.2), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateQuantiles(0.2, 0.8), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateMaximum(2), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateMinimum(0), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateRange(-40, 10), n) isa Vector{Vector{Real}}
@test resample(UV, TruncateStd(1), n) isa Vector{Vector{Real}}

# Different constraints applied to each element of the dataset
n = 3
@test resample(UV, constraints) isa Vector{Real}
@test resample(UV, constraints, n) isa Vector{Vector{Real}}