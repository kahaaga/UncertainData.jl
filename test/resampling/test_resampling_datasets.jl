import KernelDensity.UnivariateKDE

D = UncertainDataset([o1, o2, o3, o4, o5, o6, o7, o8, o9, o10])
UV = UncertainValueDataset(D)
UIV = UncertainIndexValueDataset(D, D)

n = length(D)
@test resample(D) isa Vector
@test resample(UV) isa Vector

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
