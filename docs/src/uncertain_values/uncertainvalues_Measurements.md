# Compatibility with Measurements.jl

`Measurement` instances from the Measurements.jl package[^1] are in UncertainData.jl represented as normal distributions. If exact error propagation is a requirement and your data is exclusively normally distributed, use Measurements.jl. If your data is not necessarily 
normally distributed and contain errors of different types, and 
a resampling approach to error propagation is desired, use UncertainData.jl. 

See the [`UncertainValue`](@ref) constructor for instructions on how to 
convert `Measurement`s to uncertain values compatible with this package.

[^1]:
    M. Giordano, 2016, "Uncertainty propagation with functionally correlated quantities", arXiv:1610.08716 (Bibcode: 2016arXiv161008716G).