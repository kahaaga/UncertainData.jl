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
o14 = UncertainValue([2, 3, 4], [0.3, 0.4, 0.3])
o15 = UncertainValue([rand() for i = 1:100])


uvals1 = [o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, o14, o1, o2, o3, o15, o4, o5, 
    o6, o7, o8, o9, o11, o12, o13, o14, o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, 
    o14, o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, o14]


# resample(uvals::Vector{AbstractUncertainValue})
@test resample(uvals1) isa Vector
@test length(resample(uvals1)) == length(uvals1)

# resample(uvals::Vector{AbstractUncertainValue}, n::Int) 
n = 2
@test resample(uvals1, n) isa Vector{Vector{T}} where T <: Real
@test length(resample(uvals1, n)) == n

# resample_elwise(uvals::Vector{AbstractUncertainValue}, n::Int) 
n = 2
@test resample_elwise(uvals1, n) isa Vector{Vector}
@test length(resample_elwise(uvals1, n)) == length(uvals1)
@test length(resample_elwise(uvals1, n)[1]) == n