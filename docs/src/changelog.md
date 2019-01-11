## UncertainData.jl v0.1.3

- Allow both the `indices` and `values` fields of `UncertainIndexValueDataset` to be any 
    subtype of `AbstractUncertainValueDataset`. This way, you don't **have** to use an 
    index dataset type for the indices if not necessary.
- Improved documentation for `UncertainIndexDataset`, `UncertainValueDataset`, 
    `UncertainDataset` and `UncertainIndexValueDataset` types and added an 
    [overview page](uncertain_datasets/uncertain_datasets_overview.md) in the documentation 
    to explain the difference between these types.
- Added an [overview](resampling/resampling_overview.md) section for the resampling 
    documentation.
- Cleaned and improved [documentation for uncertain values](uncertainvalues_overview.md). 
- Added separate [documentation for the uncertain index dataset type](uncertain_datasets/uncertain_index_dataset.md).
- Added separate [documentation for the uncertain value dataset type](uncertain_datasets/uncertain_value_dataset.md).
- Improved [documentation for the generic uncertain dataset type](uncertain_datasets/uncertain_dataset.md) 
- Merged documentation for sampling constraints and resampling.
- Added missing documentation for the `sinc`, `sincos`, `sinpi`, `cosc` and `cospi` trig 
    functions.

## UncertainData.jl v0.1.2

- Support [elementary mathematical operations](mathematics/elementary_operations.md) 
    (`+`, `-`, `*` and `/`) between arbitrary 
    uncertain values of different types. Also works with the combination of scalars and 
    uncertain values. Because elementary operations should work on arbitrary uncertain 
    values, a resampling approach is used to perform the mathematical operations. This 
    means that all mathematical operations return a vector containing the results of 
    repeated element-wise operations (where each element is a resampled draw from the 
    furnishing distribution(s) of the uncertain value(s)). The default number of 
    realizations is set to `10000`. This allows calling `uval1 + uval2` for two uncertain 
    values `uval1` and `uval2`. If you need to tune the number of resample draws to `n`, 
    you need to use the `+(uval1, uval2, n)` syntax (similar for the operators). In the 
    future, elementary operations might be improved for certain combinations of uncertain
    values where exact expressions for error propagation are now, for example using the 
    machinery in `Measurements.jl` for normally distributed values.
- Support for [trigonometric functions] (mathematics/trig_functions.md) added (`sin`, `sind`, `sinh`, `cos`,
    `cosd`, `cosh`, `tan`, `tand`, `tanh`, `csc`, `cscd`, `csch`, `csc`, `cscd`, `csch`, 
    `sec`, `secd`, `sech`, `cot`, `cotd`, `coth`, `sincos`, `sinc`, `sinpi`, `cosc`, 
    `cospi`). Inverses are also defined (`asin`, `asind`, `asinh`, `acos`,
    `acosd`, `acosh`, `atan`, `atand`, `atanh`, `acsc`, `acscd`, `acsch`, `acsc`, `acscd`, 
    `acsch`, `asec`, `asecd`, `asech`, `acot`, `acotd`, `acoth`).
    Beware: if the support of the funishing distribution for an uncertain value lies partly 
    outside the domain of the function, you risk encountering errors.
    These also use a resampling approach, using `10000` realizations by default. 
    Use either the `sin(uval)` syntax for the default, and `sin(uval, n::Int)` to tune the 
    number of samples.
- Support non-integer multiples of the standard deviation in the `TruncateStd` sampling 
    constraint.
- Fixed bug in resampling of index-value datasets, where the `n` arguments wasn't used. 
- Bugfix: due to `StatsBase.std` not being defined for `FittedDistribution` instances, 
    uncertain values represented by `UncertainScalarTheoreticalFit` instances were not 
    compatible with the `TruncateStd` sampling constraint. Now fixed!
- Improved resampling documentation for `UncertainIndexValueDataset`s. Now shows 
    the documentation for the main methods, as well as examples of how to use different 
    sampling constraints for each individual index and data value.
- Improved resampling documentation for `UncertainDataset`s. Now shows 
    the documentation for the main methods.
- Added missing `resample(uv::AbstractUncertainValue, constraint::TruncateRange, n::Int)` 
    method.

## UncertainData.jl v0.1.1

- Indexing implemented for `UncertainIndexValueDataset`. 
- Resampling implemented for `UncertainIndexValueDataset`.
- Uncertain values and uncertain datasets now support `minimum` and `maximum`.
- `support(uv::AbstractUncertainValue)` now always returns an interval from 
    [IntervalArithmetic.jl](https://github.com/JuliaIntervals/IntervalArithmetic.jl/)
- `support_overlap` now computes overlaps also for fitted theoretical distributions.
- Added more plotting recipes. 
- All implemented uncertain data types now support resampling. 
- Improved general documentation. Added a reference to [
    Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) and an explanation 
    for the differences between the packages.
- Improved resampling documentation with detailed explanation and plots.


## UncertainData.jl v0.1.0

- Basic functionality in place.