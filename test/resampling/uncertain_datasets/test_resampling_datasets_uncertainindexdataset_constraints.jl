
constraints = [i % 2 == 0 ? TruncateStd(0.3) : TruncateQuantiles(0.1, 0.9) 
    for i in 1:length(uvals)]

UI = UncertainIndexDataset(uidxs)

# A single constraint applied to each element of the dataset
n = 3

@test resample(UI, NoConstraint()) isa Vector{Real}
@test resample(UI, TruncateLowerQuantile(0.2)) isa Vector{Real}
@test resample(UI, TruncateUpperQuantile(0.2)) isa Vector{Real}
@test resample(UI, TruncateQuantiles(0.2, 0.8)) isa Vector{Real}
@test resample(UI, TruncateMaximum(0.2)) isa Vector{Real}
@test resample(UI, TruncateMinimum(0.2)) isa Vector{Real}
@test resample(UI, TruncateRange(-40, 10)) isa Vector{Real}
@test resample(UI, TruncateStd(1)) isa Vector{Real}

@test resample(UI, NoConstraint(), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateLowerQuantile(0.2), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateUpperQuantile(0.2), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateQuantiles(0.2, 0.8), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateMaximum(0.2), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateMinimum(0.2), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateRange(-40, 10), n) isa Vector{Vector{Real}}
@test resample(UI, TruncateStd(1), n) isa Vector{Vector{Real}}

# Different constraints applied to each element of the dataset
n = 3
@test resample(UI, constraints) isa Vector{<:Real}
@test resample(UI, constraints, n) isa Vector{Vector{<:Real}}
