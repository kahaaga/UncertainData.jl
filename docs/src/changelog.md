## UncertainData.jl v0.1.4

### Breaking changes 
- Elementary operations for `(scalar, uncertain_value)`, `(uncertain_value, scalar)` and 
    `(uncertain_value, uncertain_value)` pairs now returns an uncertain value instead of 
    a vector of resampled realizations. The default behaviour is to perform a kernel 
    density estimate over the vector of results of the element-wise operations (which 
    was previously returned without representing it as an uncertain value).

### New functionality 
- Implemented constraints for datasets that have already been constrained. 
    `constrain(udata::ConstrainedDataset, s::SamplingConstraint)` will now return another 
    `ConstrainedDataset`. The same applies for `ConstrainedIndexDataset` and 
    `ConstrainedValueDataset`.
- Added `maximum(Vector{AbstractUncertainValue})` and 
    `minimum(Vector{AbstractUncertainValue})` methods.
- Added plot recipe for `Vector{AbstractUncertainValue}`s. Behaves just as plotting an
    uncertain dataset, assuming an implicit indices `1:length(v)`. Error bars may be 
    tuned by providing a second argument of quantiles to `plot`, e.g. `plot(v, [0.2, 0.8]`
    gives error bars covering the 20th to 80th percentile range of the data.

### Improvements 
- Added documentation for `StrictlyIncreasing` and `StrictlyDecreasing` sampling 
    constraints.
- Added `show` function for `AbstractUncertainIndexDataset`. `show` errored previously, 
    because it assumed the default behaviour of `AbstractUncertainValueDataset`, which 
    does not have the `indices` field.

### Bug fixes
- Fixed bug when resampling an uncertain dataset using the `NoConstraint` constraint, 
    which did not work to due to a reference to a non-existing variable.


## UncertainData.jl v0.1.3

### New functionality 
- Allow both the `indices` and `values` fields of `UncertainIndexValueDataset` to be any 
    subtype of `AbstractUncertainValueDataset`. This way, you don't **have** to use an 
    index dataset type for the indices if not necessary.

### Improvements 
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

### New functionality
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

### Fixes 
- Fixed bug in resampling of index-value datasets, where the `n` arguments wasn't used. 
- Bugfix: due to `StatsBase.std` not being defined for `FittedDistribution` instances, 
    uncertain values represented by `UncertainScalarTheoreticalFit` instances were not 
    compatible with the `TruncateStd` sampling constraint. Now fixed!
- Added missing `resample(uv::AbstractUncertainValue, constraint::TruncateRange, n::Int)` 
    method.

### Improvements 
- Improved resampling documentation for `UncertainIndexValueDataset`s. Now shows 
    the documentation for the main methods, as well as examples of how to use different 
    sampling constraints for each individual index and data value.
- Improved resampling documentation for `UncertainDataset`s. Now shows 
    the documentation for the main methods.


## UncertainData.jl v0.1.1

### New functionality 
- Indexing implemented for `UncertainIndexValueDataset`. 
- Resampling implemented for `UncertainIndexValueDataset`.
- Uncertain values and uncertain datasets now support `minimum` and `maximum`.
- `support(uv::AbstractUncertainValue)` now always returns an interval from 
    [IntervalArithmetic.jl](https://github.com/JuliaIntervals/IntervalArithmetic.jl/)
- `support_overlap` now computes overlaps also for fitted theoretical distributions.
- Added more plotting recipes. 
- All implemented uncertain data types now support resampling. 

### Improvements
- Improved general documentation. Added a reference to [
    Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) and an explanation 
    for the differences between the packages.
- Improved resampling documentation with detailed explanation and plots.


## UncertainData.jl v0.1.0

- Basic functionality in place.