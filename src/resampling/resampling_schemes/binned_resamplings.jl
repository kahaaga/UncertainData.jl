""" 
    BinnedResampling

Indicates that binned resampling should be performed.

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
resampling = BinnedResampling(grid, n_draws)
```
"""
struct BinnedResampling{B} <: AbstractBinnedUncertainValueResampling
    left_bin_edges::B
    n::Int
end

""" 
    BinnedWeightedResampling

Indicates that binned resampling should be performed, but weighting each
point in the dataset differently.

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
resampling = BinnedWeightedResampling(grid, wts, n_draws)
```
"""
struct BinnedWeightedResampling{B} <: AbstractBinnedUncertainValueResampling
    left_bin_edges::B
    weights
    n::Int
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
BinnedMeanWeightedResampling