# UncertainData changelog

## v.0.14.1

### Features

- Implement sequential resampling with chunks.

### Misc

- Make some methods more generic (non-breaking).

## v.0.14.0

### Breaking changes 

- `sequence_exists` replaces `strictly_increasing_sequence_exists`/`strictly_decreasing_sequence_exists`.
- When resampling using sequential constraints, the quantiles used to truncate distributions now have to be given 
    to the constructors of the sequential constraints, i.e. `resample(x, StrictlyIncreasing(lq = 0.1, uq = 0.9)` instead of `resample(x, StrictlyIncreasing(), 0.1, 0.9)`.

### Bug fixes

- Fixed bug that could occasionally occur for certain types of data when performing resampling with the `StrictlyIncreasing`/`StrictlyDecreasing` sequential constraints.

## v0.12.0

### Bug fixes

- Fixed bug where indices were sampled instead of values for the method 
    `resample(x::UncertainIndexValueDataset, constraint::SamplingConstraint, sequential_constraint::Union{StrictlyDecreasing, StrictlyDecreasing}`.

