include("truncation/truncate_population.jl")

import ..UncertainValues: 
    AbstractScalarPopulation,
    ConstrainedUncertainScalarPopulation

import StatsBase
import StatsBase: AbstractWeights


"""
    constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {T <: Number, PW}

Constrain an `UncertainScalarPopulation` (where population members are numerical scalars) by the 
given sampling `constraint`. 
"""
function constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {T <: Number, PW}
    # Get the population members and weights that fullfill the constraint and return them as a 
    # ConstrainedUncertainScalarPopulation
    truncate(pop, constraint)
end

function constrain(pop::UncertainScalarPopulation{T, PW}, constraint::NoConstraint) where {
    T <: AbstractUncertainValue, PW <: AbstractWeights}

    return pop
end

function constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {
    T <: AbstractUncertainValue, PW <: AbstractWeights}
    return truncate(pop, constraint)
end

# """
#     constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {T <: Number, PW}

# Constrain an `UncertainScalarPopulation` (where population members are numerical scalars) by the 
# given sampling `constraint`. 
# """
# function constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {T <: Number, PW}
#     # Get the population members and weights that fullfill the constraint.
#     members, wts = truncate(pop, constraint)
    
#     # Create a ConstrainedUncertainScalarPopulation, which is identical to UncertainScalarPopulation
#     # except the name.
#     ConstrainedUncertainScalarPopulation(members, wts)
# end

export constrain