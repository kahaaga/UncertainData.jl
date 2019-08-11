import ..UncertainDatasets: UncertainIndexValueDataset
import ..SamplingConstraints: SamplingConstraint

# Some summary documentaiton for the online documentation 
""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces the provided sampling `constraint` to all uncertain values in the dataset, both 
indices and data values.

If a single constraint is provided, then that constraint will be applied to all values. If a 
vector of constraints (as many as there are values) is provided, then the constraints are 
applied element-wise to both the indices and the data values.
""" 
resample(udata::UncertainIndexValueDataset, 
	constraint::Union{SamplingConstraint, Vector{SamplingConstraint}})

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
		n::Int) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces the provided sampling `constraint` to all uncertain values in the dataset, both 
indices and data values.

If a single constraint is provided, that constraint will be applied to all values. If a 
vector of constraints (as many as there are values) is provided, then the constraints are 
applied element-wise to both the indices and the data values.
""" 
resample(udata::UncertainIndexValueDataset, 
	constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
	n::Int)


""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
		constraint_vals::Union{SamplingConstraint, Vector{SamplingConstraint}}) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces separate sampling constraints to the indices and to the data values. 

If a single constraint is provided, that constraint will be applied to all values. If a 
vector of constraints (as many as there are values) is provided, then the constraints are 
applied element-wise.
""" 
resample(udata::UncertainIndexValueDataset, 
	constraint_idxs::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
	constraint_vals::Union{SamplingConstraint, Vector{SamplingConstraint}})	

	""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
		constraint_vals::Union{SamplingConstraint, Vector{SamplingConstraint}},
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces separate sampling constraints to the indices and to the data values. 

If a single constraint is provided, that constraint will be applied to all values. If a 
vector of constraints (as many as there are values) is provided, then the constraints are 
applied element-wise.
""" 
resample(udata::UncertainIndexValueDataset, 
	constraint_idxs::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
	constraint_vals::Union{SamplingConstraint, Vector{SamplingConstraint}},
	n::Int)


###########################################
# The documentation for the actual methods
###########################################

"""
	resample(udata::UncertainIndexValueDataset) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner.
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
	resample(udata::UncertainIndexValueDataset, 
		constraint::SamplingConstraint) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset element-wise in an element-wise manner.

Enforces the provided sampling `constraint` to all uncertain values in the dataset, both 
indices and data values.
""" 
function resample(udata::UncertainIndexValueDataset, constraint::SamplingConstraint)

	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx, constraint)
		values[i] = resample(val, constraint)
	end 

	indices, values
end




""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::SamplingConstraint, 
		constraint_vals::SamplingConstraint) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces the same sampling constraint `constraint_idxs` to all index values, and the 
`constraint_vals` sampling constraint to all data values.
""" 
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


""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces a unique sampling constraint `constraint_idxs[i]` to the i-th index value, 
while using the same sampling constraint `constraint_vals` on all data values.
""" 
function resample(udata::UncertainIndexValueDataset, 
	constraint_idxs::Vector{<:SamplingConstraint}, 
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

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces a unique sampling constraint `constraint_idxs[i]` to both the i-th index value 
and to the i-th data value. 
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint::Vector{<:SamplingConstraint})

	n_vals = length(udata)
	indices = zeros(Float64, n_vals)
	values = zeros(Float64, n_vals)

	for i = 1:n_vals
		idx, val = udata[i]
		indices[i] = resample(idx, constraint[i])
		values[i] = resample(val, constraint[i])
	end 

	indices, values
end

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces a unique sampling constraint `constraint_idxs[i]` to the i-th index value. 
Also enforces a unique sampling constraint `constraint_vals[i]` to the i-th data value.
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{<:SamplingConstraint}, 
		constraint_vals::Vector{<:SamplingConstraint})

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

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint) -> Tuple{Vector{Float64}, Vector{Float64}}

Resample an uncertain index-value dataset in an element-wise manner. 

Enforces the same sampling constraint `constraint_idxs` on all index values, 
while using the sampling constraint `constraint_vals[i]` to the i-th data value.
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::SamplingConstraint, 
		constraint_vals::Vector{<:SamplingConstraint})

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


"""
	resample(udata::UncertainIndexValueDataset, 
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations an uncertain index-value dataset in an element-wise manner. 
""" 
function resample(udata::UncertainIndexValueDataset, n::Int) 
	[resample(udata) for i = 1:n]
end

"""
	resample(udata::UncertainIndexValueDataset, 
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations an uncertain index-value dataset in an element-wise manner. 

Enforces the provided sampling `constraint` to all uncertain values in the dataset, both 
indices and data values.
""" 
function resample(udata::UncertainIndexValueDataset, constraint::SamplingConstraint, n::Int) 
	[resample(udata, constraint) for i = 1:n]
end


""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::SamplingConstraint, 
		constraint_vals::SamplingConstraint,
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces the same sampling constraint `constraint_idxs` to all index values, and the 
`constraint_vals` sampling constraint to all data values.
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::SamplingConstraint, 
		constraint_vals::SamplingConstraint, 
		n::Int)

	[resample(udata, constraint_idxs, constraint_vals) for i = 1:n]
end

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint,
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces a unique sampling constraint `constraint_idxs[i]` to both the i-th index value 
and to the i-th data value. 
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint::Vector{<:SamplingConstraint}, 
		n::Int)

	[resample(udata, constraint) for i = 1:n]
end

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint,
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces a unique sampling constraint `constraint_idxs[i]` to the i-th index value, 
while using the same sampling constraint `constraint_vals` on all data values.
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{<:SamplingConstraint},
		constraint_vals::SamplingConstraint, 
		n::Int)

	[resample(udata, constraint_idxs, constraint_vals) for i = 1:n]
end

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint,
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces the same sampling constraint `constraint_idxs` on all index values, 
while using the sampling constraint `constraint_vals[i]` to the i-th data value.
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::SamplingConstraint, 
		constraint_vals::Vector{<:SamplingConstraint}, 
		n::Int)

	[resample(udata, constraint_idxs, constraint_vals) for i = 1:n]
end

""" 
	resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{SamplingConstraint}, 
		constraint_vals::SamplingConstraint,
		n::Int) -> Vector{Tuple{Vector{Float64}, Vector{Float64}}}

Resample `n` realizations of an uncertain index-value dataset in an element-wise manner. 

Enforces a unique sampling constraint `constraint_idxs[i]` to the i-th index value. 
Also enforces a unique sampling constraint `constraint_vals[i]` to the i-th data value.
""" 
function resample(udata::UncertainIndexValueDataset, 
		constraint_idxs::Vector{<:SamplingConstraint}, 
		constraint_vals::Vector{<:SamplingConstraint}, 
		n::Int)

	[resample(udata, constraint_idxs, constraint_vals) for i = 1:n]
end

export resample
