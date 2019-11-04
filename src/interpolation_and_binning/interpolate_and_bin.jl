"""
    interpolate_and_bin(
            left_bin_edges::AbstractRange{T2}, xs, ys, 
            intp::Linear, intp_grid::AbstractRange{T1}, 
             extrapolation_bc::Union{<:Real, Interpolations.BoundaryCondition}
            f::Function, args...; kwargs...) where {T1, T2}

Linearly interpolate the `xs` and `ys` to `intp_grid`, then bin the interpolated data 
on the grid defined by the `N`-element `left_bin_edges` grid. After binning, apply 
`f` with arguments `args` and keyword arguments `kwargs` element-wise to each of the bins. 
Returns a vector of `N-1` bin summaries.

## Details

Binning is performed *after* interpolating `xs` and `ys` to `intp_grid`. Binning is done 
by distributing the `intp_grid` values among the bins defined by `left_bin_edges`. That is, 
if `intp_grid[i]` falls in the `k`-th bin, then `intp(xs)[i]` is assigned to the `k`-th bin. 
If `left_bin_edges` contain `N` grid points, then there will be `N - 1` bins in total. 

If `xs` contain `NaN` values, then these are filled internally by linear interpolation 
*before* interpolating to the provided `intp_grid`. 
"""
function interpolate_and_bin(f::Function, 
            left_bin_edges::AbstractRange{T2}, xs, ys, 
            intp::Linear, intp_grid::AbstractRange{T1}, extrapolation_bc::Union{<:Real, Interpolations.BoundaryCondition},
            args...; kwargs...) where {T1, T2}
    
    if length(xs) != length(ys)
        msg = "`length(xs)` not equal to `length(ys)`"
        throw(ArgumentError(msg))
    end
    
    #= 
    Handle `NaN` values initially present in `xs` by linear interpolation and 
    extrapolating using the provided boundary condition. Only internal `NaN`s are 
    interpolated; if there are `NaN`s present at the edges of `xs` initially, then
    the corresponding `ys` are ignored.
    =# 
    if any(isnan.(xs))
        println("There were `NaN`s in `xs`. Interpolating them by introducing an internal grid in `xs`.")
        xs = fill_nans(xs, Linear())
    end
    
    if any(isnan.(ys))
        println("There were `NaN`s in `ys`. Interpolating them by introducing an internal grid in `ys`.")
        ys = fill_nans(ys, Linear())
    end
    
    isnotnans = findall(isfinite.(xs) .& isfinite.(ys))
    tmp_intp = LinearInterpolation(xs[isnotnans], ys[isnotnans], 
        extrapolation_bc = extrapolation_bc)
        
    # Interpolate `ys` to `intp_grid`
    intp_ys = tmp_intp(intp_grid)
    
    # Each bin is represented by (potentially differently sized) vectors of type `eltype(ys)`
    YT = eltype(intp_ys)
    n_bins = length(left_bin_edges) - 1    
    bin_vals = [Array{YT}(undef, 0) for i = 1:n_bins]
    
    # Assign values to bins. Can be done faster if `xs` is guaranteed to be ordered.
    g_min = minimum(left_bin_edges)
    g_step = step(left_bin_edges)
    
    for (x, y) in zip(intp_grid, intp_ys)
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

export interpolate_and_bin