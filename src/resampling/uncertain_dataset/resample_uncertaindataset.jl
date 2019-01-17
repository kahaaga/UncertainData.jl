import ..UncertainDatasets:
	AbstractUncertainValueDataset,
	UncertainDataset,
	ConstrainedUncertainDataset

import ..SamplingConstraints: 
	SamplingConstraint,
	constrain

# Resample tuples of uncertain values (representing an index-value pair)
resample(uvs::Tuple{AbstractUncertainValue, AbstractUncertainValue}) = 
	resample(uvs[1]), resample(uvs[2])

resample(uvs::Tuple{AbstractUncertainValue, AbstractUncertainValue}, n::Int) = 
	[resample(uvs) for i = 1:n]

##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it.
##########################################################################


"""
	resample(uv::UncertainDataset) -> Vector{Float64}

Resample an uncertain value dataset in an element-wise manner. 

Draws values from the entire support of the furnishing distributions.
"""
function resample(uv::DT) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[resample(uv.values[i]) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, n::Int) -> Vector{Vector{Float64}}

Resample `n` realizations of an uncertain value dataset in an element-wise manner. 

Draws values from the entire support of the furnishing distributions.
"""
function resample(uv::DT, n::Int)  where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[[resample(uv.values[i]) for i in 1:L] for k = 1:n]
end

"""
	resample(udata::AbstractUncertainValueDataset, 
		constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}) -> Vector{Float64}

Resample an uncertain value dataset in an element-wise manner. 

Enforces the provided sampling `constraint`(s) to each of the data values, possibly 
truncating the support of the furnishing distributions from which values are drawn.

If a single constraint is provided, then that constraint will be applied to all values. If a 
vector of constraints (as many as there are values) is provided, then the constraints are 
applied element-wise to the data values.
"""
resample(udata::AbstractUncertainValueDataset, 
	constraint::Union{SamplingConstraint, Vector{SamplingConstraint}})

"""
	resample(udata::AbstractUncertainValueDataset, 
		constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
		n::Int) -> Vector{Vector{Float64}}

Resample `n` realizations of an uncertain value dataset in an element-wise manner. 

Enforces the provided sampling `constraint`(s) to each of the data values, possibly 
truncating the support of the furnishing distributions from which values are drawn.

If a single constraint is provided, then that constraint will be applied to all values. If a 
vector of constraints (as many as there are values) is provided, then the constraints are 
applied element-wise to the data values.
"""
resample(udata::AbstractUncertainValueDataset, 
	constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
	n::Int)

"""
	resample(udata::AbstractUncertainValueDataset, constraint::SamplingConstraint)

Resample an uncertain dataset once after first limiting the support of the furnishing 
distribution of each uncertain value by applying a sampling constraint.
"""
function resample(udata::DT, 
		constraint::SamplingConstraint) where {DT <: AbstractUncertainValueDataset}
    resample(constrain(udata, constraint))
end

"""
	resample(udata::AbstractUncertainValueDataset, constraint::SamplingConstraint, n::Int)

Resample an uncertain dataset `n` times after first limiting the support of the furnishing 
distribution of each uncertain value by applying a sampling constraint.
"""
function resample(udata::DT, constraint::SamplingConstraint, 
		n::Int) where {DT <: AbstractUncertainValueDataset}
    resample(constrain(udata, constraint), n)
end

"""
	resample(udata::AbstractUncertainValueDataset, constraints::Vector{SamplingConstraint})

Resample an uncertain dataset once after first limiting the support of the furnishing 
distribution of each uncertain value it the dataset, applying a different sampling 
constraint to each value.
"""
resample(udata::DT, constraints::Vector{SamplingConstraint}, 
		n) where {DT <: AbstractUncertainValueDataset} = 
    resample(constrain(udata, constraints), n) 

"""
	resample(udata::AbstractUncertainValueDataset, constraints::Vector{SamplingConstraint}, 
		n::Int) 

Resample an uncertain dataset `n` times after first limiting the support of the furnishing 
distribution of each uncertain value it the dataset, applying a different sampling 
constraint to each value.
"""
function resample(udata::DT, 
		constraints::Vector{SamplingConstraint}, 
		n::Int) where {DT <: AbstractUncertainValueDataset}
	
    resample(constrain(udata, constraints), n)
end

export resample