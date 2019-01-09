import ..UncertainDatasets:
	AbstractUncertainValueDataset,
	UncertainDataset,
	ConstrainedUncertainDataset

import ..SamplingConstraints: 
	SamplingConstraint,
	constrain

##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it.
##########################################################################

"""
	resample(uv::UncertainDataset)

Draw `n` realisations of an `UncertainDataset` according to the distributions
of the `UncertainValue`s comprising it.
"""
function resample(uv::AbstractUncertainValueDataset)
	L = length(uv)
	[resample(uv.values[i]) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, n::Int)

Draw `n` realisations of an `UncertainDataset` according to the distributions
of the `UncertainValue`s comprising it.
"""
function resample(uv::AbstractUncertainValueDataset, n::Int)
	L = length(uv)
	[[resample(uv.values[i]) for i in 1:L] for k = 1:n]
end

"""
Resample an uncertain dataset once after first limiting the support of the furnishing 
distribution of each uncertain value by applying a sampling constraint.
"""
function resample(udata::AbstractUncertainValueDataset, constraint::SamplingConstraint)
    resample(constrain(udata, constraint))
end

"""
Resample an uncertain dataset `n` times after first limiting the support of the furnishing 
distribution of each uncertain value by applying a sampling constraint.
"""
function resample(udata::AbstractUncertainValueDataset, constraint::SamplingConstraint, n::Int)
    resample(constrain(udata, constraint), n)
end

"""
Resample an uncertain dataset once after first limiting the support of the furnishing 
distribution of each uncertain value it the dataset, applying a different sampling 
constraint to each value.
"""
resample(udata::AbstractUncertainValueDataset, constraints::Vector{SamplingConstraint}) = 
    resample(constrain(udata, constraints), n)

"""
Resample an uncertain dataset `n` times after first limiting the support of the furnishing 
distribution of each uncertain value it the dataset, applying a different sampling 
constraint to each value.
"""
resample(udata::AbstractUncertainValueDataset, constraints::Vector{SamplingConstraint}, n::Int = 10) = 
    resample(constrain(udata, constraints), n)

export resample