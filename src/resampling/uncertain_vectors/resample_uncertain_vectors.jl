
# Vectors of sampling constraints mapped to unique sampling constraints
function resample(uv::DT, constraint::Vector{<:SamplingConstraint}) where {
        DT <: Vector{<:AbstractUncertainValue}}
    [resample(uv[i], constraint[i]) for i in 1:length(uv)]
end