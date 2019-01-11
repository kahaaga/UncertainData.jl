# UncertainData.jl

## Motivation
UncertainData.jl was born to systematically deal with uncertain data, and to sample 
uncertain datasets more rigorously. It makes workflows involving uncertain data of 
different types and from different sources significantly easier. 

The package allows handling of uncertain values of several different types:
- [theoretical distributions with known parameters](uncertain_values/uncertainvalues_theoreticaldistributions.md)
- [theoretical distributions with parameters estimated from experimental data](uncertain_values/uncertainvalues_fitted.md)
- [more complex distributions determined by kernel density estimates of experimental data](uncertain_values/uncertainvalues_kde.md)

A related package is [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl),
which propagates errors exactly and handles correlated uncertainties. However, 
Measurements.jl accepts only normally distributed values. This package serves a slightly 
different purpose: it was born to provide an easy way of handling uncertainties of **any** 
type, using a [resampling](resampling/resampling_overview.md) approach to obtain 
[statistics](uncertain_statistics/core_stats/core_statistics.md)
when needed, and providing a rich set of 
[sampling constraints](sampling_constraints/available_constraints.md) that makes it easy 
for the user to reason about and plot their uncertain data under different assumptions.

## Package philosophy

Way too often in data analysis the uncertainties in observational data are ignored or not 
dealt with in a systematic manner. The core concept of the package is that uncertain data 
should live in the probability domain, not as single value representations of the data 
(e.g. the mean).

In this package, uncertain data values are thus 
[stored as probability distributions](uncertain_values/uncertainvalues_overview.md). 
Only when performing a computation or plotting, the uncertain values are realized by 
resampling the probability distributions furnishing them. 

Individual uncertain observations may be collected in 
[UncertainDatasets](uncertain_datasets/uncertain_datasets_overview.md), which can be 
sampled according to user-provided sampling constraints. Likewise, indices (e.g. time, 
depth or any other index) of observations can also be represented as probability 
distributions and may also sampled using constraints. 

The [UncertainIndexValueDataset](uncertain_datasets/uncertain_indexvalue_dataset.md) type 
allows you to work with datasets where both the indices and data values are uncertain.
This may be useful when you, for example, want to draw realizations of your dataset while 
simultaneously enforcing strictly increasing age models.

## Mathematical operations 

Several [elementary mathematical operations](mathematics/elementary_operations.md) and 
[trigonometric functions](mathematics/trig_functions.md) are supported 
for uncertain values. Computations are done using a 
[resampling approach](resampling/resampling_overview).

## Statistics on uncertain datasets

[Statistics](uncertain_statistics/core_stats/core_statistics.md) on 
uncertain observations and uncertain datasets are obtained using a resampling approach. 

## Basic workflow

1. [**Define uncertain values**](uncertain_values/uncertainvalues_overview.md) by probability distributions.
2. [**Define uncertain datasets**](uncertain_datasets/uncertain_datasets_overview.md) by gathering uncertain values.
3. [**Use sampling constraints**](sampling_constraints/available_constraints.md) to [constraint the support of the distributions furnishing the uncertain values](sampling_constraints/constrain_uncertain_values.md) (i.e. apply subjective criteria to decide what is acceptable data and what is not).
4. [**Resample the uncertain values**](resampling/resampling_uncertain_values.md) or [uncertain datasets](resampling/resampling_uncertain_values.md).
5. [**Extend existing algorithm**](implementing_algorithms_for_uncertaindata.md) to accept uncertain values/datasets.
6. [**Quantify the uncertainty**](uncertain_statistics/core_stats/core_statistics.md) in your dataset or on whatever measure your algorithm computes.



## Related software

[Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) also deals with 
uncertainty handling, propagates errors in computations, and deals with functional 
correlations out of the box. At the moment, it only handles normally distributed 
data. However, depending on your needs, it may be a better (and faster) choice if your data 
satisfies the requirements for the package (normally distributed) and if your uncertainties 
are correlated.