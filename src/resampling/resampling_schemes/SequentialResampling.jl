import ..SamplingConstraints: 
    SequentialSamplingConstraint

"""
    SequentialResampling{SequentialSamplingConstraint}

Indicates that resampling should be done by resampling sequentially.

## Fields 

- `sequential_constraint::SequentialSamplingConstraint`. The sequential sampling constraint,
    for example `StrictlyIncreasing()`.

## Examples 

```julia
SequentialResampling(StrictlyIncreasing())
```
"""
struct SequentialResampling{S} <: AbstractUncertainDataResampling where {
        S <: SequentialSamplingConstraint}
    sequential_constraint::S
end

function Base.show(io::IO, resampling::SequentialResampling{S}) where {S}
    print(io, "SequentialResampling{$S}")
end

export SequentialResampling