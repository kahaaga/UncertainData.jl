
Uncertain datasets can be sampled using various models. 

The idea behind the model resampling approach is to first resample your dataset, given 
some constraints on the furnishing distributions of each uncertain value in the dataset. 
Then, instead of returning the actual realization, a model fit to the raw realization is
returned.

For example, say we have the following uncertain values.

```julia 
uvals = [UncertainValue(Normal, rand(), rand()) for i = 1:20]
udata = UncertainValueDataset(uvals)
```

A realization of that dataset, where the i-th realized value is drawn from within the 
support of the distribution furnishing the i-th uncertain value, is created as follows:

```julia
r = resample(udata) #resample(udata, NoConstraint()) is equivalent
```

Let's say that instead of getting back the raw realization, we wanted to fit a spline onto 
it and return that. To do that, just supply a `SplineModel()` instance to `resample`. 

```julia 
r = resample(udata, SplineModel())
```