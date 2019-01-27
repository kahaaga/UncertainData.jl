abstract type AbstractUncertainDataset end


function summarise(ud::AbstractUncertainDataset)
    _type = typeof(ud)
    summary = "$_type"
    return summary
end

Base.show(io::IO, ud::AbstractUncertainDataset) = println(io, summarise(ud))

export AbstractUncertainDataset
