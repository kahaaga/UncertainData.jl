import ..UncertainDatasets: 
	AbstractUncertainValueDataset
import ..SamplingConstraints:
	NoConstraint,
	TruncateLowerQuantile,
	TruncateUpperQuantile,
	TruncateQuantiles

##########################################################################
# Draw realisations of the uncertain dataset according to the distributions
# of the uncertain values comprising it.
##########################################################################


"""
	resample(uv::DT, constraint::NoConstraint) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `NoConstraint`,
no trucation is performed and the whole distribution is sampled.
"""
function resample(uv::DT, 
		constraint::NoConstraint) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::DT, n::NoConstraint,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `NoConstraint`,
no trucation is performed and the whole distribution is sampled.
"""
function resample(uv::DT, constraint::NoConstraint, 
		n::Int) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end

"""
	resample(uv::DT,
		constraint::TruncateLowerQuantile) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated below at some quantile.
"""
function resample(uv::DT,
		constraint::TruncateLowerQuantile) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::DT, constraint::TruncateLowerQuantile,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated below at some quantile.
"""
function resample(uv::DT, constraint::TruncateLowerQuantile,
		n::Int) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end

"""
	resample(uv::DT,
		constraint::TruncateUpperQuantile) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::DT,
		constraint::TruncateUpperQuantile) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::DT, constraint::TruncateUpperQuantile,
		n::Int) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::DT, constraint::TruncateUpperQuantile,
		n::Int) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end


"""
	resample(uv::DT,
		constraint::TruncateQuantiles) -> Vector{Float64}

Draw a realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
the supports of the distributions are truncated at some quantile range.
"""
function resample(uv::DT,
		constraint::TruncateQuantiles) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[resample(uv.values[i], constraint) for i in 1:L]
end

"""
	resample(uv::DT, n::Int,
		constraint::TruncateUpperQuantile) -> Vector{Vector{Float64}}

Draw `n` realisation of an `UncertainDataset` where each uncertain value
is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
the supports of the distributions are truncated above at some quantile.
"""
function resample(uv::DT, constraint::TruncateQuantiles, 
		n::Int) where {DT <: AbstractUncertainValueDataset}
	L = length(uv)
	[[resample(uv.values[i], constraint) for i in 1:L] for k = 1:n]
end
