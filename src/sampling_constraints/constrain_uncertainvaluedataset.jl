import ..UncertainDatasets: 
	AbstractUncertainValueDataset,
	UncertainValueDataset

include("constrain_uncertainvalue.jl")

"""
	constrain(d::UncertainDataset, s::SamplingConstraint)

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `d`.
"""
function constrain(d::UncertainValueDataset, s::SamplingConstraint)

end

"""
	constrain(d::UncertainValueDataset, s::SamplingConstraint)

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `d`.
"""
function constrain(d::UncertainValueDataset, s::Vector{SamplingConstraint})

	if length(d) != length(s)
		error("Number of sampling constraints must match length of dataset.")
	end

	[constrain(d[i], s[i]) for i in 1:length(d)]
end


function verify_constraints(udata::AbstractUncertainValueDataset, 
	constraint::SamplingConstraint)

	inds_empty_support = Int[]

	for i = 1:length(udata)
		uval = udata[i]
		try 
			constrained_uval = constrain(uval, constraint)
		catch err 
			push!(inds_empty_support, i)
		end
	end
	return inds_empty_support 
end

export constrain, verify_constraints