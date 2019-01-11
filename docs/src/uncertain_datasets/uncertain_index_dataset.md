`UncertainIndexDataset`s is an uncertain dataset type that represents the indices 
corresponding to an [UncertainValueDataset](uncertain_value_dataset.md).

It is meant to be used for the `indices` field in
[UncertainIndexValueDataset](uncertain_indexvalue_dataset.md)s instances.

## Documentation

```@docs 
UncertainIndexDataset
```

## Examples 

### Example 1: increasing index uncertainty through time

#### Defining the indices
Say we had a dataset of 20 values for which the uncertainties are normally distributed 
with increasing standard deviation through time.

```julia 
time_inds = 1:13
uvals = [UncertainValue(Normal, ind, rand(Uniform()) + (ind / 6)) for ind in time_inds]
inds = UncertainIndexDataset(uvals)
```

Let's plot the 33rd to 67th percentile range for the indices: 

```plot
plot(inds, [0.33, 0.67])
```

![](uncertain_indexvalue_dataset_indices.svg)

#### Defining the data

Let's define some uncertain values that are associated with the indices. 

```julia 
u1 = UncertainValue(Gamma, rand(Gamma(), 500))
u2 = UncertainValue(rand(MixtureModel([Normal(1, 0.3), Normal(0.1, 0.1)]), 500))
uvals3 = [UncertainValue(Normal, rand(), rand()) for i = 1:11]

measurements = [u1; u2; uvals3]
datavals = UncertainValueDataset(measurements)
```

![](uncertain_indexvalue_dataset_vals.svg)


#### Combinining the indices and values 

Now, we combine the indices and the corresponding data. 

```julia 
d = UncertainIndexDataset(inds, datavals)
```

Plot the dataset with error bars in both directions, using the 20th to 80th percentile 
range for the indices and the 33rd to 67th percentile range for the data values. 

```
plot(d, [0.2, 0.8], [0.33, 0.67])
```

![](uncertain_indexvalue_dataset_indices_and_vals.svg)
