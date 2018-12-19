# UncertainData.jl


## Motivation
UncertainData.jl was born to systematically deal with uncertain data, and to sample uncertain dataset more rigorously. It makes workflows involving uncertain data significantly easier.

## Probabilistic representation of uncertain observations
Way too often in data analysis the uncertainties in observational data are ignored or not dealt with in a systematic manner. The core concept of the package is that uncertain data should live in the probability domain, not as single value representations of the data (e.g. the mean).

## Uncertain values and datasets of uncertain values
In this package, data values are stored as probability distributions. Individual uncertain observations may be collected in `UncertainDatasets`, which can be sampled according to user-provided sampling constraints.

Likewise, indices (e.g. time, depth or any other index) of observations are
also represented as probability distributions. Indices may also be sampled using constraints, for example enforcing strictly increasing values.

## Basic workflow

1. **Define uncertain values** using the `UncertainValue` constructor. This
    will represent the uncertain value a probability distribution.
2. **Collect uncertain values** in an `UncertainDataset`.
3. **Define sampling constraints** for the distributions furnishing the uncertain
    values (i.e. restrict their support).
4. **Resample** the uncertain values/datasets.
5. **Extend existing algorithm** to accept uncertain values/datasets.
6. **Obtain uncertainty ensemble statistics**.
