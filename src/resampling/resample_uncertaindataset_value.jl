import ..UncertainDatasets.UncertainValueDataset

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
