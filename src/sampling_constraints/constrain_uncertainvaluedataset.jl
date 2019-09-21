import ..UncertainDatasets: 
	AbstractUncertainValueDataset,
	UncertainValueDataset

import ..UncertainDatasets:ConstrainedUncertainValueDataset

"""
	constrain(udata::Vector{<:AbstractUncertainValue}, 
		s::SamplingConstraint) -> ConstrainedUncertainValueDataset

Return a vector of uncertain value by applying the constraint `s` to each
uncertain value in `udata`.
"""
function constrain(udata::Vector{<:AbstractUncertainValue}, constraint::SamplingConstraint)
	[constrain(uval, constraint) for uval in udata]
end

"""
	constrain(udata::Vector{<:AbstractUncertainValue}, 
		constraints::Vector{T}) where {T<:SamplingConstraint} -> Vector{<:AbstractUncertainValue}

Return a vector of uncertain values by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::Vector{<:AbstractUncertainValue}, 
		constraints::Vector{T}) where {T <: SamplingConstraint}
	
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	return [constrain(udata[i], constraints[i]) for i in 1:length(udata)]
end

"""
	constrain(udata::AbstractUncertainValueDataset, 
		s::SamplingConstraint) -> ConstrainedUncertainValueDataset

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `udata`.
"""
function constrain(udata::DT, constraint::SamplingConstraint) where {
		DT <: AbstractUncertainValueDataset}
	
	ConstrainedUncertainValueDataset([constrain(uval, constraint) for uval in udata])
end

"""
	constrain(udata::AbstractUncertainValueDataset, 
		constraints::Vector{T}) where {T<:SamplingConstraint} -> ConstrainedUncertainValueDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::DT, constraints::Vector{T}) where {
		T<:SamplingConstraint, 
		DT <: AbstractUncertainValueDataset}
	
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	n_vals = length(udata)

	ConstrainedUncertainValueDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end


# """
# 	constrain(udata::ConstrainedUncertainValueDataset, 
# 		constraint::SamplingConstraint) -> ConstrainedUncertainValueDataset

# Return a uncertain dataset by applying the `constraint` to each
# uncertain value in `udata`.
# """
# constrain(udata::ConstrainedUncertainValueDataset, constraint::SamplingConstraint) = 
# 	ConstrainedUncertainValueDataset([constrain(uval, constraint) for uval in udata])


# """
# 	constrain(udata::ConstrainedUncertainValueDataset, 
# 		constraints::Vector{T}) where {T<:SamplingConstraint} ->  ConstrainedUncertainValueDataset

# Return a uncertain dataset by applying a different sampling constraint to each uncertain 
# value in `udata`.
# """
# function constrain(udata::ConstrainedUncertainValueDataset, 
# 		constraints::Vector{T}) where {T<:SamplingConstraint}
# 	if length(udata) != length(constraints)
# 		error("Number of sampling constraints must match length of dataset.")
# 	end

# 	n_vals = length(udata)

# 	ConstrainedUncertainValueDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
# end




export constrain, verify_constraints