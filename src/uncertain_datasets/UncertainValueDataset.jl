
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

values(u::UncertainValueDataset, i) = u.values[i]


"""
	resample(uvd::UncertainValueDataset)

Draw a realisation of an `UncertainValueDataset` according to the distributions
of the `UncertainValue`s comprising it.
"""
function resample(uvd::UncertainValueDataset)
	L = length(uvd)
	[resample(uvd.values[i]) for i in 1:L]
end

"""
	resample(uvd::UncertainValueDataset)

Draw `n` realisations of an `UncertainValueDataset` according to the
distributions of the `UncertainValue`s comprising it.
"""
function resample(uvd::UncertainValueDataset, n::Int)
	L = length(uvd)
	[[resample(uvd.values[i]) for i in 1:L] for k in 1:n]
end


export
UncertainValueDataset,
values,
resample
