abstract type AbstractUncertainIndexDataset <: AbstractUncertainValueDataset end


##########################
# Indexing and iteration
#########################
Base.getindex(uvd::AbstractUncertainIndexDataset, i) = uvd.indices[i]
Base.length(uvd::AbstractUncertainIndexDataset) = length(uvd.indices)
Base.size(uvd::AbstractUncertainIndexDataset) = length(uvd)
Base.firstindex(uvd::AbstractUncertainIndexDataset) = 1
Base.lastindex(uvd::AbstractUncertainIndexDataset) = length(uvd.indices)

Base.eachindex(ud::AbstractUncertainIndexDataset) = Base.OneTo(length(ud.indices))
Base.iterate(ud::AbstractUncertainIndexDataset, state = 1) = iterate(ud.indices, state)

Base.minimum(udata::AbstractUncertainIndexDataset) = minimum([minimum(uval) for uval in udata])
Base.maximum(udata::AbstractUncertainIndexDataset) = maximum([maximum(uval) for uval in udata])


###################
# Pretty printing
###################

function summarise(uvd::AbstractUncertainIndexDataset)
    _type = typeof(uvd)
    n_values = length(uvd.indices)
    summary = "$_type with $n_values values"
    return summary
end

Base.show(io::IO, uvd::AbstractUncertainIndexDataset) =
    println(io, summarise(uvd))

