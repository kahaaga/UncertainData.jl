include("AbstractUncertainDataset.jl")

"""
    UncertainDataset

Generic dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainDataset <: AbstractUncertainDataset
    values::AbstractVector{AbstractUncertainValue}
end


Base.getindex(ud::UncertainDataset, i) = ud.values[i]
Base.length(ud::UncertainDataset) = length(ud.values)
Base.size(ud::UncertainDataset) = length(ud)
Base.firstindex(ud::UncertainDataset) = length(ud.values)
Base.lastindex(ud::UncertainDataset) = length(ud.values)

Base.eachindex(ud::UncertainDataset) = Base.OneTo(length(ud.values))
Base.iterate(ud::UncertainDataset, state = 1) = iterate(ud.values, state)


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
distributions
