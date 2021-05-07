
# Sampling constraints

```@docs
constrain(uv::AbstractUncertainValue, constraint::SamplingConstraint)
```

## Element-wise constraints

The following sampling constraints are aimed to be used element-wise on uncertain values.

```@docs
TruncateStd
TruncateMinimum
TruncateMaximum
TruncateRange
TruncateLowerQuantile
TruncateUpperQuantile
TruncateQuantiles
```


### Examples

```@example constraint_theoretical
using UncertainData, Distributions, Plots

# Define an uncertain value furnished by a theoretical distribution
x = UncertainValue(Normal, 1, 0.5)

# Constrain the support of the furnishing distribution using various
# constraints
xc_lq = constrain(x, TruncateLowerQuantile(0.2))
xc_uq = constrain(x, TruncateUpperQuantile(0.8))
xc_q = constrain(x, TruncateQuantiles(0.2, 0.8))
xc_min = constrain(x, TruncateMinimum(0.5))
xc_max = constrain(x, TruncateMaximum(1.5))
xc_range = constrain(x, TruncateRange(0.5, 1.5))

p_lq = plot(x, label = ""); plot!(xc_lq, label = "TruncateLowerQuantile(0.2)")
p_uq = plot(x, label = ""); plot!(xc_uq, label = "TruncateLowerQuantile(0.8)")
p_q = plot(x, label = ""); plot!(xc_q, label = "TruncateQuantiles(0.2, 0.8)")
p_min = plot(x, label = ""); plot!(xc_min, label = "TruncateMinimum(0.5)")
p_max = plot(x, label = ""); plot!(xc_max, label = "TruncateMaximum(1.5)")
p_range = plot(x, label = ""); plot!(xc_range, label = "TruncateRange(0.5, 1.5)")
plot(p_min, p_max, p_range,
    p_q, p_lq, p_uq, 
    size = (750, 500), legendfont = font(7), xlabel = "Value", ylabel = "Density",
    legend = :topright, fg_legend = :transparent, bg_legend = :transparent
)
```

## Dataset (sequential) constraints

Sequential constraints are used when sampling [`UncertainIndexDataset`](@ref)s or 
[`UncertainIndexValueDataset`](@ref)s.

```@docs
StrictlyIncreasing
StrictlyDecreasing
```

### Sampling algorithms

```@docs
StartToEnd
```

### Utils

```@docs
sequence_exists
```
