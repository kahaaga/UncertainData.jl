"""
    AbstractUncertainValueDataset

A dataset of uncertain values, with fixed indices. Concrete implementations
must as a minimum implement the following fields:

- **`values::UncertainDataset`**: The (uncertain) values of the dataset.
"""
abstract type AbstractUncertainValueDataset <: AbstractUncertainDataset end


function summarise(uvd::AbstractUncertainValueDataset)
    _type = typeof(uvd)
    n_values = length(uvd.values)
    summary = "$_type with $n_values values"
    return summary
end

Base.show(io::IO, uvd::AbstractUncertainValueDataset) =
    println(io, summarise(uvd))

Base.getindex(uvd::AbstractUncertainValueDataset, i) = uvd.values[i]

Base.length(uvd::AbstractUncertainValueDataset) = length(uvd.values)
Base.size(uvd::AbstractUncertainValueDataset) = length(uvd)
Base.firstindex(uvd::AbstractUncertainValueDataset) = length(uvd.values)
Base.lastindex(uvd::AbstractUncertainValueDataset) = length(uvd.values)



export AbstractUncertainValueDataset
