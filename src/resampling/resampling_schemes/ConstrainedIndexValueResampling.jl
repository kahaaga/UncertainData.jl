import ..UncertainDatasets: 
    AbstractUncertainIndexValueDataset 

import ..SamplingConstraints: SamplingConstraint
""" 
    ConstrainedIndexValueResampling(constraints::NTuple{N_DATASETS, NTuple{N_VARIABLES, Union{SamplingConstraint, Vector{<:SamplingConstraint}}}}, n::Int)

Indicates that resampling should be performed with constraints on a set of uncertain index-value datasets.
See examples for usage.

## Fields

- `constraints`. The constraints for the datasets. The constraints are represented as a tuple of length 
    `N_DATASETS`, where the `i`-th tuple element is itself a `N_VARIABLES`-length tuple containing the
    constraints for the `N_VARIABLES` different variables. See "Indexing" below for details. 
    Constraints for each individual variable must be supplied as either a single sampling constraint, 
    or as a vector of sampling constraints with length matching the length of the variable 
    (`Union{SamplingConstraint, Vector{<:SamplingConstraint}}}`). For example, if the `j`-th variable 
    for the `i`-th dataset contains 352 observations, then `constraints[i, j]` must be either a single 
    sampling constraint (e.g. `TruncateStd(1.1)`) or a vector of 352 different sampling constraints 
    (e.g. `[TruncateStd(1.0 + rand()) for i = 1:352]`).
- `n::Int`. The number of draws. 

## Indexing

Assume `c` is an instance of `ConstrainedIndexValueResampling`. Then 

- `c[i]` returns the `NTuple` of constraints for the `i`-th dataset, and
- `c[i, j]` returns the constraint(s) for the `j`-th variable of the `i`-th dataset.

## Example 

### Defining `ConstrainedIndexValueResampling`s. 

Assume we want to constraints three separate uncertain index-value datasets, with different 
sampling constraints for the indices and the values for each of the datasets.

```julia 
# (index constraints, value constraints) for the 1st, 2nd and 3rd datasets
c1 = (TruncateStd(1), TruncateStd(1.1))
c2 = (TruncateStd(0.5), TruncateQuantiles(0.1, 0.8))
c3 = (TruncateQuantiles(0.05, 0.95), TruncateQuantiles(0.33, 0.67))
c = ConstrainedIndexValueResampling(c1, c2, c3)
```

Now,

- `c[2]` returns the `NTuple` of constraints for the 2nd dataset, and
- `c[1, 2]` returns the constraint(s) for the 2nd variable of the 1st dataset.

### Controlling the number of draws

The number of draws defaults to 1 if not specified. To indicate that 
more than one draw should be performed, just input the number of draws
before supplying the constraints to the constructor.

```
c1 = (TruncateStd(1), TruncateStd(1.1))
c2 = (TruncateStd(0.5), TruncateQuantiles(0.1, 0.8))

# A single draw
c_single = ConstrainedIndexValueResampling(c1, c2)

# Multiple (300) draws
c_multiple = ConstrainedIndexValueResampling(300, c1, c2) 
```

### Detailed example

Let's say we have two uncertain index-value datasets `x` and `y`. We want to constrain
the furnishing distributions/population for both the time indices and values,
both for `x` and `y`. For `x`, truncate the indices at `0.8` times the standard 
deviation around their mean, and for `y`, trucate the indices at `1.5` times the 
standard deviation around their mean. Next, truncate `x`s values at roughly 
(roughly) at their 20th percentile range, and truncate `y`s values at roughly
their 80th percentile range. 

All this information can be combined in a  `ConstrainedIndexValueResampling` instance.
This instance can be passed on to any function that accepts uncertain index-value datasets,
to indicate that resampling should be performed on truncated versions of the 
distributions/populations furnishing the datasets. 

```julia
# some noise, so we don't truncate all furnishing distributions/population at 
# exactly the same quantiles.
r = Uniform(0, 0.01)

constraints_x_inds = TruncateStd(0.8)
constraints_y_inds = TruncateStd(1.5)
constraints_x_vals = [TruncateQuantiles(0.4 + rand(r), 0.6 + rand(r)) for i = 1:length(x)];
constraints_y_vals = [TruncateQuantiles(0.1 + rand(r), 0.9 + rand(r)) for i = 1:length(x)];

cs_x = (constraints_x_inds, constraints_x_vals)
cs_y = (constraints_y_inds, constraints_y_vals)

resampling = ConstrainedIndexValueResampling(cs_x, cs_y)
```
"""
struct ConstrainedIndexValueResampling{N_VARIABLES, N_DATASETS} <: AbstractUncertainDataResampling where {N_VARIABLES, N_DATASETS}
    constraints::NTuple{N_DATASETS, NTuple{N_VARIABLES, Union{SamplingConstraint, Vector{<:SamplingConstraint}}}}
    n::Int
end

ConstrainedIndexValueResampling(constraints::NTuple{N_VARIABLES, Union{SamplingConstraint, Vector{<:SamplingConstraint}}}...) where N_VARIABLES = 
    ConstrainedIndexValueResampling((constraints...,), 1)

ConstrainedIndexValueResampling(n::Int, constraints::NTuple{N_VARIABLES, Union{SamplingConstraint, Vector{<:SamplingConstraint}}}...) where N_VARIABLES = 
    ConstrainedIndexValueResampling((constraints...,), n)

function Base.show(io::IO, constraints::ConstrainedIndexValueResampling{N_VARIABLES, N_DATASETS}) where {N_VARIABLES, N_DATASETS}
    s = "$(typeof(constraints)) for $N_DATASETS set(s) of index-value constraints (each a $N_VARIABLES-tuple) where n=$(constraints.n)"
    println(io, s)
end

Base.eachindex(c::ConstrainedIndexValueResampling) = Base.OneTo(length(c.constraints))
Base.length(c::ConstrainedIndexValueResampling) = length(c.constraints)
Base.firstindex(c::ConstrainedIndexValueResampling) = 1
Base.lastindex(c::ConstrainedIndexValueResampling) = length(c.constraints)
Base.getindex(c::ConstrainedIndexValueResampling, i) = c.constraints[i]
Base.getindex(c::ConstrainedIndexValueResampling, i, j) = c.constraints[i][j]
Base.iterate(c::ConstrainedIndexValueResampling, state = 1) = iterate(c.constraints, state)

export ConstrainedIndexValueResampling