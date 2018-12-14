o1 = UncertainValue(Normal, 0, 0.5)
o2 = UncertainValue(Normal, 2.0, 0.1)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(Beta, 4, 5)
o6 = UncertainValue(Gamma, 4, 5)
o7 = UncertainValue(Frechet, 1, 2)
o8 = UncertainValue(BetaPrime, 1, 2)
o9 = UncertainValue(BetaBinomial, 10, 3, 2)
o10 = UncertainValue(Binomial, 10, 0.3)


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
