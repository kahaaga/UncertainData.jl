import Interpolations.BoundaryCondition

"""
    InterpolateAndBin{L}(f::Function, left_bin_edges, intp::L, intp_grid
        extrapolation_bc::Union{<:Real, Interpolations.BoundaryCondition})

Indicates that a dataset consisting of both indices and values should first
be interpolated to the `intp_grid` grid using the provided `intp` scheme 
(e.g. `Linear()`). After interpolating, assign the interpolated values 
to the bins defined by `left_bin_edges` and summarise the values falling
in each bin using the summary function `f` (e.g. `mean`).
 
## Example 

```julia
using UncertainData, Interpolations, StatsBase

# Assume we have the following unevenly spaced data with some `NaN` values
T = 100
time = sample(1.0:T*5, T, ordered = true, replace = false)
y1 = rand(T)
time[rand(1:T, 10)] .= NaN 
y1[rand(1:T, 10)] .= NaN 

# We want to first intepolate the dataset linearly to a regular time grid 
# with steps of `0.1` time units.
intp = Linear()
intp_grid = 0:0.1:1000
extrapolation_bc = Flat(OnGrid())

# Then, bin the dataset in time bins `50` time units wide, collect all 
# values in each bin and summarise them using `f`.
f = mean
left_bin_edges = 0:50:1000

r = InterpolateBin(f, left_bin_edges, intp, intp_grid, extrapolation_bc)
````
"""
struct InterpolateAndBin{L}
    f::Function
    left_bin_edges
    intp::L # Linear
    intp_grid
    extrapolation_bc::Union{<:Real, Interpolations.BoundaryCondition}
end