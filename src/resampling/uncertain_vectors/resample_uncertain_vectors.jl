
resample(uv::AbstractVector{<:Number}) = uv

# No constraints
function resample(uv::DT) where {DT <: AbstractVector{<:AbstractUncertainValue}}
    resample.(uv)
end

function resample(uv::DT, n::Int) where {DT <: AbstractVector{<:AbstractUncertainValue}}
    [resample.(uv) for i = 1:n]
end

# Vectors of sampling constraints mapped to unique sampling constraints
function resample(uv::DT, constraint::Vector{<:SamplingConstraint}) where {
        DT <: AbstractVector{<:AbstractUncertainValue}}
    [resample(uv[i], constraint[i]) for i in 1:length(uv)]
end

function resample(uv::DT, constraint::Vector{<:SamplingConstraint}, n::Int) where {
        DT <: AbstractVector{<:AbstractUncertainValue}}
    [[resample(uv[i], constraint[i]) for i in 1:length(uv)] for k = 1:n]
end

# Vectors of sampling constraints mapped to unique sampling constraints
function resample(uv::DT, constraint::SamplingConstraint) where {
        DT <: AbstractVector{<:AbstractUncertainValue}}
    [resample(uv[i], constraint) for i in 1:length(uv)]
end

function resample(uv::DT, constraint::SamplingConstraint, n::Int) where {
        DT <: AbstractVector{<:AbstractUncertainValue}}
    [[resample(uv[i], constraint) for i in 1:length(uv)] for k = 1:n]
end

function resample(uv::DT, constraint::NoConstraint) where {
    DT <: AbstractVector{<:AbstractUncertainValue}}

    return uv
end

function resample(uv::DT, constraint::NoConstraint, n::Int) where {
    DT <: AbstractVector{<:AbstractUncertainValue}}
    
    return [uv for i = 1:n]
end