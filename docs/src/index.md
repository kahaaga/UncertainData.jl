# UncertainData.jl

## Motivation
UncertainData.jl was born to systematically deal with uncertain data, and to sample 
uncertain datasets more rigorously. It makes workflows involving uncertain data of 
different types and from different sources significantly easier. 

The package allows handling of uncertain values of several different types:
- theoretical distributions with known parameters
- theoretical distributions with parameters estimated from experimental data
- more complex distributions determined by kernel density estimates of experimental data. 

A related package is [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl),
which propagates errors exactly and handles correlated uncertainties. However, 
Measurements.jl accepts only normally distributed values. This package serves a slightly 
different purpose: it was born to provide an easy way of handling uncertainties of any type,
using a resampling approach to obtain statistics when needed. The goal is to give the 
user a consistent and easy way to define uncertain datasets, plot them and reason about them 
by resampling techniques, possibly subject to sampling constraints.

## Package philosophy

Way too often in data analysis the uncertainties in observational data are ignored or not 
dealt with in a systematic manner. The core concept of the package is that uncertain data 
should live in the probability domain, not as single value representations of the data 
(e.g. the mean).

In this package, uncertain data values are thus stored as probability distributions. 
Only when performing a computation or plotting, the uncertain values are realized by 
resampling the probability distributions furnishing them. 

Individual uncertain observations may be collected in `UncertainDatasets`, which can be 
sampled according to user-provided sampling constraints. Likewise, indices (e.g. time, 
depth or any other index) of observations can also be represented as probability 
distributions and may also sampled using constraints. This may be useful when you, for 
example, want to draw realizations of your dataset while enforcing strictly increasing age 
models.

## Mathematical operations 

Several [elementary mathematical operations](mathematics/elementary_operations.md) and 
[trigonometric functions](mathematics/trig_functions.md) are supported 
for uncertain values. Computations are done using a resampling approach, where the user 
may choose to use the default number of realizations (`n = 10000`) or tune the number of 
samples.


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