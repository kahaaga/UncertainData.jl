import ..UncertainValues:
    getquantileindex

import StatsBase:
    sample,
    Weights

import Distributions:
    Uniform

"""
    resample(uv::UncertainScalarKDE)

Resample an uncertain value whose distribution is approximated using a
kernel density estimate once.
"""
resample(uv::UncertainScalarKDE) = rand(uv)

"""
    resample(uv::UncertainScalarKDE)

Resample an uncertain value whose distribution is approximated using a
kernel density estimate `n` times.
"""
resample(uv::UncertainScalarKDE, n::Int) = rand(uv, n)


"""
    resample(uv::UncertainScalarKDE, constraint::NoConstraint)

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
resample(uv::UncertainScalarKDE, constraint::NoConstraint) = resample(uv)

"""
    resample(uv::UncertainScalarKDE, constraint::NoConstraint, n::Int)

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
resample(uv::UncertainScalarKDE, constraint::NoConstraint, n::Int) =
    resample(uv, n)


"""
    resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile)

Resample by first truncating the distribution representing the value at a lower
quantile,  then resample one draw from the kernel density estimate of the
distribution furnishing the value.

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
function resample(uv::UncertainScalarKDE, constraint::TruncateLowerQuantile)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:end]
    wts = uv.pdf[idx_lower_quantile:end]
    # Sample a box
    sampled_val = sample(range |> collect, Weights(wts))

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile,
        n::Int = 1000)

Resample by first truncating the distribution representing the value at a lower
quantile, then resample `n` draws from the kernel density estimate of the
distribution furnishing the value.

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
function resample(uv::UncertainScalarKDE, constraint::TruncateLowerQuantile,
        n::Int = 1000)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:end]
    wts = uv.pdf[idx_lower_quantile:end]

    # Sample n boxes according to estimated weights (pdf)
    sampled_vals = Vector{Float64}(undef, n)
    StatsBase.sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end


"""
    resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile)

Resample by first truncating the distribution representing the value at a lower
quantile, then resample one draw from the kernel density estimate of the
distribution furnishing the value.

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
function resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[1:idx_upper_quantile]
    wts = uv.pdf[1:idx_upper_quantile]

    # Sample a box
    sampled_val = sample(range |> collect, Weights(wts))

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end

"""
    resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile,
        n::Int = 1000)

Resample by first truncating the distribution representing the value at a lower
quantile, then resample `n` draws from the kernel density estimate of the
distribution furnishing the value.

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
function resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile,
        n::Int = 1000)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_lower_quantile = getquantileindex(uv, constraint.upper_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[1:idx_upper_quantile]
    wts = uv.pdf[1:idx_upper_quantile]

    # Sample n boxes according to estimated weights (pdf)
    sampled_vals = Vector{Float64}(undef, n)
    StatsBase.sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end



"""
    resample(uv::UncertainScalarKDE, constraint::TruncateUpperQuantile)

Resample by first truncating the distribution at both lower and upper
quantiles, then resample one draw from the kernel density estimate of the
distribution furnishing the value.

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
function resample(uv::UncertainScalarKDE, constraint::TruncateQuantiles)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:idx_upper_quantile]
    wts = uv.pdf[idx_lower_quantile:idx_upper_quantile]

    # Sample a box
    sampled_val = sample(range |> collect, Weights(wts))

    # Sample uniformly from within the box
    rand(Uniform(sampled_val, sampled_val + δ))
end



"""
    resample(uv::UncertainScalarKDE, constraint::TruncateQuantiles,
        n::Int = 1000)

Resample by first truncating the distribution at both lower and upper
quantiles, then resample `n` draws from the kernel density estimate of the
distribution furnishing the value.

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
function resample(uv::UncertainScalarKDE, constraint::TruncateQuantiles,
        n::Int = 1000)
    # Find the index of the kernel density estimated distribution
    # corresponding to the lower quantile at which we want to truncate.
    idx_upper_quantile = getquantileindex(uv, constraint.upper_quantile)
    idx_lower_quantile = getquantileindex(uv, constraint.lower_quantile)

    # Box width
    δ = step(uv.range)

    # Subset the values and weights (values of the pdf at those values)
    range = uv.range[idx_lower_quantile:idx_upper_quantile]
    wts = uv.pdf[idx_lower_quantile:idx_upper_quantile]

    # Sample n boxes according to estimated weights (pdf)
    sampled_vals = Vector{Float64}(undef, n)
    StatsBase.sample!(range, wts, sampled_vals)

    # Sample uniformly from within each box
    [rand(Uniform(sampled_vals[i], sampled_vals[i] + δ)) for i = 1:n]
end
