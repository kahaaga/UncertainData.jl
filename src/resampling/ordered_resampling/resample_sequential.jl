import ..SamplingConstraints: 
    SequentialSamplingConstraint, 
    OrderedSamplingAlgorithm

const AUD = AbstractUncertainDataset

const SC = Union{SamplingConstraint, Vector{S}} where S <: SamplingConstraint
const SEQ = SequentialSamplingConstraint{O} where O <: OrderedSamplingAlgorithm

const XD = Union{AbstractUncertainDataset, Vector{<:AbstractUncertainValue}}

"""
    resample(x, ssc::SequentialSamplingConstraint)
    resample(x, ssc::SequentialSamplingConstraint, c::Union{SamplingConstraint, Vector{SamplingConstraint}})

Sample `x` element-wise such that the samples obey the sequential constraints given by `ssc`.
Alteratively, apply constrain(s) `c` to `x` *before* sequential sampling is performed. 

A check is performed before sampling to ensure that such a sequence exists.
Before the check is performed, the distributions in `x` are truncated element-wise
to the quantiles provided by `c` to ensure they have finite supports.

If `x` is an uncertain index-value dataset, then the sequential constraint is only applied to 
the indices.

    resample!(s, x, ssc::SequentialSamplingConstraint, lqs, uqs)

The same as above, but store the sampled values a pre-allocated vector `s`, where 
`length(x) == length(s)`. This avoids excessive memory allocations during repeated
resampling. This requires pre-computing the element-wise lower and upper quantiles 
`lqs` and `uqs` for the initial truncation step.

This method *does not* check for the existence of a strictly increasing sequence in `x`.
To check that, use [`sequence_exists`](@ref).

See also: [`sequence_exists`](@ref), [`StrictlyIncreasing`](@ref), 
[`StrictlyDecreasing`](@ref), [`StartToEnd`](@ref).

## Examples

```julia
N = 100
t = [UncertainValue(Normal, i, 2) for i in 1:N];
resample(t, StrictlyIncreasing(StartToEnd()))
```

```julia
N = 100
t = [UncertainValue(Normal, i, 2) for i in 1:N];

# Verify that an increasing sequence through `t` exists
c = StrictlyIncreasing(StartToEnd())
exists, lqs, uqs = sequence_exists(t, c)

# Pre-allocate sample vector
s = zeros(Float64, N)

if exists
    for i = 1:100
        resample!(s, t, c)
        # Do something with s
        # ...
    end
end
```
"""
function resample(x::XD, ssc::SEQ)
    exists, lqs, uqs = sequence_exists(x, ssc)
    exists || error("Sequence does not exist")
    _draw(x, ssc, lqs, uqs)
end

function resample!(s, x::XD, ssc::SEQ, lqs, uqs)
    _draw!(s, x, ssc, lqs, uqs)
end

resample(udata::XD, ssc::SEQ, c::Union{SC, AbstractVector{<:SC}}) = 
    resample(constrain(udata, c), ssc)


resample(udata::UncertainIndexValueDataset, ssc::SEQ) = 
    resample(udata.indices, ssc), resample(udata.values)

resample(udata::UncertainIndexValueDataset, ssc::SEQ, c::SC) =
    resample(constrain(udata.indices, c), ssc), resample(constrain(udata.values, c))

resample(udata::UncertainIndexValueDataset, ssc::SEQ, ic::SC, vc::SC) =
    resample(constrain(udata.indices, ic), ssc), resample(constrain(udata.values, vc))
