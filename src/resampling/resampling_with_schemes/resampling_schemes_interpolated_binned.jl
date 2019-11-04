"""
    resample(udata::AbstractUncertainIndexValueDataset, regularization_scheme::InterpolateAndBin{Linear})

Draw a single realisation of `udata` and interpolate-and-bin the data according to the 
provided regularization scheme. Assumes points in `udata` are independent and sorts the draw
according to the index values before interpolating. See also [`InterpolateAndBin`](@ref).

## Example 

```julia
npts = 50
y = rand(npts) 

N = Normal(0, 1)

for t in 3:npts
    y[t,1] = 0.7*y[t-1,1] - 0.35*y[t-2,1] + rand(N)
end

# Assume data are unevenly spaced 
time = sample(1.0:npts*5, npts, ordered = true, replace = false)

# Assign some uncertainties to both time indices and values and gather 
# in an UncertainIndexValueDataset
utime = UncertainValue.(Normal.(time, 2))
uy = UncertainValue.(Normal.(y, 0.1))
udata = UncertainIndexValueDataset(utime, uy)

# Interpolation-and-binning scheme. First interpolate to a very fine grid,
# then gather the points falling in each of the coarser bins and summarise 
# each bin using the mean of the points in each bin.
left_bin_edges = 0:10:npts*5
r = InterpolateAndBin(mean, left_bin_edges, Linear(), 0:0.1:1000, Flat(OnGrid()))

# The binned time axis:
time_binned = left_bin_edges[1:end-1] .+ step(left_bin_edges)/2

# Get a set corresponding resampled (interpolated+binned) values
y_binned = resample(udata, r)

# Plot some interpolated+binned draws
time_binned = left_bin_edges[1:end-1] .+ step(left_bin_edges)/2

p = plot(xlabel = "time", ylabel = "value")
for i = 1:100
    plot!(time_binned, resample(udata, r), lw = 0.3, α = 0.2, ms = 0.1, c = :red, 
        marker = stroke(0.1), label = "")
end
plot!(time, y, c = :black, lw = 1, ms = 2, marker = stroke(2.0, :black), label = "")
plot!(udata, c = :black, lw = 1, ms = 2, marker = stroke(0.1, :black), [0.05, 0.95], [0.05, 0.95])
vline!(left_bin_edges, c = :black, α = 0.3, lw = 0.3, label = "")
```
"""
function resample(udata::AbstractUncertainIndexValueDataset, regularization_scheme::InterpolateAndBin{Linear})
    inds, vals = resample(udata)
    
    sortidxs = sortperm(inds)
    
    r = regularization_scheme
    vals_binned = interpolate_and_bin(r.f, r.left_bin_edges, inds[sortidxs], vals[sortidxs], 
        r.intp, r.intp_grid, r.extrapolation_bc)
    
    return vals_binned
end

export resample