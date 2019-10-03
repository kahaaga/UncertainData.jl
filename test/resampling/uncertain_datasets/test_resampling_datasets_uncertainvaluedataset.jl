UV = UncertainValueDataset(example_uvals)

n = 3
@test resample(UV) isa Vector{T} where T <: Real
@test resample(UV, n) isa Vector{Vector{T}} where T <: Real