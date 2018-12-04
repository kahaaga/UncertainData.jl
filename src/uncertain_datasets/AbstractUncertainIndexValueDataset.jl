"""
    AbstractUncertainIndexValueDataset

A dataset of uncertain value (`UncertainValue` instances), with indices (time,
depth, etc..) that are also uncertain values (`UncertainValue` instances).

Concrete types must as a minimum implement the following fields:

- **`indices::UncertainDataset`**: The (uncertain) indices of the dataset.
- **`values::UncertainDataset`**: The (uncertain) values of the dataset.
"""
abstract type AbstractUncertainIndexValueDataset <: AbstractUncertainDataset end

function summarise(uid::AbstractUncertainIndexValueDataset)
    _type = typeof(uid)
    n_values = length(uid.indices)
    summary = "$_type with $n_values uncertain values that each have uncertain indices."
    return summary
end

Base.show(io::IO, uid::AbstractUncertainIndexValueDataset) =
    println(io, summarise(uid))


export AbstractUncertainIndexValueDataset
