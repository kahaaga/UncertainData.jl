[![Build Status](https://travis-ci.com/kahaaga/UncertainData.jl.svg?branch=master)](https://travis-ci.com/kahaaga/UncertainData.jl) [![DOI](https://joss.theoj.org/papers/10.21105/joss.01666/status.svg)](https://doi.org/10.21105/joss.01666) [![DOI](https://zenodo.org/badge/160108056.svg)](https://zenodo.org/badge/latestdoi/160108056) 


# UncertainData.jl

A Julia package for dealing with data values with associated uncertainties and
datasets consisting of uncertain values.

## Goals

1. Systematic and intuitive ways of representing uncertain data.

2. Easy and robust resampling of uncertain data, given pre-defined or
custom user-defined constraints.

3. Provide a framework for robust computation of ensemble statistics for
uncertain data.

Please check out the
[documentation](https://kahaaga.github.io/UncertainData.jl/dev) for more
information.

# Installation

UncertainData.jl is a registered Julia package. Install it by opening a Julia console and run

```julia
using Pkg
Pkg.add("UncertainData")
```

# Citing

If you use UncertainData.jl for any of your projects or scientific publications, please cite [this small Journal of Open Source Software (JOSS) publication](https://joss.theoj.org/papers/10.21105/joss.01666) as follows

> Haaga, (2019). UncertainData.jl: a Julia package for working with measurements and datasets with uncertainties.. Journal of Open Source Software, 4(43), 1666, https://doi.org/10.21105/joss.01666
