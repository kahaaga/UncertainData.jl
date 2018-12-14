abstract type SamplingConstraint end

#########################################################################
# Sampling constraints for regular data (i.e. not age/depth/time index...,
# but the values associated to those indices).
#########################################################################

abstract type ValueSamplingConstraint <: SamplingConstraint end


"""
A (non)constraint indicating that, when sampling an `AbstractUncertainDataset`,
the full distributions for each uncertain value should be sampled fully.
"""
struct NoConstraint <: ValueSamplingConstraint end


"""
A constraint indicating that, when sampling an `AbstractUncertainDataset`, the
distributions for each uncertain value should be truncated below at some
quantile.
"""
struct TruncateLowerQuantile <: ValueSamplingConstraint
    lower_quantile::Float64
end

"""
A constraint indicating that, when sampling an `AbstractUncertainDataset`,
the distributions for each uncertain value should be truncated above at some
quantile.
"""
struct TruncateUpperQuantile <: ValueSamplingConstraint
    upper_quantile::Float64
end

""" A (non)constraint indicating that the distributions for each uncertain
value should be truncated below at some quantile. """
struct TruncateQuantiles <: ValueSamplingConstraint
    lower_quantile::Float64
    upper_quantile::Float64
end



#########################################################################
# Sampling constraints for sample indices (time index, age, depth, etc...)
# Often, these need to be sampled to obey some physical criteria (i.e.,
# observations are from physical samples lying above each other, so the order
# of the observations cannot be mixed).
#########################################################################

abstract type IndexSamplingConstraint <: SamplingConstraint end

struct StrictlyIncreasing <: IndexSamplingConstraint end

struct StrictlyDecreasing <: IndexSamplingConstraint end

struct StrictlyIncreasingWherePossible <: IndexSamplingConstraint end

struct StrictlyDecreasingWherePossible<: IndexSamplingConstraint end




struct ConstrainedUncertainValueDataset <: AbstractUncertainValueDataset
    values::UncertainDataset
    constraints::Vector{SamplingConstraint}
end


"""
    apply_constraint(d::UncertainValueDataset,
            constraints::Vector{SamplingConstraint})

Apply sampling constraints to an UncertainValueDataset.
"""
function apply_constraint(d::UncertainValueDataset,
            constraints::Vector{SamplingConstraint})
end

function realisations_possible()
    nothing
end


"""
Resample an uncertain value given a sampling constraint.
"""
function resample(uv::AbstractUncertainValue, constraint::C) where {C<:SamplingConstraint} end

"""
    resample(uv::AbstractUncertainValue, constraint::NoConstraint)

Resample without contraints (use the full distribution representing the value)

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)

# Resample the uncertain value by resampling the full distribution once.
resample(uncertainval, NoConstraint())
```
"""
resample(uv::AbstractUncertainValue, constraint::NoConstraint) = resample(uv)

"""
    resample(uv::AbstractUncertainValue, constraint::NoConstraint, n::Int)

Resample without contraints (use the full distribution representing the value)

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)

# Resample the uncertain value by resampling the full distribution 1000 times.
resample(uncertainval, NoConstraint(), 1000)
```
"""
resample(uv::AbstractUncertainValue, constraint::NoConstraint, n::Int) = resample(uv, n)

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateUpperQuantile)

Resample by first truncating the distribution representing the value at a lower
quantile, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)
constraint = TruncateLowerQuantile(0.16)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateLowerQuantile)
    # Apply (another level of) truncation, then sample
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = support(uv.distribution).ub
    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateLowerQuantile, n::Int)

Resample by first truncating the distribution representing the value at a lower
quantile, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)
constraint = TruncateLowerQuantile(0.16)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateLowerQuantile, n::Int)
    # Apply (another level of) truncation, then sample
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = support(uv.distribution).ub
    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateUpperQuantile)

Resample by first truncating the distribution representing the value at an upper
quantile, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)
constraint = TruncateUpperQuantile(0.8)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateUpperQuantile)
    # Apply (another level of) truncation, then sample
    lower_bound = support(uv.distribution).lb
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)
    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateUpperQuantile, n::Int)

Resample by first truncating the distribution representing the value at an upper
quantile, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)
constraint = TruncateUpperQuantile(0.8)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateUpperQuantile, n::Int)
    # Apply (another level of) truncation, then sample
    lower_bound = support(uv.distribution).lb
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)
    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateQuantiles)

Resample by first truncating the distribution representing the value at a set of
qunatiles, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 1, Uniform)
constraint = TruncateLowerQuantile(0.2)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateQuantiles)
    # Apply (another level of) truncation, then sample
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)
    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateQuantiles, n::Int)

Resample by first truncating the distribution representing the value at a set of
qunatiles, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 1, Uniform)
constraint = TruncateLowerQuantile(0.2)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateQuantiles, n::Int)
    # Apply (another level of) truncation, then sample
    lower_bound = quantile(uv.distribution, constraint.lower_quantile)
    upper_bound = quantile(uv.distribution, constraint.upper_quantile)
    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end


export
SamplingConstraint,
ValueSamplingConstraint,
NoConstraint,
TruncateLowerQuantile,
TruncateUpperQuantile,
TruncateQuantiles,
IndexSamplingConstraint,
StrictlyIncreasing,
StrictlyDecreasing,
resample
