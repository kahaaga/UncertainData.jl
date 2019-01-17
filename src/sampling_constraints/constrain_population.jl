include("truncation/truncate_population.jl")

import ..UncertainValues: 
    AbstractScalarPopulation,
    ConstrainedUncertainScalarPopulation

function constrain(p::AbstractScalarPopulation, constraint::SamplingConstraint)
    ConstrainedUncertainScalarPopulation(truncate(p, constraint)...,)
end

export constrain