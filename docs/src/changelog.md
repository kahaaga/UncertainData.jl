## UncertainData.jl v0.2.3

### Improvements

- Added input validation when initialising `TruncateQuantiles`, `TruncateRange` and 
    `TruncateStd`.
- Separate parameters types for `TruncateQuantiles` and `TruncateRange`, so one can do for 
    example `TruncateRange(1, 8.0)`, instead of having to promote to `Float64`.
- Added validation for distribution truncation when resampling.


## UncertainData.jl v0.2.2

### New functionality and syntax changes 

#### Resampling vectors consisting of uncertain values (done in #61)

- `resample(uvals::Vector{AbstractUncertainValue}, n::Int)` is now interpreted as "treat 
    `uvals` as a dataset and sample it `n` times". Thus, it now behaves as 
    `resample(AbstractUncertainDataset, n::Int)`, returning `n` vectors of length 
    `length(uvals)`, where the i-th element is a unique draw of `uvals[i]`.

- `resample_elwise(uvals::Vector{AbstractUncertainValue}, n::Int)` takes over the role as 
    "sample `uvals` element-wise and `n` times for each element". Returns a vector of 
    length `length(uvals)`, where the i-th element is a `n`-element vector of unique draws 
    of `uvals[i]`.

#### Resampling with subtypes of `AbstractUncertainValueDataset`

Currently, this affects the generic `UncertainDataset`s, as well as the specialized 
`UncertainIndexDataset`s and `UncertainValueDataset`s.

- `resample_elwise(uvd::AbstractUncertainValueDataset, n::Int)` is now interpreted as 
    "draw `n` realisations of each value in `uvd`". Returns a vector of length `length(uvals)` 
    where the i-th element is a `n`-element vector of unique draws of `uvals[i]`. This works 
    for `UncertainDataset`s, `UncertainIndexDataset`s, and `UncertainValueDataset`s. 
- `resample_elwise(uvd::AbstractUncertainValueDataset, constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}, n::Int)` 
    is now interpreted as "draw `n` realisations of each value in `uvd`, subjecting each value 
    in `uvd` to some sampling `constraint`(s) during resampling". Returns a vector of 
    length `length(uvals)` where the i-th element is a `n`-element vector of unique draws 
    of `uvals[i]`, where the support of `uvals[i]` has been truncated by the provided 
    `constraint`(s).

### Bug fixes

- Removed extra blank line from print method for `AbstractUncertainPopulation`.

## UncertainData.jl v0.2.1

### New functionality

- `merge(uvals::Vector{<:AbstractUncertainValue}; n = 1000)` now makes it possible to 
    combine many uncertain values of different into one uncertain value represented by a 
    kernel density estimate. This is achieved by resampling each of the values `n` times, 
    then pooling the draws and estimating a total distribution using KDE.
- `merge(uvals::Vector{<:AbstractUncertainValue}; weights::Weights n = 1000)`, 
    `merge(uvals::Vector{<:AbstractUncertainValue}; weights::AnalyticalWeights n = 1000)` 
    and 
    `merge(uvals::Vector{<:AbstractUncertainValue}; weights::ProbabilityWeights n = 1000)`
    merges uncertain values by resampling them proportionally to `weights`, then pooling 
    the draws and performing KDE. These are all functionally equivalent, but implementations
    for different weights are provided for compatibility with StatsBase.
- `merge(uvals::Vector{<:AbstractUncertainValue}; weights::FrequencyWeights n = 1000)` 
    merges uncertain values by sampling them according to the number of samples provided 
    with `weights`.

### Bug fixes
- `resample` didn't work for `UncertainIndexDataset`s due to the data being stored in the 
    `indices` field, not the `values` field as for other subtypes of 
    `AbstractUncertainValueDataset`. This is now fixed.


## UncertainData.jl v0.2.0

### Notes
- Julia 1.1 is required for version > v.0.2.0.

### New functionality 
- Spline interpolation on a regular grid. 
- Linear interpolation on an irregular grid. 

### Improvements
- `support_overlap` now returns an interval (from `IntervalArithmetic`), in line with 
    what `support` returns.

## UncertainData.jl v0.1.8

### Bug fixes
- Added missing package dependencies which were not caught by CI.

## UncertainData.jl v0.1.7

### New functionality 
- `UncertainIndexValueDataset`s can now be constructed from vectors of uncertain values. 
    To do so, provide a vector of uncertain values for the indices, and the same for the 
    values, e.g. `UncertainIndexValueDataset([idx1, idx2], [val1, val2])`.
- Index-value dataset realizations can now be 
    [interpolated on a regular grid](resampling/interpolation/gridded.md). 

### Bug fixes 
- `minima` and `maxima` now returns the global minimum for a dataset instead of a vector 
    of elementwise minima and maxima.
- Implemented the option to linearly interpolate index-value dataset realizations. 
    To do so, provide `resample` with a [`RegularGrid`](link) instance. 
- Merged redundant methods for assigning some distributions.
- Fixed non-critical indexing bug for uncertain index-value datasets.
- Removed redudant method definitions and multiple imports of the same files causing 
    definitions to be overwritten and printing warnings statements when loading the package.

## UncertainData.jl v0.1.6

### New functionality 

- Implemented sequential sampling constraints `StrictlyIncreasing` and `StrictlyDecreasing`
    for `UncertainIndexValueDataset`s. 
- Added [UncertainScalarPopulation](uncertain_values/populations.md) type, representing 
    vectors of values that should be sampled according to a vector of probabilities. 
    
### Improvements 
- Improved documentation for `CertainValue`s.
- Added documentation for `UncertainScalarPopulation`.
- Added `UncertainScalarPopulation` to uncertain value overview list in the documentation.
- Fixed duplicate docs for `cot`, `cotd`, `coth` and added missing `acot`, `acotd`, `acoth`
    docs.
- Shortened and updated main documentation page with more links.

### Bug fixes 

- Import `Base` functions properly when defining `CertainValue`, so that no unexpected 
    behaviour is introduced.
- Fixed links in documentation that pointed to the wrong locations.
- Remove model resampling docs which was not supposed to be published until the 
    functionality is properly implemented.

## UncertainData.jl v0.1.5


### New functionality 

- Added [CertainValue](uncertain_values/certainvalue.md) type to represent scalars without
    any uncertainty. Even though a scalar is not uncertain, we'll define it as subtype of 
    `AbstractUncertainValue` to treat certain values alongside uncertain values in datasets. 
- Added plot recipe for `CertainValue`s. They are just plotted as regular points.
- Added method `resample(Vector{AbstractUncertainValue})` for resampling vectors of 
    uncertain values. Operates element-wise, just as for an uncertain dataset. 
- Added an abstract type `SequentialSamplingConstraint` to separate sequential constraints 
    from general constraints that might be applied *before* resampling according to 
    the sequential constraints.
- Added abstract type (`OrderedSamplingAlgorithm`) and composite types 
    (`StartToEnd`, `EndToStart`, `MidpointOutwards`, `ChunksForwards`, `ChunksBackwards`) 
    which indicates how to sample sequential realizations when resampling an uncertain 
    dataset. Only `StartToEnd` is used at the moment.
- Added abstract type `SequentialSamplingConstraint` which is the supertype for all 
    sequential constraints.
- Added function to check if strictly increasing sequences through an uncertain dataset 
    exist: `strictly_increasing_sequence_exists(udata::AbstractUncertainValueDataset`.
- Added function to check if strictly decreasing sequences through an uncertain dataset 
    exist: `strictly_increasing_sequence_exists(udata::AbstractUncertainValueDataset`.
- Added the `StrictlyIncreasing{T} where {T<:OrderedSamplingAlgorithm}` sequential 
    constraint for resampling uncertain datasets. 
- Added the `StrictlyDecreasing{T} where {T<:OrderedSamplingAlgorithm}` sequential 
    constraint for resampling uncertain datasets. 
- Added resampling methods

    1. `resample(udata, sequential_constraint::StrictlyIncreasing{T} where {T <: StartToEnd}`
    2. `resample(udata, sequential_constraint::StrictlyDecreasing{T} where {T <: StartToEnd}`
    3. `resample(udata, constraint::SamplingConstraint, sequential_constraint::StrictlyIncreasing{T} where {T <: StartToEnd}`
    4. `resample(udata, constraint::SamplingConstraint, sequential_constraint::StrictlyDecreasing{T} where {T <: StartToEnd}`
    5. `resample(udata, constraint::Vector{SamplingConstraint}, sequential_constraint::StrictlyIncreasing{T} where {T <: StartToEnd}`
    6. `resample(udata, constraint::Vector{SamplingConstraint}, sequential_constraint::StrictlyDecreasing{T} where {T <: StartToEnd}`

### Improvements 
- Added [documentation on sequential constraints]("sampling_constraints/sequential_constraints.md"), clearly separating it from the general constraints. 


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
- Fixed test bug where when resampling an uncertain value with the `TruncateStd` sampling
    constraint, the test compared the result to a fixed scalar, not the standar deviation 
    of the value. This sometimes made the travis build fail.


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
- Cleaned and improved [documentation for uncertain values](uncertain_values/uncertainvalues_overview.md). 
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
