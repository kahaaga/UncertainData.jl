using Reexport

@reexport module UncertainValues
    using IntervalArithmetic
    using Distributions
    using RecipesBase
    using StaticArrays

    # Distributions
    include("distributions/assign_dist.jl")

    # Abstract types and common methods
    include("AbstractUncertainValue.jl")
    include("AbstractEmpirical.jl")

    # Composite types
    include("UncertainScalars.jl")
    include("UncertainVectors.jl")
    include("UncertainScalarsEmpirical.jl")
    include("UncertainVectorsEmpirical.jl")

    # Common constructors
    include("UncertainValue.jl")


end #module
