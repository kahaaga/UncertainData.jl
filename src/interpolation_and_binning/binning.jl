"""
    bin(left_bin_edges::AbstractRange, xs, ys) -> Vector{Vector{T}} where T
    bin(f::Function, left_bin_edges::AbstractRange, xs, ys, args...; kwargs...) -> Vector{T} where T

Distribute the elements of `ys` into `N-1` different bin vectors, based on 
how the values in `xs` are distributed among the bins defined by the `N` grid 
points in `left_bin_edges`. If `xs[i]` falls in the `n`-th bin interval, then `ys[i]` 
is assigned to the `n`-th bin vector. If `xs[i]` lie outside the grid, then the 
corresponding `ys[i]` is ignored. See also [`bin!`](@ref)

- If no summary function is supplied, return `N - 1` bin vectors.
- If a summary function `f` is supplied as the first argument, apply the summary function 
    element-wise to each of the bin vectors, with `args` and `kwargs` as arguments and 
    keyword arguments. Then, `N-1` summary values, one for each bin, are returned.
    Empty bins are assigned `NaN` values.

## Examples 

### Getting the values in each bin:

```julia
xs = [1.2, 1.7, 2.2, 3.3, 4.5, 4.6, 7.1]
ys = [4.2, 5.1, 6.5, 4.2, 3.2, 3.1, 2.5]
left_bin_edges = 0.0:1.0:6.0
bin(left_bin_edges, xs, ys)
```

### Applying a summary function to each bin

Any function that accepts a vector of values can be used in conjunction with `bin`. 

```julia
xs = [1.2, 1.7, 2.2, 3.3, 4.5, 4.6, 7.1]
ys = [4.2, 5.1, 6.5, 4.2, 3.2, 3.1, 2.5]
left_bin_edges = 0.0:1.0:6.0
bin(median, left_bin_edges, xs, ys)
```

Functions with additional arguments also work (arguments and keyword 
arguments must be supplied last in the function call):

```julia
xs = [1.2, 1.7, 2.2, 3.3, 4.5, 4.6, 7.1]
ys = [4.2, 5.1, 6.5, 4.2, 3.2, 3.1, 2.5]
left_bin_edges = 0.0:1.0:6.0
bin(quantile, left_bin_edges, xs, ys, [0.1])
```
"""
function bin(left_bin_edges::AbstractRange{T}, xs, ys) where T
    if length(xs) != length(ys)
        msg = "`length(xs)` not equal to `length(ys)`"
        throw(ArgumentError(msg))
    end
    
    # Each bin is represented by (potentially differently sized) vectors of type `eltype(ys)`
    YT = eltype(ys)
    n_bins = length(left_bin_edges) - 1    
    bin_vals = [Array{YT}(undef, 0) for i = 1:n_bins]
    
    # Assign values to bins. Can be done faster if `xs` is guaranteed to be ordered.
    g_min = minimum(left_bin_edges)
    g_step = step(left_bin_edges)
    
    for (x, y) in zip(xs, ys)
        arr_idx = ceil(Int, (x - g_min)/g_step)
        # Check that the value falls inside the grid; if not, ignore it
        if 0 < arr_idx <= n_bins
            push!(bin_vals[arr_idx], y)
        end
    end
    
    return bin_vals
end


function bin(f::Function, left_bin_edges::AbstractRange{T}, xs, ys, args...; kwargs...) where T
    if length(xs) != length(ys)
        msg = "`length(xs)` not equal to `length(ys)`"
        throw(ArgumentError(msg))
    end
    
    # Each bin is represented by (potentially differently sized) vectors of type `eltype(ys)`
    YT = eltype(ys)
    n_bins = length(left_bin_edges) - 1    
    bin_vals = [Array{YT}(undef, 0) for i = 1:n_bins]
    
    # Assign values to bins. Can be done faster if `xs` is guaranteed to be ordered.
    g_min = minimum(left_bin_edges)
    g_step = step(left_bin_edges)
    
    for (x, y) in zip(xs, ys)
        arr_idx = ceil(Int, (x - g_min)/g_step)
        # Check that the value falls inside the grid; if not, ignore it
        if 0 < arr_idx <= n_bins
            push!(bin_vals[arr_idx], y)
        end
    end
    
    # Get bin summaries by applying function to non-empty bins.
    bin_summaries = fill(NaN, n_bins)
    inds_nonempty_bins = findall(length.(bin_vals) .> 0)
    bin_summaries[inds_nonempty_bins] = f.(bin_vals[inds_nonempty_bins], args...; kwargs...)
    
    return bin_summaries
end

"""
    bin!(bins, left_bin_edges::AbstractRange, xs, ys)

Distribute the elements of `ys` into `N-1` different pre-allocated empty 
bin vectors, based on how the values in `xs` are distributed among 
the bins defined by the `N` grid points in `left_bin_edges`.
`bins` must be a vector of vector-like mutable containers.

If `xs[i]` falls in the `n`-th bin interval, then `ys[i]` 
is assigned to the `n`-th bin vector. If `xs[i]` lie outside the grid, 
the corresponding `ys[i]` is ignored.

See also [`bin(::AbstractRange)`](@ref).
"""
function bin!(bins, left_bin_edges::AbstractRange{T}, xs, ys) where T
    if length(xs) != length(ys)
        msg = "`length(xs)` not equal to `length(ys)`"
        throw(ArgumentError(msg))
    end
        
    # Each bin is represented by (potentially differently sized) vectors of type `eltype(ys)`
    n_bins = length(left_bin_edges) - 1    
    if length(bins) != n_bins
        msg = "`The number of pre-allocated bins ($n_bins) does not match the number of bins defined by the grid in `left_bin_edges`"
        throw(ArgumentError(msg))
    end

    ELTYPE_YS, ELTYPE_BINS  = eltype(ys), eltype(eltype(bins))
    
    if ELTYPE_BINS != ELTYPE_YS
        msg = "Element type of bin vectors `bins` ($ELTYPE_BINS) is not equal to the element type of `ys` ($ELTYPE_YS)"
    end
        
    # Assign values to bins. Can be done faster if `xs` is guaranteed to be ordered.
    g_min = minimum(left_bin_edges)
    g_step = step(left_bin_edges)
    
    @inbounds for (x, y) in zip(xs, ys)
        arr_idx = ceil(Int, (x - g_min)/g_step)
        # Check that the value falls inside the grid; if not, ignore it
        if 0 < arr_idx <= n_bins
            push!(bins[arr_idx], y)
        end
    end
    
    return bins
end

"""
    bin_mean(left_bin_edges::AbstractRange, xs, ys)

Distribute the elements of `ys` into `N - 1` different bin vectors, based on 
how the values in `xs` are distributed among the bins defined by the `N` grid 
points in `left_bin_edges`. Then compute the bin mean for each bin.

If `xs[i]` falls in the `n`-th bin interval, then `ys[i]` is assigned to the 
`n`-th bin vector. If values fall outside the grid, they are ignored (if 
`xs[i] < minimum(left_bin_edges)`, ignore `ys[i]`). After the `ys` values 
have been assigned to bin vectors, apply the summary function `f` element-wise 
to each of the bin vectors, with `args` and `kwargs` as arguments and keyword 
arguments.

Returns `N - 1` mean values, one for each bin.

## Examples

```julia
xs = [1.2, 1.7, 2.2, 3.3, 4.5, 4.6, 7.1]
ys = [4.2, 5.1, 6.5, 4.2, 3.2, 3.2, 2.5]
left_bin_edges = 0.0:1.0:6.0
bin_mean(left_bin_edges, xs, ys)

# output
6-element Array{Float64,1}:
 NaN   
   4.65
   6.5 
   4.2 
   3.2 
 NaN
```
"""
function bin_mean(left_bin_edges::AbstractRange, xs, ys; nan_threshold = 0)
    if length(xs) != length(ys)
        msg = "`length(xs)` not equal to `length(ys)`"
        throw(ArgumentError(msg))
    end
    
    # Check that the value falls inside the grid; if not, ignore it
    n_bins = length(left_bin_edges) - 1
    bin_sums = fill(0.0, n_bins)
    bin_sums_n_entries = fill(0.0, n_bins)
    
    # Assign values to bins. Can be done faster if `xs` is guaranteed to be ordered.
    g_min = minimum(left_bin_edges)
    g_step = step(left_bin_edges)
    
    for (x, y) in zip(xs, ys)
        arr_idx = ceil(Int, (x - g_min)/g_step)

        if 0 < arr_idx <= n_bins
            bin_sums[arr_idx] += y
            bin_sums_n_entries[arr_idx] += 1.0
        end
    end
    
    # Return bin averages (entries with 0s are represented as NaNs)
    bin_avgs = bin_sums ./ bin_sums_n_entries
    bin_avgs[isapprox.(bin_avgs, 0.0)] .= NaN
    
    # If there aren't enough entries in a bin, set it to NaN
    # and interpolate it instead.
    bin_avgs[bin_sums_n_entries .< nan_threshold] .= NaN
    
    return bin_avgs
end

export bin, bin!, bin_mean