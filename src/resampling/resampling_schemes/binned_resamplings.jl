import ..UncertainValues: UncertainScalarPopulation, UncertainScalarKDE

"""
    RawValues

Indicates that instead of summarising each bin, vectors of raw values should 
be returned for a binned resampling.
"""
struct RawValues end

const BINREPR = Union{UncertainScalarKDE, UncertainScalarPopulation, RawValues}

""" 
    BinnedResampling(left_bin_edges, n::Int; bin_repr = UncertainScalarKDE)
    BinnedResampling(UncertainScalarKDE, left_bin_edges, n::Int)
    BinnedResampling(UncertainScalarPopulation, left_bin_edges, n::Int)
    BinnedResampling(RawValues, left_bin_edges, n::Int)

Indicates that binned resampling should be performed.

## Fields 

- `left_bin_edges`. The left edgepoints of the bins. Either a range or some 
    custom type which implements `minimum` and `step` methods.
- `n`. The number of draws. Each point in the dataset is sampled `n` times.
    If there are `m` points in the dataset, then the total number of draws 
    is `n*m`.
- `bin_repr`. A type of uncertain value indicating how each bin should be 
    summarised (`UncertainScalarKDE` for kernel density estimated distributions
    in each bin, `UncertainScalarPopulation` to represent values in each bin 
    as an equiprobable population) or not summarise but return raw values 
    falling in each bin (`RawValues`).

## Examples

```julia
using UncertainData

# Resample on a grid from 0 to 200 in steps of 20
grid = 0:20:200

# The number of samples per point in the dataset
n_draws = 10000

# Create the resampling scheme. Use kernel density estimates to distribution 
# in each bin.
resampling = BinnedResampling(grid, n_draws, bin_repr = UncertainScalarKDE)

# Represent each bin as an equiprobably population 
resampling = BinnedResampling(grid, n_draws, bin_repr = UncertainScalarPopulation)

# Keep raw values for each bin (essentially the same as UncertainScalarPopulation,
# but avoids storing an additional vector of weights for the population members).
resampling = BinnedResampling(grid, n_draws, bin_repr = RawValues)
```
"""
Base.@kwdef struct BinnedResampling{R, B} <: AbstractBinnedUncertainValueResampling where {R <: BINREPR, B}
    bin_repr::Type{R} = UncertainScalarKDE
    left_bin_edges::B
    n::Int
end

BinnedResampling(left_bin_edges, n::Int; bin_repr = UncertainScalarKDE) = 
    BinnedResampling(bin_repr, left_bin_edges, n)

function Base.show(io::IO, b::BinnedResampling{R, B}) where {R, B}
    T = typeof(b)
    println(io, "$(T.name){bin_repr: $R, left_bin_edges: $B, n=$(b.n)}")
end

""" 
    BinnedWeightedResampling(left_bin_edges, weights, n::Int; bin_repr = UncertainScalarKDE)
    BinnedResampling(UncertainScalarKDE, left_bin_edges, weights, n::Int)
    BinnedResampling(UncertainScalarPopulation, left_bin_edges, weights, n::Int)
    BinnedResampling(RawValues, left_bin_edges, weights, n::Int)

Indicates that binned resampling should be performed, but weighting each
point in the dataset differently.

## Fields 

- `left_bin_edges`. The left edgepoints of the bins. Either a range or some 
    custom type which implements `minimum` and `step` methods.
- `weights`. The relative probability weights assigned to each point. 
- `n`. The total number of draws. These are distributed among the 
    points of the dataset according to `weights`.
- `bin_repr`. A type of uncertain value indicating how each bin should be 
    summarised (`UncertainScalarKDE` for kernel density estimated distributions
    in each bin, `UncertainScalarPopulation` to represent values in each bin 
    as an equiprobable population) or not summarise but return raw values 
    falling in each bin (`RawValues`).

## Examples

```julia
using UncertainData, StatsBase

# Resample on a grid from 0 to 200 in steps of 20
grid = 0:20:200

# Assume our dataset has 50 points. We'll assign random weights to them.
wts = Weights(rand(50))

# The total number of draws (on average 1000000/50 = 20000 draws per point
# if weights are equal)
n_draws = 10000000

# Create the resampling scheme. Use kernel density estimates to distribution 
# in each bin.
resampling = BinnedWeightedResampling(grid, wts, n_draws, bin_repr = UncertainScalarKDE)

# Represent each bin as an equiprobably population 
resampling = BinnedWeightedResampling(grid, wts, n_draws, bin_repr = UncertainScalarPopulation)

# Keep raw values for each bin (essentially the same as UncertainScalarPopulation,
# but avoids storing an additional vector of weights for the population members).
resampling = BinnedWeightedResampling(grid, wts n_draws, bin_repr = RawValues)
```
"""
Base.@kwdef struct BinnedWeightedResampling{R, B, W} <: AbstractBinnedUncertainValueResampling where {R <: BINREPR, B, W}
    bin_repr::Type{R} = UncertainScalarKDE
    left_bin_edges::B
    weights::W
    n::Int
end

BinnedWeightedResampling(left_bin_edges, weights, n::Int; bin_repr = UncertainScalarKDE) = 
    BinnedWeightedResampling(bin_repr, left_bin_edges, weights, n)

function Base.show(io::IO, b::BinnedWeightedResampling{R, B, W}) where {R, B, W}
    T = typeof(b)
    println(io, "$(T.name){bin_repr: $R, left_bin_edges: $B, weights: $W, n=$(b.n)}")
end

""" 
    BinnedMeanResampling

Binned resampling where each bin is summarised using 
the mean of all draws falling in that bin.

## Fields 

- `left_bin_edges`. The left edgepoints of the bins. Either a range or some 
    custom type which implements `minimum` and `step` methods.
- `n`. The number of draws. Each point in the dataset is sampled `n` times.
    If there are `m` points in the dataset, then the total number of draws 
    is `n*m`.

## Examples

```julia
using UncertainData

# Resample on a grid from 0 to 200 in steps of 20
grid = 0:20:200

# The number of samples per point in the dataset
n_draws = 10000

# Create the resampling scheme
resampling = BinnedMeanResampling(grid, n_draws)
```
"""
struct BinnedMeanResampling{B} <: AbstractBinnedSummarisedResampling
    left_bin_edges::B
    n::Int
end

function Base.show(io::IO, b::BinnedMeanResampling{B}) where {B}
    T = typeof(b)
    println(io, "$(T.name){left_bin_edges=$(b.left_bin_edges), n=$(b.n)}")
end

""" 
    BinnedMeanWeightedResampling

Binned resampling where each bin is summarised using the mean of all draws 
falling in that bin. Points in the dataset are sampled with probabilities
according to `weights`.

## Fields 

- `left_bin_edges`. The left edgepoints of the bins. Either a range or some 
    custom type which implements `minimum` and `step` methods.
- `weights`. The relative probability weights assigned to each point. 
- `n`. The total number of draws. These are distributed among the 
    points of the dataset according to `weights`.

## Examples

```julia
using UncertainData, StatsBase

# Resample on a grid from 0 to 200 in steps of 20
grid = 0:20:200

# Assume our dataset has 50 points. We'll assign random weights to them.
wts = Weights(rand(50))

# The total number of draws (on average 1000000/50 = 20000 draws per point
# if weights are equal)
n_draws = 10000000

# Create the resampling scheme
resampling = BinnedMeanWeightedResampling(grid, wts, n_draws)
```
"""
struct BinnedMeanWeightedResampling{B} <: AbstractBinnedSummarisedResampling
    left_bin_edges::B
    weights
    n::Int
end


export 
BinnedResampling,
BinnedWeightedResampling,
BinnedMeanResampling, 
BinnedMeanWeightedResampling,
RawValues