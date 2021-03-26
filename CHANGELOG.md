# UncertainData changelog

## v0.12.0

### Bug fixes

- Fixed bug where indices were sampled instead of values for the method 
    `resample(x::UncertainIndexValueDataset, constraint::SamplingConstraint, sequential_constraint::Union{StrictlyDecreasing, StrictlyDecreasing}`.

