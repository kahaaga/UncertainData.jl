# UncertainData.jl

## Motivation
UncertainData.jl was born to systematically deal with uncertain data, and to sample uncertain dataset more rigorously. It makes workflows involving uncertain data of different types and from different sources significantly easier.

## Package philosophy
Way too often in data analysis the uncertainties in observational data are ignored or not dealt with in a systematic manner. The core concept of the package is that uncertain data should live in the probability domain, not as single value representations of the data (e.g. the mean).

In this package, data values are stored as probability distributions. Individual uncertain observations may be collected in `UncertainDatasets`, which can be sampled according to user-provided sampling constraints. Likewise, indices (e.g. time, depth or any other index) of observations are
also represented as probability distributions. Indices may also be sampled using constraints, for example enforcing strictly increasing values.

## Basic workflow

1. [**Define uncertain values**](uncertain_values/uncertainvalues_overview.md) by probability distributions.
2. [**Define uncertain datasets**](uncertain_datasets/uncertain_datasets_overview.md) by gathering uncertain values.
3. [**Use sampling constraints**](sampling_constraints/available_constraints.md) to [constraint the support of the distributions furnishing the uncertain values](sampling_constraints/constrain_uncertain_values.md) (i.e. apply subjective criteria to decide what is acceptable data and what is not).
4. [**Resample the the uncertain values**](resampling/resampling_uncertain_values.md) or uncertain datasets.
5. [**Extend existing algorithm**](implementing_algorithms_for_uncertaindata.md) to accept uncertain values/datasets.
6. [**Quantify the uncertainty**](uncertain_statistics/core_stats/core_statistics.md) in your dataset or on whatever measure your algorithm computes.
