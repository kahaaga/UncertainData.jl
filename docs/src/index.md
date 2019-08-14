# UncertainData.jl

## Motivation

UncertainData.jl was born to systematically deal with uncertain data, and to 
[sample](resampling/resampling_overview.md) from 
[uncertain datasets](uncertain_datasets/uncertain_datasets_overview.md) more rigorously. 
It makes workflows involving 
[uncertain data of different types](uncertain_values/uncertainvalues_overview.md) 
and from different sources significantly easier. 

## Package philosophy

Way too often in data analysis the uncertainties in observational data are ignored or not 
dealt with in a systematic manner. The core concept of the package is that uncertain data 
should live in the probability domain, not as single value representations of the data 
(e.g. the mean).

In this package, uncertain data values are thus 
[stored as probability distributions](uncertain_values/uncertainvalues_overview.md). 
Only when performing a computation or plotting, the uncertain values are realized by 
resampling the probability distributions furnishing them. 

## Organising uncertain data

Individual uncertain observations may be collected in 
[UncertainDatasets](uncertain_datasets/uncertain_datasets_overview.md), which can be 
sampled according to user-provided sampling constraints. Likewise, indices (e.g. time, 
depth or any other index) of observations can also be represented as probability 
distributions and may also sampled using constraints. 

The [UncertainIndexValueDataset](uncertain_datasets/uncertain_indexvalue_dataset.md) type 
allows you to work with datasets where both the 
[indices](uncertain_datasets/uncertain_index_dataset.md) and the 
[data values](uncertain_datasets/uncertain_value_dataset.md) are uncertain.
This may be useful when you, for example, want to draw realizations of your dataset while 
simultaneously enforcing 
[sequential resampling](resampling/sequential/resampling_uncertaindatasets_sequential.md), 
for example 
[strictly increasing](resampling/sequential/resampling_indexvalue_sequential.md) age models.

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

A related package is [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl),
which propagates errors exactly and handles correlated uncertainties. However, 
Measurements.jl accepts only normally distributed values. This package serves a slightly 
different purpose: it was born to provide an easy way of handling uncertainties of 
[many different types](uncertain_values/uncertainvalues_overview.md), 
using a [resampling](resampling/resampling_overview.md) approach to obtain 
[statistics](uncertain_statistics/core_stats/core_statistics.md)
when needed, and providing a rich set of 
[sampling constraints](sampling_constraints/available_constraints.md) that makes it easy 
for the user to reason about and plot their uncertain data under different assumptions.

Depending on your needs, [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) 
may be a better (and faster) choice if your data satisfies the requirements for the package 
(normally distributed) and if your uncertainties are correlated.

# Contributing

If you have questions, or a good idea for new functionality that could be useful to have in 
the package, please submit an issue, or even better - a pull request.