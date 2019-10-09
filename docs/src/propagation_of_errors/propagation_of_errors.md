# Exact error propagation

For exact error propagation of normally distributed uncertain values that are 
potentially correlated, you can use
[Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl). It is, however,
not always the case that data points have normally distributed uncertainties,
which makes error propagation extremely tedious or impossible.

# Approximate error propagation

On the other hand, the resampling approach used in this package allows you to 
*approximate the result of any mathematical operation* for [*any type of uncertain value*](@ref uncertain_value_types).
You may still use normal distributions to represent uncertain values, but the various statistics 
are *approximated through resampling*, rather than computed exactly.
Resampling as implemented here is often referred to as the 
[Monte Carlo method](https://en.wikipedia.org/wiki/Monte_Carlo_method).

## Propagating errors using the Monte Carlo method

In our context, the Monte Carlo method consists of varying input parameters within their precision limits to determine the uncertainty in an output. This process results in a *distribution* of estimates to the
output value, where each member of the output distribution is computed from a set of randomly drawn input values. From this output distribution, information about uncertainties in the result can then be extracted (e.g from confidence intervals).

Any output distribution computed through resampling is intrinsically linked to the uncertainties in the inputs. It may also be arbitrarily complex, depending on the individual uncertainty types and magnitudes of each input, and the specific function that computes the output. For example, normally distribution input values need not yield a normally distributed output distribution.

## Mathematical operations and statistics

Hence, in this package, when performing [mathematical operations](../mathematics/elementary_operations.md) on uncertain values, it is done by drawing random numbers from within the precision of the uncertain values, performing the mathematical operation, and then repeating that many times. The result (output) of a calculation is either a vector of estimates, or a kernel density estimate to the output distribution.

Estimating [statistics](../uncertain_statistics/core_stats/core_statistics.md) on uncertain values also yields *distributions* of the statistic in question.

For further calculations, you may choose to represent the output distribution from any calculation by any of the provided [uncertain value types](@ref uncertain_value_types).

# Suggested reading

A very nice, easy-to-read paper describing error propagation using the Monte Carlo method was written
by Anderson (1976) [^1]. In this paper, he uses the Monte Carlo method to propagate uncertainties in 
geochemical calculations for which exact error propagation would be extremely tedious or impossible.

# References

[^1]:
    Anderson, G. M. "Error propagation by the Monte Carlo method in geochemical calculations." Geochimica et Cosmochimica Acta 40.12 (1976): 1533-1538. [https://www.sciencedirect.com/science/article/pii/0016703776900922](https://www.sciencedirect.com/science/article/pii/0016703776900922)
