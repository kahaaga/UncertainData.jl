import ..SamplingConstraints: SamplingConstraint

""" 
    ConstrainedResampling(constraint::NTuple{N, Union{SamplingConstraint, Vector{<:SamplingConstraint}}})

Indicates that resampling should be performed with constraints on the uncertain values.
"""
struct ConstrainedResampling{N} <: AbstractUncertainDataResampling where N
    constraints::NTuple{N, Union{SamplingConstraint, Vector{<:SamplingConstraint}}}
end

ConstrainedResampling(constraints::Union{SamplingConstraint, Vector{<:SamplingConstraint}}...) = 
    ConstrainedResampling(constraints)

ConstrainedResampling(constraints::Vector{Union{SamplingConstraint, Vector{<:SamplingConstraint}}}) = 
    ConstrainedResampling((constraints...))


Base.length(resampling::ConstrainedResampling) = length(resampling.constraints)
Base.getindex(resampling::ConstrainedResampling, i) = resampling.constraints[i]
Base.firstindex(resampling::ConstrainedResampling) = 1
Base.lastindex(resampling::ConstrainedResampling) = length(resampling)


function summarise(resampling::ConstrainedResampling)
    _type = typeof(resampling)
    constraint_types = [typeof(c) for c in resampling.constraints]
    
    strs = ["$constraint" for  constraint in constraint_types]
    return "$_type" * "(" * join(strs, ", ") * ")"
end

Base.show(io::IO, resampling::ConstrainedResampling) = print(io, summarise(resampling))


export ConstrainedResampling