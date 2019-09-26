
##########################################
# Some uncertain datasets
##########################################
UV = UncertainValueDataset(uvals)

##########################################
# Apply functions to datasets `n` times
##########################################
n = 3

@test resample(median, UV, n) isa Vector{T} where T <: Real
@test resample(cor, UV, UV, n) isa Vector{T} where T <: Real

