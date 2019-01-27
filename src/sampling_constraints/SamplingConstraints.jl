using Reexport


@reexport module SamplingConstraints
    # Sampling constraints types
    include("constraint_definitions.jl")

    # Fallbacks when encountering incompatible sampling constraints
    include("fallback_constraints.jl")

    # Constrain uncertain values
    include("constrain_uncertainvalue.jl")
    include("constrain_certain_value.jl")
    include("constrain_population.jl")

    # Constrain uncertain datasets
    include("constrain_uncertaindataset.jl")
    include("constrain_uncertainvaluedataset.jl")
    include("constrain_uncertainindexdataset.jl")

    include("ordered_sequences/ordered_sequences.jl")

end # module

"""
    SamplingConstraints

A module defining:
1. Sampling constraints for the data types in the `UncertainValues` and
    `UncertainDatasets` modules.
2. Functions for resampling those data types.
"""
SamplingConstraints
