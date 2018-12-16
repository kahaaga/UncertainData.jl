
D = UncertainDataset([o1, o2, o3, o4, o5, o6, o7, o8, o9, o10])
UV = UncertainValueDataset(D)
UIV = UncertainIndexValueDataset(D, D)

n = length(D)
@test resample(D) isa Vector
@test resample(UV) isa Vector

@test resample(D, 10) isa Vector
@test resample(UV, 10) isa Vector
#@test resample(UIV, 10) isa Vector
