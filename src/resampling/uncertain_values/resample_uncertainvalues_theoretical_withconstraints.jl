import ..UncertainValues.AbstractUncertainValue
import ..SamplingConstraints:
    SamplingConstraint,
	NoConstraint,
	TruncateLowerQuantile,
	TruncateUpperQuantile,
	TruncateQuantiles,
	TruncateMinimum,
	TruncateMaximum,
	TruncateRange,
    TruncateStd
import Distributions: Truncated


########################################################################
# Resampling with constraints
########################################################################

"""
Resample an uncertain value by first truncating its furnishing distribution with the 
provided sampling `constraint`.
"""
function resample(uv::AbstractUncertainValue, constraint::SamplingConstraint) end

"""
    resample(uv::AbstractUncertainValue, constraint::NoConstraint)

Resample an uncertain value without contraints (use the full furnishing distribution).

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

Resample an uncertain value without contraints (use the full furnishing distribution).

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


"""
    resample(uv::AbstractUncertainValue, constraint::TruncateStd, n::Int; 
        n_draws::Int = 10000)

Resample by first truncating the distribution representing the value to some multiple 
of its standard deviation around the mean.

## Example

```julia
uncertainval = UncertainValue(0, 0.8, Normal)
constraint = TruncateStd(1.1) # accept values only in range 1.1*stdev around the mean

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateStd, n::Int; 
        n_draws::Int = 10000)
    # Apply (another level of) truncation, then sample
    stdev = std(resample(uv, n_draws))
    m = mean(resample(uv, n_draws))
    lower_bound = m - stdev
    upper_bound = m + stdev

    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end


"""
    resample(uv::AbstractUncertainValue, constraint::TruncateMinimum)

Resample by first truncating the distribution representing the value at some
minimum value, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)
constraint = TruncateMinimum(-0.5) # accept no values less than -0.5

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateMinimum)
    # Apply (another level of) truncation, then sample
    lower_bound = constraint.min
    upper_bound = support(uv.distribution).ub
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing
    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateMinimum, n::Int)

Resample by first truncating the distribution representing the value at some
minimum value, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.2, Normal)
constraint = TruncateMinimum(-0.5)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateMinimum, n::Int)
    # Apply (another level of) truncation, then sample
    lower_bound = constraint.min
    upper_bound = support(uv.distribution).ub
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing
    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateMaximum)

Resample by first truncating the distribution representing the value at some
minimum value, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.8, Normal)
constraint = TruncateMaximum(1.1) # accept no values larger than 1.1

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateMaximum)
    # Apply (another level of) truncation, then sample
    upper_bound = constraint.max
    lower_bound = support(uv.distribution).lb
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing
    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateMaximum, n::Int)

Resample by first truncating the distribution representing the value at some
minimum value, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.8, Normal)
constraint = TruncateMaximum(1.1) # accept no values larger than 1.1

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateMaximum, n::Int)
    # Apply (another level of) truncation, then sample
    lower_bound = support(uv.distribution).lb
    upper_bound = constraint.max
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing
    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end



"""
    resample(uv::AbstractUncertainValue, constraint::TruncateRange)

Resample by first truncating the distribution representing the value at some
minimum value, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.8, Normal)
constraint = TruncateRange(-0.7, 1.1) # accept values only in range [-0.7, 1.1]

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateRange)
    # Apply (another level of) truncation, then sample
    lower_bound = constraint.min
    upper_bound = constraint.max
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing

    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateRange, n::Int)

Resample by first truncating the distribution representing the value at some
minimum value, then performing the resampling.

## Example

```julia
uncertainval = UncertainValue(0, 0.8, Normal)
constraint = TruncateRange(-0.7, 1.1) # accept values only in range [-0.7, 1.1]

# Resample the uncertain value `1000` times by truncating the distribution furnishing it,
# then resampling the new distribution `1000` times 
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateRange, n::Int)
    # Apply (another level of) truncation, then sample
    lower_bound = constraint.min
    upper_bound = constraint.max
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing

    rand(Truncated(uv.distribution, lower_bound, upper_bound), n)
end

"""
    resample(uv::AbstractUncertainValue, constraint::TruncateStd; n_draws::Int = 10000)

Resample by first truncating the distribution representing the value to some multiple 
of its standard deviation around the mean.

## Example

```julia
uncertainval = UncertainValue(0, 0.8, Normal)
constraint = TruncateStd(1.1) # accept values only in range 1.1*stdev around the mean

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 1000 times.
resample(uncertainval, constraint, 1000)
```
"""
function resample(uv::AbstractUncertainValue, constraint::TruncateStd; n_draws::Int = 10000)
    # Apply (another level of) truncation, then sample
    stdev = std(resample(uv, n_draws))
    m = mean(resample(uv, n_draws))
    lower_bound = m - stdev
    upper_bound = m + stdev
    lower_bound > upper_bound ? error("lower bound > upper_bound") : nothing
    rand(Truncated(uv.distribution, lower_bound, upper_bound))
end


export resample