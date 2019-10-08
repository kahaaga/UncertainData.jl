# Uncertain index datasets

## Documentation

```@docs
UncertainIndexDataset
```

## Description

`UncertainIndexDataset`s is an uncertain dataset type that represents the indices 
corresponding to an [UncertainValueDataset](uncertain_value_dataset.md).

It is meant to be used for the `indices` field in
[UncertainIndexValueDataset](uncertain_indexvalue_dataset.md)s instances.

## Defining uncertain index datasets

### Example 1: increasing index uncertainty through time

#### Defining the indices

Say we had a dataset of 20 values for which the uncertainties are normally distributed 
with increasing standard deviation through time.

```julia
time_inds = 1:13
uvals = [UncertainValue(Normal, ind, rand(Uniform()) + (ind / 6)) for ind in time_inds]
inds = UncertainIndexDataset(uvals)
```

That's it. We can also plot the 33rd to 67th percentile range for the indices.

```plot
plot(inds, [0.33, 0.67])
```

![](uncertain_indexvalue_dataset_indices.svg)
