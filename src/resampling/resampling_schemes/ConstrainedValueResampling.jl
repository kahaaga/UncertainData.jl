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

## Example 

Assume we have three collections of uncertain values of, each of length `L = 50`. These should be 
resampled `250` times. Before resampling, however, the distributions/populations furnishing 
the uncertain values should be truncated: 

- For the first collection, truncate each value at `1.5` times its standard deviation 
    around its mean. This could simulate measurement errors from an instrument 
    that yields stable measurements whose errors are normally distributed, but for 
    which we are not interested in outliers or values beyond `1.5` standard devations 
    for our analyses.
- For the second collection, truncate each value at the `80`th percentile range.
    This could simulate measurement errors from an instrument that yields stable measurements,
    whose errors are not normally distributed, so that confidence intervals are better
    to use than standard deviations. In this case, we're not interested in outliers,
    and therefore exclude values smaller than the `10`th percentile and larger than the 
    `90`th percentile of the data.
- For the third collection, truncate the `i`-th value at an fraction of its standard
    deviation around the mean slightly larger than at the `i-1`-th value, so that 
    the standard deviation ranges from `0.5` to `0.5 + L/100`. This could simulate,
    for example, an instrument whose measurement error increases over time.

```julia
L = 50
constraints_d1 = TruncateStd(1.5)
constraints_d2 = TruncateQuantiles(0.1, 0.9)
constraints_d3 = [TruncateStd(0.5 + i/100) for i = 1:L]
```
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