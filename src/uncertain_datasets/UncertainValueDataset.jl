
"""
    UncertainValueDataset

A dataset of uncertain values.

## Fields

- **`values::UncertainDataset`**: The uncertain values. Each value is
    represented by an `AbstractUncertainValue`.
"""
struct UncertainValueDataset <: AbstractUncertainValueDataset
    values::UncertainDataset
end

Base.length(u::UncertainValueDataset) = length(u.values)
Base.getindex(u::UncertainValueDataset, i) = u.values[i]
Base.firstindex(u::UncertainValueDataset) = 1
Base.lastindex(u::UncertainValueDataset) = length(u.values)

Base.eachindex(u::UncertainValueDataset) = Base.OneTo(length(u))
Base.iterate(u::UncertainValueDataset, state = 1) = iterate(u.values, state)

getvalues(u::UncertainValueDataset, i) = u.values
getvalue(u::UncertainValueDataset, i) = u.values[i]


UncertainValueDataset(uv::AbstractUncertainValue) = UncertainValueDataset(UncertainDataset([uv]))

export
UncertainValueDataset,
getvalue,
getvalues
