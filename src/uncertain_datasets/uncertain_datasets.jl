
include("AbstractUncertainDataset.jl")

include("AbstractUncertainValueDataset.jl")
include("AbstractUncertainIndexValueDataset.jl")


# A generic UncertainDataset type which form the `values` field for
# AbstractUncertainValueDataset implementations. For
# AbstractUncertainValueIndexDataset implementations, both `indices` and
# `values` are instances of UncertainDataset.
include("UncertainDataset.jl")
include("UncertainValueDataset.jl")
include("UncertainIndexValueDataset.jl")
