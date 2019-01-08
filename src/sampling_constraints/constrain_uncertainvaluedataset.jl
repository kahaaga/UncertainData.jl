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

export constrain