# Resampling

## Without constraints

Regular resampling is done by drawing random number from the entire probability
distributions furnishing the uncertain values.


## With constraints

The following syntax is used to resample uncertain values.

- `resample(uv::AbstractUncertainValue, constraint::SamplingConstraint)`. Resample the uncertain value once within the restrictions imposed by the sampling constraint.
- `resample(uv::AbstractUncertainValue, constraint::SamplingConstraint, n::Int)`. Resample the uncertain value `n` times within the restrictions imposed by the sampling constraint.

# Sampling constraints
The following sampling constraints are available:

- `TruncateStd(nσ::Int)`. Truncate the distribution furnishing the uncertain data point(s) at n times the standard deviation of the distribution.
- `TruncateMinimum(min<:Number)`. Truncate the distribution furnishing the uncertain data point(s) at some minimum value.
- `TruncateMaximum(max<:Number)`. Truncate the distribution furnishing the uncertain data point(s) at some maximum value.
- `TruncateRange(min<:Number, max<:Number)`. Truncate the distribution furnishing the uncertain data point(s) at some range.
- `TruncateLowerQuantile(lower_quantile::Float64)`. Truncate the distribution furnishing the uncertain data point(s) at some lower quantile of the distribution.
- `TruncateUpperQuantile(upper_quantile::Float64)`. Truncate the distribution furnishing the uncertain data point(s) at some upper quantile of the distribution.
- `TruncateQuantiles(lower_quantile::Float64, upper_quantile::Float64)`. Truncate the distribution furnishing the uncertain data point(s) at a `lower_quantile`
and an `upper_quantile` of the distribution.

## Examples
Let `uv = UncertainValue(Normal, 1, 0.2)`. One may, for example, impose the following sampling constraints:

- `resample(uv, TruncateLowerQuantile(0.2))`. Resamples `uv` 100 times, drawing values strictly larger than the 0.2-th quantile of the distribution furnishing the uncertain data point.
- `resample(uv, TruncateStd(1), 100)`. Resamples `uv` 100 times, drawing values falling within one standard deviation of the distribution furnishing the uncertain value.
- `resample(uv, TruncateRange(-0.5, 1), 100)`. Resamples `uv` 100 times, drawing values from the distribution furnishing the uncertain value within the interval `[-0.5, 1]`.
