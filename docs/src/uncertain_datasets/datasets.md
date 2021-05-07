# Uncertain datasets

## `UncertainValueDataset`

```@docs
UncertainValueDataset
```

## `UncertainIndexDataset`

```@docs
UncertainIndexDataset
```


## `UncertainIndexValueDataset`

```@docs
UncertainIndexValueDataset
```

## Examples

### Example 1: `UncertainIndexValueDataset`


`UncertainIndexValueDataset`s have uncertainties associated with both the 
indices (e.g. time, depth, etc) and the values of the data points.


Let's consider some measurements with associated uncertainties, which are of different types, 
because they are taken from different sources and/or were measured used different devices.
The values were measures at some time indices by an inaccurate clock, so that the times 
of measuring are normally distributed values with fluctuating standard deviations. We'll 
represent all of these measurements in an [`UncertainIndexValueDataset`](@ref).

Built-in plot recipes make it easy to visualize such datasets with error bars.
By default, plotting the dataset plots the median value of the index and the measurement 
(only for scatter plots), along with the 33rd to 67th percentile range error bars in both 
directions. You can also tune the error bars explicitly, by specifying
quantiles, like below:

```@example uivd1
using UncertainData, Plots

# These are our measurements
r1 = [UncertainValue(Normal, rand(), rand()) for i = 1:10]
r2 = UncertainValue(rand(10000))
r3 = UncertainValue(Uniform, rand(10000))
r4 = UncertainValue(Normal, -0.1, 0.5)
r5 = UncertainValue(Gamma, 0.4, 0.8)
vals = [r1; r2; r3; r4; r5]

# These are our time indices
inds = [UncertainValue(Normal, i, rand(Uniform(0, 1))) for i = 1:length(vals)]

# Combine indices and values
x = UncertainIndexValueDataset(inds, vals)

# Plot 90th percentile range both for indices and values.
plot(x, [0.05, 0.95], [0.05, 0.95], xlabel = "Time", ylabel = "Value")
savefig("uncertainindexvaluedataset_ex1.png") # hide
```

![](uncertainindexvaluedataset_ex1.png)

### Example 2: `UncertainIndexValueDataset`

Say we had a dataset of 20 values for which the uncertainties are normally distributed 
with increasing standard deviation through time. We also have some uncertain values 
that are associated with the indices.

```@example uivd2
using UncertainData, Plots, Distributions

# Time indices
time_inds = 1:13
uvals = [UncertainValue(Normal, ind, rand(Uniform()) + (ind / 6)) for ind in time_inds]
inds = UncertainIndexDataset(uvals)

# Measurements
u1 = UncertainValue(Gamma, rand(Gamma(), 500))
u2 = UncertainValue(rand(MixtureModel([Normal(1, 0.3), Normal(0.1, 0.1)]), 500))
uvals3 = [UncertainValue(Normal, rand(), rand()) for i = 1:11]
measurements = [u1; u2; uvals3]

# Combine indices and values
x = UncertainIndexValueDataset(inds, measurements)

# Plot the dataset with error bars in both directions, using the 20th to 80th percentile 
# range for the indices and the 33rd to 67th percentile range for the data values. 
plot(x, [0.2, 0.8], [0.33, 0.67], xlabel = "Time", ylabel = "Value")
savefig("uncertainindexvaluedataset_ex2.png") # hide
```

![](uncertainindexvaluedataset_ex2.png)
