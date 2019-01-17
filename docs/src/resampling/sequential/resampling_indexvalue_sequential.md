
# Resampling syntax

## Manually resampling 
Because both the indices and the values of `UncertainIndexValueDataset`s are 
datasets themselves, you could manually resample them by accessing the `indices` and 
`values` fields. This gives you full control of the resampling. 

There are some built-in sampling routines you could use instead if you use cases are simple.

## Built-in resampling methods 
Sequential constraints are always interpreted as belonging to the indices of an 
[uncertain index-value dataset](../../uncertain_datasets/uncertain_indexvalue_dataset.md). 
Therefore, when using the built-in function to resample an index-value dataset, you can use 
the same syntax as for any other 
[uncertain value dataset](../../uncertain_datasets/uncertain_value_dataset.md),
but provide an additional sequential constraint after the regular constraints. The 
order of arguments is always 1) regular constraints, then 2) the sequential constraint.

The following examples illustrates the syntax. Assume `udata` is an 
`UncertainIndexValueDataset` instance. Then

- `resample(udata, StrictlyIncreasing())` enforces the sequential constraint only to the 
    indices, applying no constraint(s) on the furnishing distributions of either the 
    indices nor the values of the dataset.
- `resample(udata, TruncateQuantile(0.1, 0.9), StrictlyIncreasing())` applies the truncating 
    constraint both the indices and the values, then enforces the sequential constraint 
    on the indices. 
- `resample(udata, TruncateStd(2), TruncateQuantile(0.1, 0.9), StrictlyIncreasing())` 
    applies separate truncating constraints to the indices and to the values, then 
    enforces the sequential constraint on the indices. 
- `resample(udata, NoConstraint(), TruncateQuantile(0.1, 0.9), StrictlyIncreasing())` does 
    the same as above, but `NoConstraint()` indicates that no constraints are applied to 
    the indices prior to drawing the sequential realization of the indices. 

Of course, like for uncertain value datasets, you can also apply individual constraints to 
each index and each value in the dataset, by providing a vector of constraints instead 
of a single constraint.


Currently implemented sequential constraints: 

- [StrictlyIncreasing](strictly_increasing.md) 
- [StrictlyDecreasing](strictly_decreasing.md)
