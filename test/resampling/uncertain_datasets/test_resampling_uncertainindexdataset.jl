
#Vectors of uncertain values
uvals_x = [UncertainValue(Normal, rand(Normal(0, 5)), abs(rand(Normal(0, 3)))) for i = 1:100]
uvals_y = [UncertainValue(Normal, rand(Normal(0, 5)), abs(rand(Normal(0, 3)))) for i = 1:100];

# UncertainIndexDataset
UVX_idx = UncertainIndexDataset(uvals_x)
UVY_idx = UncertainIndexDataset(uvals_y)

constraints = [[TruncateStd(0.3) for x in 1:50]; [TruncateQuantiles(0.3, 0.7) for x in 1:50]]

@test resample(UVX_idx) isa Vector{<:Real}
@test resample(UVY_idx) isa Vector{<:Real}
@test resample(UVX_idx, constraints[1]) isa Vector{<:Real}
@test resample(UVY_idx, constraints[1]) isa Vector{<:Real}
@test resample(UVX_idx, constraints) isa Vector{<:Real}
@test resample(UVY_idx, constraints) isa Vector{<:Real}

# Test for some more complicated uncertain values
#----------------------------------------------
a = [UncertainValue(Normal, 1, 0.5) for i = 1:10]
b = UncertainValue(rand(1000))
c = UncertainValue(Uniform, rand(10000))
s = rand(-20:20, 100)
e = UncertainValue(s, rand(length(s)))
f = UncertainValue(2)
g = UncertainValue(3.1)

udata = UncertainIndexDataset([a; b; c; e; f; g])

@test resample(udata, NoConstraint(), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateLowerQuantile(0.2), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateUpperQuantile(0.2), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateQuantiles(0.2, 0.8), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateMaximum(0.2), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateMinimum(0.2), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateRange(-40, 10), 10) isa Vector{Vector{Real}}
@test resample(udata, TruncateStd(1), 10) isa Vector{Vector{Real}}
