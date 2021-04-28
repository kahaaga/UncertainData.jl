import StatsBase: AbstractWeights

# Uncertain population consisting of CertainScalars (scalars get promoted to CertainScalar)s
# theoretical distributions and KDE distributions
p1 = UncertainScalarPopulation(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3), 
        UncertainValue(Uniform, rand(1000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

# Uncertain population consisting of scalar values
p2 = UncertainScalarPopulation([1, 2, 3], rand(3))
p3 = UncertainScalarPopulation([1, 2, 3], Weights(rand(3)))

# Uncertain population consisting of uncertain populations
p4 = UncertainScalarPopulation([p1, p2], [0.1, 0.5])
p5 = UncertainScalarPopulation([p1, p2], Weights([0.1, 0.5]));

@test p1 isa UncertainScalarPopulation{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: AbstractWeights}
@test p2 isa UncertainScalarPopulation{T1, T2} where {T1 <: Number, T2 <: AbstractWeights}
@test p3 isa UncertainScalarPopulation{T1, T2} where {T1 <: Number, T2 <: AbstractWeights}
@test p4 isa UncertainScalarPopulation{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: AbstractWeights}
@test p5 isa UncertainScalarPopulation{T1, T2} where {T1 <: AbstractUncertainValue, T2 <: AbstractWeights}
