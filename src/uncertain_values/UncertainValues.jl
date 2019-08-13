using Reexport

@reexport module UncertainValues
    using IntervalArithmetic
    using Distributions
    using RecipesBase
    using StaticArrays
    using KernelDensity
    using StatsBase

  
    # Abstract types and common methods
    include("AbstractUncertainValue.jl")
    include("AbstractEmpirical.jl")

    # Distributions
    include("distributions/assign_dist.jl")

    # Fitted distribution type 
    include("distributions/fitted_distribution.jl")

    ##########################################
    # Composite uncertain scalar types
    ##########################################
    # Theoretical distributions with known parameters
    include("UncertainScalarsTheoretical.jl")

    # Theoretical distributions with fitted parameters
    include("UncertainScalarsTheoreticalFitted.jl")

    # Kernel density estimated distributions
    include("UncertainScalarsKDE.jl")

    # Populations with weighted probabilities
    include("Population.jl")
    
    # Certain values (i.e. values without uncertainty)
    include("CertainValue.jl")

    ##########################################
    # Composite uncertain vector types
    ##########################################
    include("UncertainVectorsTheoretical.jl")
    include("UncertainVectorsTheoreticalFitted.jl")
    include("UncertainVectorsKDE.jl")


    # Define common constructor, so a similar syntax may be used to construct
    # all types of uncertain values.
    include("UncertainValue.jl")

    # Operations between uncertain UncertainValues
    include("../uncertain_values_operations/merge.jl")

end #module

"""
	UncertainValues

A module defining uncertain value types.
"""
UncertainValues
