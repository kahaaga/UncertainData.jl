##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it.
##########################################################################
"""
	resample(uv::UncertainDataset) -> Vector{Float64}

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
