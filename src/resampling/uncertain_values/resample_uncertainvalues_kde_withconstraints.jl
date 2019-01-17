import ..UncertainValues:
    getquantileindex,
    support,
    AbstractUncertainScalarKDE

import StatsBase:
    sample, sample!,
    Weights

import Distributions:
    Uniform

import ..SamplingConstraints:
	NoConstraint,
	TruncateLowerQuantile,
	TruncateUpperQuantile,
	TruncateQuantiles,
	TruncateMinimum,
	TruncateMaximum,
	TruncateRange,
    TruncateStd,
    fallback


"""
    resample(uv::AbstractUncertainScalarKDE, constraint::NoConstraint)

Resample without contraints (use the full distribution representing the value)

## Example

```julia
some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

# Resample the uncertain value by resampling the full distribution once.
resample(uncertainval, NoConstraint())
```
"""
resample(uv::AbstractUncertainScalarKDE, constraint::NoConstraint) = resample(uv)

"""
    resample(uv::AbstractUncertainScalarKDE, constraint::NoConstraint, n::Int)

Resample without contraints (use the full distribution representing the value)

## Example

```julia
some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

# Resample the uncertain value by resampling the full distribution n times
resample(uncertainval, NoConstraint(), n)
```
"""
resample(uv::AbstractUncertainScalarKDE, constraint::NoConstraint, n::Int) = resample(uv, n)


"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile)

Resample `uv` by first truncating below the kernel density estimate of the
distribution furnishing the value at some lower quantile, then resampling
it once.

## Example

```julia
using UncertainData

some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

constraint = TruncateLowerQuantile(0.16)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:end] |> collect
    wts = Weights(uv.pdf[idx_lower_quantile:end])

    # Sample a box
    sampled_val = sample(range, wts)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile,
        n::Int)

Resample `uv` by first truncating below the kernel density estimate of the
distribution furnishing the value at some lower quantile, then resampling
it `n` times.

## Example

```julia
using UncertainData

some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

constraint = TruncateLowerQuantile(0.16)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 500 times.
resample(uncertainval, constraint, 500)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateLowerQuantile,
        n::Int)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:end] |> collect
    wts = Weights(uv.pdf[idx_lower_quantile:end])

    # Sample n boxes according to estimated weights (pdf)
    sampled_vals = Vector{Float64}(undef, n)
    sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end


"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)

Resample `uv` by first truncating above the kernel density estimate of the
distribution furnishing the value at some upper quantile, then resampling
it once.

## Example

```julia
using UncertainData

some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

constraint = TruncateUpperQuantile(0.78)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[1:idx_upper_quantile] |> collect
    wts = Weights(uv.pdf[1:idx_upper_quantile])

    # Sample a box
    sampled_val = sample(range, wts)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile,
        n::Int)

Resample `uv` by first truncating above the kernel density estimate of the
distribution furnishing the value at some upper quantile, then resampling
it `n` times.

## Example

```julia
using UncertainData

some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

constraint = TruncateLowerQuantile(0.16)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 500 times.
resample(uncertainval, constraint, 500)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile,
        n::Int)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[1:idx_upper_quantile] |> collect
    wts = Weights(uv.pdf[1:idx_upper_quantile])

    # Sample n boxes according to estimated weights (pdf)
    sampled_vals = Vector{Float64}(undef, n)
    sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end



"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateUpperQuantile)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value both above and below at some quantile range,
then resampling it once.

## Example

```julia
using UncertainData

some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

constraint = TruncateQuantiles(0.1, 0.9)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution once.
resample(uncertainval, constraint)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:idx_upper_quantile] |> collect
    wts = Weights(uv.pdf[idx_lower_quantile:idx_upper_quantile])

    # Sample a box
    sampled_val = sample(range, wts)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end



"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles,
        n::Int)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value both above and below at some quantile range,
then resampling it `n` times.

## Example

```julia
using UncertainData

some_sample = rand(Normal(), 1000)

# Calling UncertainValue with a single vector of numbers triggers KDE estimation
uncertainval = UncertainValue(some_sample) # -> UncertainScalarKDE

constraint = TruncateQuantiles(0.1, 0.9)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 500 times.
resample(uncertainval, constraint, 500)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateQuantiles,
        n::Int)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:idx_upper_quantile] |> collect
    wts = Weights(uv.pdf[idx_lower_quantile:idx_upper_quantile])

    # Sample n boxes according to estimated weights (pdf)
    sampled_vals = Vector{Float64}(undef, n)
    sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end



"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value at some maximum value,
then resampling it once.

## Example

```julia
# Uncertain value represented by a normal distribution with mean = 0 and
# standard deviation = 1.
uncertainval = UncertainValue(rand(Normal(0, 1), 1000))

constraint = TruncateMaximum(0.8) # accept no values larger than 1.1

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 700 times.
resample(uncertainval, constraint, 700)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum)
    # Box width
    δ = step(uv.range)

    upper_bound = constraint.max
    lower_bound = minimum(uv.range)

    idx_max = findlast(uv.range .<= upper_bound)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[1:idx_max] |> collect
    wts = Weights(uv.pdf[1:idx_max])

    # Sample a box
    sampled_val = sample(range, wts)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum, n::Int)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value at some minimum value,
then resampling it `n` times.


## Example

```julia
# Uncertain value represented by a normal distribution with mean = 0 and
# standard deviation = 1.
uncertainval = UncertainValue(rand(Normal(0, 1), 1000))

constraint = TruncateMaximum(0.8) # accept no values larger than 1.1

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 700 times.
resample(uncertainval, constraint, 700)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMaximum, n::Int)
    # Box width
    δ = step(uv.range)

    upper_bound = constraint.max
    lower_bound = minimum(uv.range)

    idx_max = findlast(uv.range .<= upper_bound)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[1:idx_max] |> collect
    wts = Weights(uv.pdf[1:idx_max])

    # Sample n boxes according to estimated pdf
    sampled_vals = Vector{Float64}(undef, n)
    sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end


"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value at some minimum value,
then resampling it once.

## Example

```julia
# Uncertain value represented by a normal distribution with mean = 0 and
# standard deviation = 1.
uncertainval = UncertainValue(rand(Normal(0, 1), 1000))

constraint = TruncateMinimum(0.2) # accept no values smaller than 0.2

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 700 times.
resample(uncertainval, constraint, 700)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum)
    # Box width
    δ = step(uv.range)

    lower_bound = constraint.min
    upper_bound = maximum(uv.range)

    idx_min = findfirst(uv.range .>= lower_bound)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_min:end] |> collect
    wts = Weights(uv.pdf[idx_min:end])

    # Sample a box
    sampled_val = sample(range, wts)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end



"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum, n::Int)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value at some minimum value,
then resampling it `n` times.

## Example

```julia
# Uncertain value represented by a normal distribution with mean = 0 and
# standard deviation = 1.
uncertainval = UncertainValue(rand(Normal(0, 1), 1000))

constraint = TruncateMinimum(0.2) # accept no values smaller than 0.2

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 700 times.
resample(uncertainval, constraint, 700)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateMinimum, n::Int)
    # Box width
    δ = step(uv.range)

    lower_bound = constraint.min
    upper_bound = maximum(uv.range)

    idx_min = findfirst(uv.range .>= lower_bound)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_min:end] |> collect
    wts = Weights(uv.pdf[idx_min:end])

    # Sample n boxes according to estimated pdf
    sampled_vals = Vector{Float64}(undef, n)
    sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end


"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateRange)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value at some minimum and maximum values,
then resampling it once.

## Example

```julia
# Uncertain value represented by a normal distribution with mean = 0 and
# standard deviation = 1.
uncertainval = UncertainValue(rand(Normal(0, 1), 1000))

# Only accept values in the range [-0.9, 1.2]
constraint = TruncateRange(-0.9, 1.2)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 300 times.
resample(uncertainval, constraint, 300)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateRange)
    # Box width
    δ = step(uv.range)

    lower_bound = constraint.min
    upper_bound = constraint.max

    idx_min = findfirst(uv.range .>= lower_bound)
    idx_max = findlast(uv.range .<= upper_bound)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_min:idx_max] |> collect
    wts = Weights(uv.pdf[idx_min:idx_max])

    # Sample a box
    sampled_val = sample(range, wts)

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end


"""
    resample(uv::AbstractUncertainScalarKDE, constraint::TruncateRange, n::Int)

Resample `uv` by first truncating the kernel density estimate of the
distribution furnishing the value at some minimum and maximum values,
then resampling it `n` times.

## Example

```julia
# Uncertain value represented by a normal distribution with mean = 0 and
# standard deviation = 1.
uncertainval = UncertainValue(rand(Normal(0, 1), 1000))

# Only accept values in the range [-0.9, 1.2]
constraint = TruncateRange(-0.9, 1.2)

# Resample the uncertain value by truncating the distribution furnishing it,
# then resampling the new distribution 300 times.
resample(uncertainval, constraint, 300)
```
"""
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateRange, n::Int)
    # Box width
    δ = step(uv.range)

    lower_bound = constraint.min
    upper_bound = constraint.max

    idx_min = findfirst(uv.range .>= lower_bound)
    idx_max = findlast(uv.range .<= upper_bound)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_min:idx_max] |> collect
    wts = Weights(uv.pdf[idx_min:idx_max])

    # Sample n boxes according to estimated pdf
    sampled_vals = Vector{Float64}(undef, n)
    sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end


# Resampling UncertainScalarKDE with TruncateStd is undefined, so fall back to quantiles
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateStd)
    resample(uv, fallback(uv, constraint))
end

# Resampling UncertainScalarKDE with TruncateStd is undefined, so fall back to quantiles
function resample(uv::AbstractUncertainScalarKDE, constraint::TruncateStd, n::Int)
    resample(uv, fallback(uv, constraint), n)
end
