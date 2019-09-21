using Test

o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(Beta, 4, 5)
o6 = UncertainValue(Gamma, 4, 5)
o7 = UncertainValue(rand(1000))
o8 = UncertainValue(Normal, 0, 2)


# 2-tuples
t1 = (o4, o5)

# n-tuples (a 5-tuple, including scalars)
t2 = (o4, o5, o6, o7, o8, 6);

@test resample(t1) isa NTuple{2, T} where T <: Number
@test resample(t2) isa NTuple{6, T} where T <: Number
@test resample(t1, 5) isa Vector{NTuple{2, T}} where {N, T <: Number}
@test resample(t2, 5) isa Vector{NTuple{6, T}} where {N, T <: Number}