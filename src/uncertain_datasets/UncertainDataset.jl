include("AbstractUncertainDataset.jl")

abstract type AbstractUncertainValueDataset <: AbstractUncertainDataset end
abstract type AbstractUncertainIndexDataset <: AbstractUncertainDataset end

"""
    UncertainDataset

Generic dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainDataset{T <: AbstractUncertainValue} <: AbstractUncertainValueDataset
    values::AbstractVector{T}
end

"""
    ConstrainedUncertainDataset

Generic constrained dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct ConstrainedUncertainDataset{T <: AbstractUncertainValue} <: AbstractUncertainValueDataset
    values::AbstractVector{T}
end


"""
    UncertainIndices

Generic dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainIndices{T <: AbstractUncertainValue} <: AbstractUncertainIndexDataset
    values::AbstractVector{T}
end


"""
    ConstrainedUncertainIndices

Generic constrained dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct ConstrainedUncertainIndices{T <: AbstractUncertainValue} <: AbstractUncertainIndexDataset
    values::AbstractVector{T}
end



UncertainDataset(uv::AbstractUncertainValue) = UncertainDataset([uv])
ConstrainedUncertainDataset(uv::AbstractUncertainValue) = ConstrainedUncertainDataset([uv])

##########################
# Indexing and iteration
#########################
Base.getindex(ud::UncertainDataset, i) = ud.values[i]
Base.length(ud::UncertainDataset) = length(ud.values)
Base.size(ud::UncertainDataset) = length(ud)
Base.firstindex(ud::UncertainDataset) = length(ud.values)
Base.lastindex(ud::UncertainDataset) = length(ud.values)

Base.eachindex(ud::UncertainDataset) = Base.OneTo(length(ud.values))
Base.iterate(ud::UncertainDataset, state = 1) = iterate(ud.values, state)



##########################
# Sorting
#########################


###################
# Pretty printing
###################
function summarise(ud::UncertainDataset)
    _type = typeof(ud)
    n_values = length(ud.values)
    summary = "$_type with $n_values values"
    return summary
end

Base.show(io::IO, ud::UncertainDataset) = print(io, summarise(ud))

"""
    distributions(ud::UncertainDataset)

Returns the distributions for all the uncertain values of the dataset.
"""
distributions(ud::UncertainDataset) = [ud[i].distribution for i = 1:length(ud)]



export
UncertainDataset,
ConstrainedUncertainDataset,
UncertainIndices,
ConstrainedUncertainIndices,
distributions
