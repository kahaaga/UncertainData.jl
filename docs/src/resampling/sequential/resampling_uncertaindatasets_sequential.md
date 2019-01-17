In addition to the 
[generic sampling constraints](../../sampling_constraints/available_constraints.md), 
you may impose sequential sampling constraints when resampling an uncertain dataset. 

# Is a particular constraint applicable? 

Not all [sequential sampling constraints](../../sampling_constraints/sequential_constraints.md) 
may be applicable to your dataset. Use 
[these functions](../../sampling_constraints/ordered_sequence_exists.md) to check whether a 
particular constraint is possible to apply to your dataset. 

# Syntax 


## Sequential constraint only 
A dataset may be sampling imposing a sequential sampling constraint, but leaving the 
furnishing distributions untouched otherwise.

```@docs
resample(udata::AbstractUncertainValueDataset, 
    sequential_constraint::SequentialSamplingConstraint;
    quantiles = [0.0001, 0.9999])
```

## Regular constraint(s) + sequential constraint

Another option is to first impose constraints on the furnishing distributions, then 
applying the sequential sampling constraint.

```@docs 
resample(udata::AbstractUncertainValueDataset, 
    constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
    sequential_constraint::SequentialSamplingConstraint;
    quantiles = [0.0001, 0.9999])
```
 
# List of sequential resampling schemes

- [StrictlyIncreasing](strictly_increasing.md) sequences.
- [StrictlyDecreasing](strictly_decreasing.md) sequences. 

