include("truncation/truncate_population.jl")

import ..UncertainValues: 
    AbstractScalarPopulation,
    ConstrainedUncertainScalarPopulation

import StatsBase
import StatsBase: AbstractWeights

"""
    constrain(pop::UncertainScalarPopulation, constraint::SamplingConstraint, n::Int = 30000) 

Constrain an `UncertainScalarPopulation` by the given sampling `constraint`. If the 
sampling constraint requires resampling to compute, resample `n` times.
"""
function constrain(pop::UncertainScalarPopulation, constraint::SamplingConstraint, n::Int = 30000)
    # Get the population members and weights that fullfill the constraint and return them as a 
    # ConstrainedUncertainScalarPopulation
    truncate(pop, constraint, n)
end

export constrain