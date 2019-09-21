import ..UncertainDatasets.UncertainIndexDataset
import ..UncertainDatasets.AbstractUncertainIndexDataset

##############################
# Resample the entire dataset
##############################

"""
	resample(uvd::AbstractUncertainIndexDataset)

Draw a realisation of an uncertain index dataset according to the distributions
of the uncertain values comprising it.
"""
function resample(uvd::DT) where {DT <: AbstractUncertainIndexDataset}
	L = length(uvd)
	[resample(uvd.indices[i]) for i in 1:L]
end

""" 
	resample(uv::AbstractUncertainIndexDataset, constraint::Vector{<:SamplingConstraint})

Draw a realisation of an uncertain index dataset according to the uncertain values 
comprising it, while constraining the distributions furnishing the values in the dataset 
according the provided sampling constraints.
"""
function resample(uv::DT, constraint::Vector{<:SamplingConstraint}) where {
		DT <: AbstractUncertainIndexDataset}
    [resample(uv.indices[i], constraint[i]) for i in 1:length(uv)]
end

function resample(uv::DT, constraint::SamplingConstraint) where {
		DT <: AbstractUncertainIndexDataset}
	[resample(uv.indices[i], constraint) for i in 1:length(uv)]
end

function resample(uv::DT, constraint::SamplingConstraint, n::Int) where {
		DT <: AbstractUncertainIndexDataset}
	[[resample(uv.indices[i], constraint) for i in 1:length(uv)] for k = 1:n]
end

function resample(uv::DT, constraint::Vector{<:SamplingConstraint}, n::Int) where {
		DT <: AbstractUncertainIndexDataset}
	[[resample(uv.indices[i], constraint[i]) for i in 1:length(uv)] for k = 1:n]
end

##############################
# Resample the entire dataset
##############################

"""
	resample_elwise(uvd::UncertainIndexDataset, n::Int)

Resample each element in `uvals` `n` times. The i-th entry in the returned 
vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`.
"""
function resample_elwise(uvd::DT, n::Int) where {DT <: AbstractUncertainIndexDataset}
    [resample(uvd[i], n) for i = 1:length(uvd)]
end

"""
	resample(uvd::UncertainIndexDataset, n::Int)

Draw `n` realisations of an `UncertainIndexDataset` according to the
distributions of the `UncertainValue`s comprising it.
"""
function resample(uvd::DT, n::Int) where {DT <: AbstractUncertainIndexDataset}
	L = length(uvd)
	[[resample(uvd.indices[i]) for i in 1:L] for k in 1:n]
end

# ##########################################################################
# # Draw realisations of the uncertain dataset according to the distributions
# # of the uncertain values comprising it, according to sampling constraints
# ##########################################################################

# """
# 	resample(uv::UncertainIndexDataset, constraint::NoConstraint) -> Vector{Float64}

# Draw a realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `NoConstraint`,
# no trucation is performed and the whole distribution is sampled.
# """
# function resample(uv::DT, constraint::NoConstraint) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[resample(uv.indices[i], constraint) for i in 1:L]
# end

# """
# 	resample(uv::UncertainIndexDataset, n::NoConstraint,
# 		n::Int) -> Vector{Vector{Float64}}

# Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `NoConstraint`,
# no trucation is performed and the whole distribution is sampled.
# """
# function resample(uv::DT, constraint::NoConstraint, n::Int) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
# end

# """
# 	resample(uv::UncertainIndexDataset,
# 		constraint::TruncateLowerQuantile) -> Vector{Float64}

# Draw a realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
# the supports of the distributions are truncated below at some quantile.
# """
# function resample(uv::DT, constraint::TruncateLowerQuantile) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[resample(uv.indices[i], constraint) for i in 1:L]
# end

# """
# 	resample(uv::UncertainIndexDataset, constraint::TruncateLowerQuantile,
# 		n::Int) -> Vector{Vector{Float64}}

# Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
# the supports of the distributions are truncated below at some quantile.
# """
# function resample(uv::DT, constraint::TruncateLowerQuantile, n::Int) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
# end

# """
# 	resample(uv::UncertainIndexDataset,
# 		constraint::TruncateUpperQuantile) -> Vector{Float64}

# Draw a realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
# the supports of the distributions are truncated above at some quantile.
# """
# function resample(uv::DT, constraint::TruncateUpperQuantile) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[resample(uv.indices[i], constraint) for i in 1:L]
# end

# """
# 	resample(uv::UncertainIndexDataset, constraint::TruncateUpperQuantile,
# 		n::Int) -> Vector{Vector{Float64}}

# Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
# the supports of the distributions are truncated above at some quantile.
# """
# function resample(uv::DT, constraint::TruncateUpperQuantile, n::Int) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
# end


# """
# 	resample(uv::UncertainIndexDataset,
# 		constraint::TruncateQuantiles) -> Vector{Float64}

# Draw a realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `TruncateLowerQuantile`,
# the supports of the distributions are truncated at some quantile range.
# """
# function resample(uv::UncertainIndexDataset, constraint::TruncateQuantiles) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[resample(uv.indices[i], constraint) for i in 1:L]
# end

# """
# 	resample(uv::UncertainIndexDataset, n::Int,
# 		constraint::TruncateUpperQuantile) -> Vector{Vector{Float64}}

# Draw `n` realisation of an `UncertainIndexDataset` where each uncertain value
# is truncated according to `constraint`. In the case of `TruncateUpperQuantile`,
# the supports of the distributions are truncated above at some quantile.
# """
# function resample(uv::DT, constraint::TruncateQuantiles, n::Int) where {
# 		DT <: AbstractUncertainIndexDataset}
# 	L = length(uv)
# 	[[resample(uv.indices[i], constraint) for i in 1:L] for k = 1:n]
# end

# """
#     resample_elwise(uvd::UncertainIndexDataset, constraint::SamplingConstraint, n::Int)

# Resample each element in `uvals` `n` times. The i-th entry in the returned 
# vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`, drawn 
# after first truncating the support of `uvals[i]` according to the provided `constraint`.
# """
# function resample_elwise(uvd::DT, constraint::SamplingConstraint, n::Int) where {
# 		DT <: AbstractUncertainIndexDataset}
#     [resample(uvd[i], constraint, n) for i = 1:length(uvd)]
# end