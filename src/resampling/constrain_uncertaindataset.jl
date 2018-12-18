

"""
	constrain(d::UncertainDataset, s::SamplingConstraint)

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `d`.
"""
function constrain(d::UncertainDataset, s::SamplingConstraint)
	ConstrainedUncertainDataset([constrain(d[i], s) for i in 1:length(d)])
end

"""
	constrain(d::UncertainDataset, s::SamplingConstraint)

Return a uncertain dataset by applying the constraint `s` to each
uncertain value in `d`.
"""
function constrain(d::UncertainDataset, s::Vector{SamplingConstraint})

	if length(d) != length(s)
		error("Number of sampling constraints must match length of dataset.")
	end

	ConstrainedUncertainDataset([constrain(d[i], s[i]) for i in 1:length(d)])
end
