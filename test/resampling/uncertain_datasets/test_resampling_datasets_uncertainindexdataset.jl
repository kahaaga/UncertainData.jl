
UI = UncertainIndexDataset(uidxs)

n = 3
@test resample(UI) isa Vector{<:Real}
@test resample(UI, n) isa Vector{Vector{T}} where T <: Real