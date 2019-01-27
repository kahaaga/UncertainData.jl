import ..UncertainDatasets: 
	AbstractUncertainIndexDataset,
	UncertainIndexDataset

import ..UncertainDatasets:ConstrainedUncertainIndexDataset

"""
    constrain(udata::UncertainIndexDataset, 
        s::SamplingConstraint) -> ConstrainedUncertainIndexDataset

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `udata`.
"""
constrain(udata::UncertainIndexDataset, constraint::SamplingConstraint) = 
	ConstrainedUncertainIndexDataset([constrain(uval, constraint) for uval in udata])


"""
    constrain(udata::UncertainIndexDataset, 
        constraints::Vector{T}) where {T<:SamplingConstraint} -> ConstrainedUncertainIndexDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::UncertainIndexDataset, constraints::Vector{T}) where {T<:SamplingConstraint}
	if length(udata) != length(constraints)
		error("Number of sampling constraints must match length of dataset.")
	end

	n_vals = length(udata)

	ConstrainedUncertainIndexDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end


"""
    constrain(udata::UncertainIndexDataset, 
        constraint::SamplingConstraint) ->  ConstrainedUncertainIndexDataset


Return a uncertain dataset by applying the `constraint` to each
uncertain value in `udata`.
"""
constrain(udata::ConstrainedUncertainIndexDataset, constraint::SamplingConstraint) = 
	ConstrainedUncertainIndexDataset([constrain(uval, constraint) for uval in udata])


"""
    constrain(udata::UncertainIndexDataset, 
        constraints::Vector{T}) where {T<:SamplingConstraint} -> ConstrainedUncertainIndexDataset

Return a uncertain dataset by applying a different sampling constraint to each uncertain 
value in `udata`.
"""
function constrain(udata::ConstrainedUncertainIndexDataset, 
        constraints::Vector{T}) where {T<:SamplingConstraint}
        
    if length(udata) != length(constraints)
        error("Number of sampling constraints must match length of dataset.")
    end

    n_vals = length(udata)

    ConstrainedUncertainIndexDataset([constrain(udata[i], constraints[i]) for i in 1:n_vals])
end



export constrain, verify_constraints