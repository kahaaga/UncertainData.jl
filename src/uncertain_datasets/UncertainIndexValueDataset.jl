"""
    UncertainIndexValueDataset

A generic dataset type consisting of uncertain values whose indices (time,
depth, order, etc...) are also uncertain value.


## Fields

- **`values::T` where {T <: AbstractUncertainValueDataset}**: The uncertain indices. 
    Will in general be an `UncertainIndexDataset`, but does not necessarily have to be.  
    Each index is represented by an `AbstractUncertainValue`.
- **`values::UncertainDataset`**: The uncertain values. Each value is
    represented by an `AbstractUncertainValue`.
"""
struct UncertainIndexValueDataset <: AbstractUncertainIndexValueDataset
    indices::AbstractUncertainValueDataset
    values::AbstractUncertainValueDataset
end

function UncertainIndexValueDataset(indices::Vector{<:AbstractUncertainValue},
        values::Vector{<:AbstractUncertainValue})
    
    indices = UncertainIndexDataset(indices)
    values = UncertainValueDataset(values)
    UncertainIndexValueDataset(indices, values)
end


Base.length(u::UncertainIndexValueDataset) = length(u.values)
Base.size(u::UncertainIndexValueDataset) = length(u.values)

Base.getindex(u::UncertainIndexValueDataset, i) = (u.indices[i], u.values[i])
Base.getindex(u::UncertainIndexValueDataset, i::AbstractVector) =
    [(u.indices[i], u.values[i]) for i in 1:length(u)]

Base.getindex(u::UncertainIndexValueDataset, i::Colon) =
        [(u.indices[i], u.values[i]) for i in 1:length(u)]

Base.firstindex(u::UncertainIndexValueDataset) = 1
Base.lastindex(u::UncertainIndexValueDataset) = length(u.values)

Base.eachindex(u::UncertainIndexValueDataset) = Base.OneTo(length(u))
Base.iterate(u::UncertainIndexValueDataset, state = 1) = iterate((u.indices, u.values), state)


index(u::UncertainIndexValueDataset, i) = u.indices[i]
value(u::UncertainIndexValueDataset, i) = u.values[i]



export
UncertainIndexValueDataset,
index, value
