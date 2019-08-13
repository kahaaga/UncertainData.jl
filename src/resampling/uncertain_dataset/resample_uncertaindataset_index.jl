import ..UncertainDatasets.UncertainIndexDataset

"""
	resample(uvd::UncertainIndexDataset)

Draw a realisation of an `UncertainIndexDataset` according to the distributions
of the `UncertainValue`s comprising it.
"""
function resample(uvd::UncertainIndexDataset)
	L = length(uvd)
	[resample(uvd.indices[i]) for i in 1:L]
end

"""
	resample(uvd::UncertainIndexDataset)

Draw `n` realisations of an `UncertainIndexDataset` according to the
distributions of the `UncertainValue`s comprising it.
"""
function resample(uvd::UncertainIndexDataset, n::Int)
	L = length(uvd)
	[[resample(uvd.indices[i]) for i in 1:L] for k in 1:n]
end



##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it, according to sampling constraints
##########################################################################


"""
	resample(uv::UncertainIndexDataset, constraint::NoConstraint) -> Vector{Float64}

Draw a realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `NoConstraint`,
no trucation is performed and the whole distribution is sampled.
"""
function resample(uv::UncertainIndexDataset, constraint::NoConstraint)
	L = length(uv)
	[resample(uv.indices[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainIndexDataset, n::NoConstraint,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `NoConstraint`,
no trucation is performed and the whole distribution is sampled.
"""
function resample(uv::UncertainIndexDataset, constraint::NoConstraint, n::Int)
	L = length(uv)
	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
end

"""
	resample(uv::UncertainIndexDataset,
		constraint::TruncateLowerQuantile) -> Vector{Float64}

Draw a realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated below at some quantile.
"""
function resample(uv::UncertainIndexDataset,
		constraint::TruncateLowerQuantile)
	L = length(uv)
	[resample(uv.indices[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainIndexDataset, constraint::TruncateLowerQuantile,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated below at some quantile.
"""
function resample(uv::UncertainIndexDataset, constraint::TruncateLowerQuantile,
		n::Int)
	L = length(uv)
	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
end

"""
	resample(uv::UncertainIndexDataset,
		constraint::TruncateUpperQuantile) -> Vector{Float64}

Draw a realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::UncertainIndexDataset,
		constraint::TruncateUpperQuantile)
	L = length(uv)
	[resample(uv.indices[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainIndexDataset, constraint::TruncateUpperQuantile,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::UncertainIndexDataset, constraint::TruncateUpperQuantile,
		n::Int)
	L = length(uv)
	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
end


"""
	resample(uv::UncertainIndexDataset,
		constraint::TruncateQuantiles) -> Vector{Float64}

Draw a realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated at some quantile range.
"""
function resample(uv::UncertainIndexDataset,
		constraint::TruncateQuantiles)
	L = length(uv)
	[resample(uv.indices[i], constraint) for i in 1:L]
end

"""
	resample(uv::UncertainIndexDataset, n::Int,
		constraint::TruncateUpperQuantile) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::UncertainIndexDataset, constraint::TruncateQuantiles, n::Int)
	L = length(uv)
	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
end
