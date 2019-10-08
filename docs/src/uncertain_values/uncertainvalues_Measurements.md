`Measurement` instances from [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl)[^1] are 
treated as normal distributions with known means. *Note: once you convert a measurement, you lose the 
functionality provided by Measurements.jl, such as exact error propagation*.

# Generic constructor

If `x = measurement(2.2, 0.21)` is a measurement, then `UncertainValue(x)` will return an
`UncertainScalarNormallyDistributed` instance.

# References

[^1]:
    M. Giordano, 2016, "Uncertainty propagation with functionally correlated quantities", arXiv:1610.08716 (Bibcode: 2016arXiv161008716G).