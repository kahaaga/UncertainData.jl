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

### Creating uncertain values
Uncertain values are created by using the `UncertainValue` constructor.

There are currently three ways to construct uncertain values:

1. Estimating the distribution of your data using kernel density estimation.
1. Fitting a distribution to empirical data (if you know roughly what type
    of distribution is appropriate).
2. Specifying a probability distribution with known parameters (if you want
    to represent data found in the literature, for example normally distributed
    values with some standard deviation).

## Resampling

Uncertain values may be resampled using the `resample(uv::UncertainValue)`
function, which has methods for all the different types of uncertain values.
