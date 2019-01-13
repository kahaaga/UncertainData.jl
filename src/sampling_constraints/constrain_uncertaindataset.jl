import ..UncertainDatasets:ConstrainedUncertainDataset

"""
	constrain(udata::UncertainDataset, 
		s::SamplingConstraint) -> ConstrainedUncertainDataset

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `udata`.
"""
constrain(udata::UncertainDataset, constraint::SamplingConstraint) = 
	ConstrainedUncertainDataset([constrain(uval, constraint) for uval in udata])


"""
	constrain(udata::UncertainDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint} -> ConstrainedUncertainDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::UncertainDataset, constraints::Vector{T}) where {T<:SamplingConstraint}
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	n_vals = length(udata)

	ConstrainedUncertainDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end



"""
	constrain(udata::ConstrainedUncertainDataset, 
		constraint::SamplingConstraint) -> ConstrainedUncertainDataset

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `udata`.
"""
constrain(udata::ConstrainedUncertainDataset, constraint::SamplingConstraint) = 
	ConstrainedUncertainDataset([constrain(uval, constraint) for uval in udata])


"""
	constrain(udata::ConstrainedUncertainDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint} -> ConstrainedUncertainDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::ConstrainedUncertainDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint}
	
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	n_vals = length(udata)

	ConstrainedUncertainDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end

export constrain