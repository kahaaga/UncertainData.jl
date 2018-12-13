o1 = UncertainValue(0, 0.5, Normal)
o2 = UncertainValue(2.0, 0.1, Normal)
o3 = UncertainValue(0, 4, Uniform)
o4 = UncertainValue(rand(100), Uniform)
o5 = UncertainValue(4, 5, Beta)
o6 = UncertainValue(4, 5, Gamma)
o7 = UncertainValue(1, 2, Frechet)
o8 = UncertainValue(1, 2, BetaPrime)
o9 = UncertainValue(10, 3, 2, BetaBinomial)
o10 = UncertainValue(10, 0.3, Binomial)


@test resample(o1) isa Float64
@test resample(o2) isa Float64
@test resample(o3) isa Float64
@test resample(o4) isa Float64
@test resample(o5) isa Float64
@test resample(o6) isa Float64
@test resample(o7) isa Float64
@test resample(o8) isa Float64
@test resample(o9) isa Int
@test resample(o10) isa Int


D = UncertainDataset([o1, o2, o3, o4, o5, o6, o7, o8, o9, o10])
UV = UncertainValueDataset(D)
UIV = UncertainIndexValueDataset(D, D)

n = length(D)
@test resample(D) isa Vector
@test resample(UV) isa Vector

@test resample(D, 10) isa Vector
@test resample(UV, 10) isa Vector
#@test resample(UIV, 10) isa Vector
