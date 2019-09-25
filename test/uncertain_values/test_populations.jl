import StatsBase: AbstractWeights

# Uncertain population consisting of CertainValues (scalars get promoted to CertainValue)s
# theoretical distributions and KDE distributions
x = UncertainScalarPopulation(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3), 
        UncertainValue(Uniform, rand(1000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

# Uncertain population consisting of scalar values
y = UncertainScalarPopulation([1, 2, 3], rand(3))
z = UncertainScalarPopulation([1, 2, 3], Weights(rand(3)))

# Uncertain population consisting of uncertain populations
w = UncertainScalarPopulation([x, y], [0.1, 0.5])
x = UncertainScalarPopulation([x, y], Weights([0.1, 0.5]));

@test x isa UncertainScalarPopulation{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: AbstractWeights}
@test y isa UncertainScalarPopulation{T1, T2} where {T1 <: Number, T2 <: AbstractWeights}
@test z isa UncertainScalarPopulation{T1, T2} where {T1 <: Number, T2 <: AbstractWeights}
@test w isa UncertainScalarPopulation{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: AbstractWeights}
@test x isa UncertainScalarPopulation{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: AbstractWeights}