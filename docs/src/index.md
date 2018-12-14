# UncertainData.jl


## Motivation
UncertainData.jl was born to systematically deal with uncertain data, and to sample uncertain dataset more rigorously. It makes workflows involving uncertain data significantly easier.

## Probabilistic representation of uncertain observations
Way too often in data analysis the uncertainties in observational data are ignored or not dealt with in a systematic manner. The core concept of the package is that uncertain data should live in the probability domain, not as single value representations of the data (e.g. the mean).

## Uncertain values and datasets of uncertain values
In this package, data values are stored as probability distributions.
Likewise, indices (e.g. time, depth or any other index) of observations are
also represented as probability distributions.

Individual uncertain observations may be collected in `UncertainDatasets`, which can be sampled according to user-provided sampling constraints.


## Basic workflow
### Creating uncertain values
Uncertain values are created by using the `UncertainValue` constructor.

There are two ways to construct uncertain values:

1. Fitting a distribution to empirical data
2. Specifying a probability distribution with parameters.

### Creating uncertain datasets
Blabla.

## Resampling
