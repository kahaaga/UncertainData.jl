import ..UncertainDatasets.UncertainDataset
import ..SamplingConstraints:
	NoConstraint,
	LowerQuantile,
	UpperQuantile,
	QuantileRange

##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it.
##########################################################################

"""
	resample(uv::UncertainDataset, constraint::NoConstraint) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `NoConstraint`,
no trucation is performed and the whole distribution is sampled.
"""
function resample(uv::UncertainDataset, c::NoConstraint)
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, n::NoConstraint,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `NoConstraint`,
no trucation is performed and the whole distribution is sampled.
"""
function resample(uv::UncertainDataset, constraint::NoConstraint, n::Int)
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end

"""
	resample(uv::UncertainDataset,
		constraint::TruncateLowerQuantile) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated below at some quantile.
"""
function resample(uv::UncertainDataset,
		constraint::TruncateLowerQuantile)
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, constraint::TruncateLowerQuantile,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated below at some quantile.
"""
function resample(uv::UncertainDataset, constraint::TruncateLowerQuantile,
	n::Int)
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end

"""
	resample(uv::UncertainDataset,
		constraint::TruncateUpperQuantile) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::UncertainDataset,
		constraint::TruncateUpperQuantile)
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, constraint::TruncateUpperQuantile,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::UncertainDataset, constraint::TruncateUpperQuantile,
		n::Int)
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end


"""
	resample(uv::UncertainDataset,
		constraint::TruncateQuantiles) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated at some quantile range.
"""
function resample(uv::UncertainDataset,
		constraint::TruncateQuantiles)
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainDataset, n::Int,
		constraint::TruncateUpperQuantile) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::UncertainDataset, constraint::TruncateQuantiles, n::Int)
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end
