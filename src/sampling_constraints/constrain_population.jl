include("truncation/truncate_population.jl")

import ..UncertainValues: 
    AbstractScalarPopulation,
    ConstrainedUncertainScalarPopulation

"""
    constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {T <: Number, PW}

Constrain an `UncertainScalarPopulation` (where population members are numerical scalars) by the 
given sampling `constraint`. 
"""
function constrain(pop::UncertainScalarPopulation{T, PW}, constraint::SamplingConstraint) where {T <: Number, PW}
    # Get the population members and weights that fullfill the constraint.
    members, wts = truncate(pop, constraint)
    
    # Create a ConstrainedUncertainScalarPopulation, which is identical to UncertainScalarPopulation
    # except the name.
    ConstrainedUncertainScalarPopulation(members, wts)
end

export constrain