import ..UncertainValues: minimum, maximum

"""
    AbstractUncertainValueDataset

A dataset of uncertain values, with fixed indices. Concrete implementations
must as a minimum implement the following fields:

- **`values::UncertainDataset`**: The (uncertain) values of the dataset.
"""
abstract type AbstractUncertainValueDataset <: AbstractUncertainDataset end


##########################
# Indexing and iteration
#########################
Base.getindex(uvd::AbstractUncertainValueDataset, i) = uvd.values[i]
Base.length(uvd::AbstractUncertainValueDataset) = length(uvd.values)
Base.size(uvd::AbstractUncertainValueDataset) = length(uvd)
Base.firstindex(uvd::AbstractUncertainValueDataset) = 1
Base.lastindex(uvd::AbstractUncertainValueDataset) = length(uvd.values)

Base.eachindex(ud::AbstractUncertainValueDataset) = Base.OneTo(length(ud.values))
Base.iterate(ud::AbstractUncertainValueDataset, state = 1) = iterate(ud.values, state)


Base.minimum(udata::AbstractUncertainValueDataset) = minimum([minimum(uval) for uval in udata])
Base.maximum(udata::AbstractUncertainValueDataset) = maximum([maximum(uval) for uval in udata])


###################
# Pretty printing
###################
function summarise(ud::AbstractUncertainValueDataset)
    _type = typeof(ud)
    n_values = length(ud.values)
    summary = "$_type with $n_values values"
    return summary
end

Base.show(io::IO, ud::AbstractUncertainValueDataset) = print(io, summarise(ud))


###################
# Various useful functions
###################
"""
    distributions(ud::UncertainDataset)

Returns the distributions for all the uncertain values of the dataset.
"""
distributions(ud::AbstractUncertainValueDataset) = [ud[i].distribution for i = 1:length(ud)]




export 
AbstractUncertainValueDataset,
distributions 