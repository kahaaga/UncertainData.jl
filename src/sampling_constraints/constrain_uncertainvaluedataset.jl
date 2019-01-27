import ..UncertainDatasets: 
	AbstractUncertainValueDataset,
	UncertainValueDataset

import ..UncertainDatasets:ConstrainedUncertainValueDataset

"""
	constrain(udata::UncertainValueDataset, 
		s::SamplingConstraint) -> ConstrainedUncertainValueDataset

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `udata`.
"""
constrain(udata::UncertainValueDataset, constraint::SamplingConstraint) = 
	ConstrainedUncertainValueDataset([constrain(uval, constraint) for uval in udata])


"""
	constrain(udata::UncertainValueDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint} -> ConstrainedUncertainValueDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::UncertainValueDataset, constraints::Vector{T}) where {T<:SamplingConstraint}
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	n_vals = length(udata)

	ConstrainedUncertainValueDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end


"""
	constrain(udata::ConstrainedUncertainValueDataset, 
		constraint::SamplingConstraint) -> ConstrainedUncertainValueDataset

Return a uncertain dataset by applying the `constraint` to each
uncertain value in `udata`.
"""
constrain(udata::ConstrainedUncertainValueDataset, constraint::SamplingConstraint) = 
	ConstrainedUncertainValueDataset([constrain(uval, constraint) for uval in udata])


"""
	constrain(udata::ConstrainedUncertainValueDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint} ->  ConstrainedUncertainValueDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::ConstrainedUncertainValueDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint}
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	n_vals = length(udata)

	ConstrainedUncertainValueDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end




export constrain, verify_constraints