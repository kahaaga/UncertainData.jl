import KernelDensity.UnivariateKDE
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
o11 = UncertainValue(rand(100), rand(100))
o12 = UncertainValue(2)
o13 = UncertainValue(2.3)
o14 = UncertainValue([2, 3, 4], [0.3, 0.4, 0.1])


uvals = [o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, o14]
D = UncertainDataset(uvals)
UV = UncertainValueDataset(uvals)
UIDX = UncertainIndexDataset(uvals)
UIV = UncertainIndexValueDataset(D, D)

n = length(D)
@test resample(D) isa Vector
@test resample(UV) isa Vector
@test resample(UIDX) isa Vector
@test resample(D, 10) isa Vector
@test resample(UV, 10) isa Vector
#@test resample(UIV, 10) isa Vector

######################################################################
# Resampling datasets consisting of uncertain values furnished by
# theoretical distributions
######################################################################
measurements = [UncertainValue(Normal, 0, 0.1) for i = 1:5]
d = UncertainDataset(measurements)

@test resample(d) isa Vector{Float64}
@test resample(d, 10) isa Vector{Vector{Float64}}

##########################################################################
# Resampling datasets consisting of uncertain values furnished by
# theoretical distributions with parameters estimated from empirical data.
##########################################################################
measurements = [UncertainValue(Normal, rand(Normal(), 1000)) for i = 1:5]
d = UncertainDataset(measurements)

@test resample(d) isa Vector{Float64}
@test resample(d, 10) isa Vector{Vector{Float64}}

##########################################################################
# Resampling datasets consisting of uncertain values furnished by
# kernel density estimations to the distributions.
##########################################################################
measurements = [UncertainValue(UnivariateKDE, rand(Normal(), 1000)) for i = 1:5]
d = UncertainDataset(measurements)
@test resample(d) isa Vector{Float64}
@test resample(d, 10) isa Vector{Vector{Float64}}

##########################################################################
# Resampling datasets consisting of a mixture of different types of
# uncertain values
##########################################################################
measurements = [UncertainValue(rand(100));
                UncertainValue(Normal, rand(Normal(), 100));
                UncertainValue(Normal, 0, 2)]
d = UncertainDataset(measurements)
@test resample(d) isa Vector{Float64}
@test resample(d, 10) isa Vector{Vector{Float64}}


iv = UncertainIndexValueDataset(d, d)

@test resample(iv) isa Tuple{Vector{Float64}, Vector{Float64}}
@test resample(iv, 5) isa  Vector{Tuple{Vector{Float64}, Vector{Float64}}}
@test length(resample(iv, 5)) == 5
