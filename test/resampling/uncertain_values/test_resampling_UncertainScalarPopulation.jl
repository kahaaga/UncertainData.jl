# Just a regular population consisting of different uncertain values
u1 = UncertainValue(Normal, 0, 0.1)
u2 = UncertainValue(Uniform, rand(100))
u3 = UncertainValue(rand(100))
u4 = UncertainValue(Normal, 5, 0.1)
u5 = UncertainValue(Normal, 10, 1.5)

vals = [u1, u2, u3, u4, u5, 6]
wts = [1, 3, 3, 1, 0.5, 0.1]

pop = UncertainScalarPopulation(vals, wts)
@test resample(pop) isa Real
@test resample(pop, 10) isa Vector{T} where {T <: Real}

# Nested populations
x = UncertainScalarPopulation([u1, u2, u3], [1, 1, 2])
vals = [pop, u2, x, u4, u5, 6]
wts = [1, 3, 3, 1, 0.5, 0.1]
pop2 = UncertainScalarPopulation(vals, weights(rand(6)))
@test resample(pop2) isa Real
@test resample(pop2, 10) isa Vector{T} where {T <: Real}


# Create a population consisting of a mixture of different types of uncertain values, 
# both theoretical, fitted from empirical distributions, and discrete populations.
u1 = UncertainValue(Normal, 0, 0.1)
u2 = UncertainValue(Uniform, rand(100))
u3 = UncertainValue(rand(100))
u4 = UncertainValue(Normal, 5, 0.1)
u5 = UncertainValue(Normal, 10, 1.5)

wts = [1, 3, 3, 1, 0.5]
vals = [u1, u2, u3, u4, u5]
pop3 = UncertainScalarPopulation(vals, wts)

@test resample(pop3) isa Real
@test resample(pop3, 10) isa Vector{T} where {T <: Real}

