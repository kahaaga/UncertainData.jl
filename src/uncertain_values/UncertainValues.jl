using Reexport

@reexport module UncertainValues
    using IntervalArithmetic
    using Distributions
    using RecipesBase
    using StaticArrays
    using KernelDensity
    using StatsBase

    # Distributions
    include("distributions/assign_dist.jl")

    # Abstract types and common methods
    include("AbstractUncertainValue.jl")
    include("AbstractEmpirical.jl")

    # Composite uncertain scalar types
    include("UncertainScalarsTheoretical.jl")
    include("UncertainScalarsTheoreticalFitted.jl")
    include("UncertainScalarsKDE.jl")

    # Composite uncertain vector types
    include("UncertainVectorsTheoretical.jl")
    include("UncertainVectorsTheoreticalFitted.jl")
    include("UncertainVectorsKDE.jl")

    # Define common constructor, so a similar syntax may be used to construct
    # all types of uncertain values.
    include("UncertainValue.jl")

    # Certain values (i.e. values without uncertainty)
    include("CertainValue.jl")
    
end #module

"""
	UncertainValues

A module defining uncertain value types.
"""
UncertainValues
