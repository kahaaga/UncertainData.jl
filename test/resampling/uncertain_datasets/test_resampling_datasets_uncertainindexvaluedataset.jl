UI = UncertainValueDataset(uidxs)
UV = UncertainValueDataset(uvals)
UIV = UncertainIndexValueDataset(UI, UV)

n = 3
@test resample(UIV) isa Tuple{Vector}
@test resample(UIV, n) isa Vector{Tuple{Vector}}