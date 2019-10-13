CONSTRAINT_TYPES = Union{T, Vector{T}} where T <: SamplingConstraint

"""
    ConstrainedValueResampling{N_DATASETS}

Indicates that resampling should be done with constraints on the furnishing distributions/populations.

## Fields

- `constraints`. The constraints for the datasets. The constraints are represented as a tuple of length 
    `N_DATASETS`, where the `i`-th tuple element contains the constraints for that dataset.
    Constraints for each dataset must be supplied as either a single sampling constraint, 
    or as a vector of sampling constraints with length matching the length of the dataset
    (`Union{SamplingConstraint, Vector{<:SamplingConstraint}}}`). For example, if the `i`-th dataset
    contains 352 observations, then `constraints[i]` must be either a single 
    sampling constraint (e.g. `TruncateStd(1.1)`) or a vector of 352 different sampling constraints 
    (e.g. `[TruncateStd(1.0 + rand()) for i = 1:352]`).
- `n::Int`. The number of draws. 
"""
struct ConstrainedValueResampling{N} <: AbstractUncertainDataResampling 
    constraints::Tuple{Vararg{CONSTRAINT_TYPES, N}}
    n::Int
end

# It's tedious for the user to always provide a tuple, so unpack a variable 
# number of constraints into a tuple, then call the original constructor.
function ConstrainedValueResampling(constraints::CONSTRAINT_TYPES...) where N
    ConstrainedValueResampling((constraints...,), 1)
end

function ConstrainedValueResampling(n::Int, constraints::CONSTRAINT_TYPES...) where N
    ConstrainedValueResampling((constraints...,), n)
end

Broadcast.broadcastable(c::ConstrainedValueResampling) = Ref(c)

Base.length(c::ConstrainedValueResampling) = length(c.constraints)
Base.firstindex(c::ConstrainedValueResampling) = 1
Base.lastindex(c::ConstrainedValueResampling) = length(c)
Base.getindex(c::ConstrainedValueResampling, i) = c.constraints[i]
Base.iterate(c::ConstrainedValueResampling, state = 1) = iterate(c.constraints, state)
Base.eachindex(c::ConstrainedValueResampling) = Base.OneTo(length(c.constraints))


function Base.show(io::IO, constraints::ConstrainedValueResampling{N_DATASETS}) where {N_DATASETS}
    s = "$(typeof(constraints)) for $N_DATASETS set(s) of value constraints, where n=$(constraints.n)"
    println(io, s)
end

export ConstrainedValueResampling