abstract type AbstractUncertainDataset end

export AbstractUncertainDataset

function summarise(ud::AbstractUncertainDataset)
    _type = typeof(ud)
    summary = "$_type"
    return summary
end

Base.show(io::IO, ud::AbstractUncertainDataset) = println(io, summarise(ud))
