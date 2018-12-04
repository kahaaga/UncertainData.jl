include("../distributions/assign_dist.jl")
include("../uncertain_values/uncertain_values.jl")
include("../uncertain_datasets/uncertain_datasets.jl")

"""
	realise(uv::AbstractUncertainValue)

Draw a realisation of an uncertain value.
"""
function realise(uv::AbstractUncertainValue)
	rand(uv.distribution)
end

"""
	realise(uv::AbstractUncertainValue, n::Int)

Draw `n` realisations of an uncertain value.
"""
function realise(uv::AbstractUncertainValue, n::Int)
	SVector{n}(rand(uv.distribution, n))
end

"""
	realise(ev::UncertainEmpiricalScalarValue) -> Float64

Draw a realisation of an `UncertainEmpiricalScalarValue`.
"""
realise(ev::UncertainEmpiricalScalarValue) = rand(ev.distribution)

"""
	realise(ev::UncertainEmpiricalScalarValue) -> Vector{Float64

Draw `n` realisations of an `UncertainEmpiricalScalarValue`.
"""
realise(ev::UncertainEmpiricalScalarValue, n::Int) =
	SVector{n}(rand(ev.distribution, n))


"""
	realise(uv::UncertainDataset) -> SVector{Float64}

Draw a realisation of an `UncertainDataset`.
"""
function realise(uv::UncertainDataset)
	L = length(uv)
	SVector{L}([rand(uv.values[i].distribution) for i in 1:L])
end

"""
	realise(uv::UncertainDataset, n::Int)

Draw `n` realisations of an `UncertainDataset`.
"""
function realise(uv::UncertainDataset, n::Int)
	L = length(uv)
	[SVector{L}([rand(uv.values[i].distribution) for i in 1:L]) for k = 1:n]
end


"""
	realise(uvd::UncertainValueDataset)

Draw a realisation of an `UncertainValueDataset`.
"""
function realise(uvd::UncertainValueDataset)
	L = length(uvd)
	SVector{L}([rand(uvd.values[i].distribution) for i in 1:L])
end

"""
	realise(uvd::UncertainValueDataset)

Draw `n` realisations of an `UncertainValueDataset`.
"""
function realise(uvd::UncertainValueDataset, n::Int)
	L = length(uvd)
	[SVector{L}([rand(uvd.values[i].distribution) for i in 1:L]) for k in 1:n]
end

"""
	realise(uivd::UncertainIndexValueDataset)

Draw a realisation of an `UncertainValueDataset`.
"""
function realise(uivd::UncertainIndexValueDataset)
	L = length(uivd)
	SVector{L}([rand(uivd.values[i].distribution) for i in 1:L])
end

"""
	realise(uivd::UncertainIndexValueDataset)

Draw `n` realisations of an `UncertainIndexValueDataset`.
"""
function realise(uivd::UncertainIndexValueDataset, n::Int)
	L = length(uivd)
	[SVector{L}([rand(uivd.values[i].distribution) for i in 1:L]) for k in 1:n]
end


export realise
