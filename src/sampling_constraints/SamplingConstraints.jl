using Reexport


@reexport module SamplingConstraints
    # Sampling constraints types
    include("constraint_definitions.jl")

    # Fallbacks when encountering incompatible sampling constraints
    include("fallback_constraints.jl")

    # Constrain uncertain values
    include("constrain_uncertainvalue.jl")

    # Constrain uncertain datasets
    include("constrain_uncertaindataset.jl")

end # module

"""
    SamplingConstraints

A module defining:
1. Sampling constraints for the data types in the `UncertainValues` and
    `UncertainDatasets` modules.
2. Functions for resampling those data types.
"""
SamplingConstraints
