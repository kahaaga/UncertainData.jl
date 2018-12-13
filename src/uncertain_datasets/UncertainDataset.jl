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

"""
    UncertainIndexDataset

Generic dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainIndexDataset <: AbstractUncertainDataset
    values::AbstractVector{AbstractUncertainValue}
end

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


##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it.
##########################################################################
import ..UncertainValues.resample

"""
	resample(uv::UncertainDataset) -> SVector{Float64}

Draw a realisation of an `UncertainDataset` according to the distributions
of the `UncertainValue`s comprising it.
"""
function resample(uv::UncertainDataset)
	L = length(uv)
	[resample(uv.values[i]) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, n::Int)

Draw `n` realisations of an `UncertainDataset` according to the distributions
of the `UncertainValue`s comprising it.
"""
function resample(uv::UncertainDataset, n::Int)
	L = length(uv)
	[[resample(uv.values[i]) for i in 1:L] for k = 1:n]
end


export
UncertainDataset,
distributions,
resample
