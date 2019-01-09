import ..UncertainDatasets: UncertainIndexValueDataset
import ..SamplingConstraints: SamplingConstraint

"""
	resample(udata::UncertainIndexValueDataset) -> Tuple{Vector{Float64}, Vector{Float64}}

Draw a realisation of an `UncertainIndexValueDataset` according to the
distributions of the `UncertainValue`s comprising the indices and data points.
"""
function resample(udata::UncertainIndexValueDataset) 
	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx)
		values[i] = resample(val)
	end 

	indices, values
end

"""
	resample(uivd::UncertainIndexValueDataset, n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Draw `n` realisations of an `UncertainIndexValueDataset` according to the
distributions of the `UncertainValue`s comprising the indices and data points.
"""

"""
	resample(udata::UncertainIndexValueDataset) -> Tuple{Vector{Float64}, Vector{Float64}}

Draw a realisation of an `UncertainIndexValueDataset` according to the
distributions of the `UncertainValue`s comprising the indices and data points.
"""
function resample(udata::UncertainIndexValueDataset, n::Int) 
	n_vals = length(udata)
	[resample(udata) for i = 1:n_vals]
end


function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::SamplingConstraint, 
		constraint_vals::SamplingConstraint)

	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx, constraint_idxs)
		values[i] = resample(val, constraint_vals)
	end 

	indices, values
end


function resample(udata::UncertainIndexValueDataset, 
	constraint_idxs::Vector{SamplingConstraint}, 
	constraint_vals::SamplingConstraint)

	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx, constraint_idxs[i])
		values[i] = resample(val, constraint_vals)
	end 

	indices, values
end

function resample(udata::UncertainIndexValueDataset, 
	constraint_idxs::SamplingConstraint, 
	constraint_vals::Vector{SamplingConstraint})

	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx, constraint_idxs)
		values[i] = resample(val, constraint_vals[i])
	end 

	indices, values
end

function resample(udata::UncertainIndexValueDataset, 
	constraint_idxs::Vector{SamplingConstraint}, 
	constraint_vals::Vector{SamplingConstraint})

	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx, constraint_idxs[i])
		values[i] = resample(val, constraint_vals[i])
	end 

	indices, values
end

export resample
