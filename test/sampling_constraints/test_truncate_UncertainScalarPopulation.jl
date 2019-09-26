pop1 = UncertainValue(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3), 
        UncertainValue(Uniform, rand(1000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

pop2 = UncertainValue([1, 2, 3], rand(3))
pop3 = UncertainValue([1.0, 2.0, 3.0], Weights(rand(3)))

# Uncertain population consisting of uncertain populations and other stuff
pop4 = UncertainValue([pop1, pop2], [0.1, 0.5])
pop5 = UncertainValue([pop1, pop2, 2], Weights(rand(3)));

#####################################################################
#  with `NoConstraint` should just yield the original 
#####################################################################
@test truncate(pop1, NoConstraint())[1] == pop1.values
@test truncate(pop2, NoConstraint())[1] == pop2.values
@test truncate(pop3, NoConstraint())[1] == pop3.values
@test truncate(pop4, NoConstraint())[1] == pop4.values
@test truncate(pop5, NoConstraint())[1] == pop5.values

#######################################################################
# Constraining populations whose members are strictly numerical scalars
########################################################################
@test constrain(pop2, TruncateMinimum(2)) isa ConstrainedUncertainScalarPopulation{T, PW} where {T <: Number, PW}
@test length(constrain(pop2, TruncateMinimum(2))) == 2
@test constrain(pop2, TruncateMinimum(2)).values == pop2.values[2:3]
@test constrain(pop2, TruncateMinimum(2)).probs == pop2.probs[2:3]

@test constrain(pop2, TruncateMaximum(2)) isa ConstrainedUncertainScalarPopulation{T, PW} where {T <: Number, PW}
@test length(constrain(pop2, TruncateMaximum(2))) == 2
@test constrain(pop2, TruncateMaximum(2)).values == pop2.values[1:2]
@test constrain(pop2, TruncateMaximum(2)).probs == pop2.probs[1:2]

@test constrain(pop2, TruncateRange(1.5, 2.5)) isa ConstrainedUncertainScalarPopulation{T, PW} where {T <: Number, PW}
@test length(constrain(pop2, TruncateRange(1.5, 2.5))) == 1
@test constrain(pop2, TruncateRange(1.5, 2.5)).values == [pop2.values[2]]
@test constrain(pop2, TruncateRange(1.5, 2.5)).probs == [pop2.probs[2]]


# mean(pop2, 50000), std(pop2, 50000) = (1.979748391146258, 3.2279716088537422)
# so TruncateStd(1) should remove the first point
constrain(pop2, TruncateStd(1))
@test constrain(pop2, TruncateStd(1)) isa ConstrainedUncertainScalarPopulation{T, PW} where {T <: Number, PW}
@test length(constrain(pop2, TruncateStd(1))) == 2
@test constrain(pop2, TruncateStd(1)).values == pop2.values[2:3]
@test constrain(pop2, TruncateStd(1)).probs == pop2.probs[2:3]



#@test constrain(uv, TruncateMinimum(0.2)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateMaximum(0.8)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateRange(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateStd(1)) isa ConstrainedUncertainScalarPopulation
#@test constrain(uv, TruncateStd(1.3)) isa ConstrainedUncertainScalarPopulation