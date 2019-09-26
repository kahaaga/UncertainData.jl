##########################################
# Some uncertain datasets
##########################################
UI = UncertainIndexDataset(uidxs)

##########################################
# Apply functions to datasets `n` times
##########################################
n = 3
@test resample(median, UI, n) isa Vector{T} where T <: Real
@test resample(cor, UI, UI, n) isa Vector{T} where T <: Real

