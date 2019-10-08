# UncertainData.jl

## Motivation

UncertainData.jl was born to systematically deal with uncertain data, and to 
[sample](resampling/resampling_overview.md) from 
[uncertain datasets](uncertain_datasets/uncertain_datasets_overview.md) more rigorously. 
It makes workflows involving uncertain data of 
[different types](uncertain_values/uncertainvalues_overview.md) 
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

Individual uncertain observations of different types are seamlessly mixed and can
be organised in [collections of uncertain values](uncertain_datasets/uncertain_datasets_overview.md).

## Mathematical operations

Several [elementary mathematical operations](mathematics/elementary_operations.md) and 
[trigonometric functions](mathematics/trig_functions.md) are supported 
for uncertain values. Computations are done using a 
[resampling approach](resampling/resampling_overview).

## Statistics on uncertain datasets

Statistics on uncertain datasets are computed using a resampling approach:

- [Core statistics](uncertain_statistics/core_stats/core_statistics.md)
- [Hypothesis tests](uncertain_statistics/hypothesistests/hypothesis_tests_overview.md)

## Resampling

[Resampling](resampling/resampling_overview.md) is done by drawing random numbers from the furnishing distributions/populations of the uncertain value(s), using one of the [`resample`](@ref) methods.

[Individual uncertain values](resampling/resampling_uncertain_values) may be sampled as they are,
or after first applying [sampling constraints](sampling_constraints/available_constraints.md) on the underlying distributions/populations.

[Collections of uncertain values](resampling/resampling_uncertain_datasets.md) can also be resampled, either assuming no sequential dependence for your data, or by applying sequential sampling models. During this process [sampling constraints](sampling_constraints/available_constraints.md) can be applied element-wise or on entire collections.

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

## Contributing

If you have questions, or a good idea for new functionality that could be useful to have in 
the package, please submit an issue, or even better - a pull request.