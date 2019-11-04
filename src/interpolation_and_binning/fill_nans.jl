"""
    fill_nans(x, intp::Linear)

Fill `NaN` values in `x` using linear interpolation. `NaN`s at 
the left or right edges of `x` are not interpolated, but left
as they are. See also [`fill_nans!`](@ref).

## Example 

```julia
x = [NaN, 1.4, 5.6, NaN, 4.3, 3.1, NaN, NaN, 5.6, NaN]
fill_nans(x, Linear())
```
"""
function fill_nans(x, intp::Linear)
    if isnan(x[1]) && isnan(x[end])
        nan_chunks = findall_nan_chunks(x)[2:end-1]
    elseif isnan(x[1])
        nan_chunks = findall_nan_chunks(x)[2:end]
    elseif isnan(x[end])
        nan_chunks = findall_nan_chunks(x)[1:end-1]
    else
        nan_chunks = findall_nan_chunks(x)
    end
    
    x_filled = copy(x)
    
    for (start_idx, stop_idx) in nan_chunks
        x1 = start_idx - 1
        x2 = stop_idx + 1
        
        y1 = x[start_idx - 1]
        y2 = x[stop_idx + 1]

        slope = (y2 - y1) / (x2 - x1)
        
        intcpt = y1 - slope*x1
        
        for (i, idx) in enumerate(start_idx:stop_idx)
            x_filled[idx] = y1 + i*slope
        end
    end
    
    return x_filled
end

"""
    fill_nans!(x, intp::Linear)

Fill `NaN` values in `x` in-place using linear interpolation. `NaN`s at 
the left or right edges of `x` are not interpolated, but left
as they are. See also [`fill_nans`](@ref).

## Example 

```julia
x = [NaN, 1.4, 5.6, NaN, 4.3, 3.1, NaN, NaN, 5.6, NaN]
fill_nans!(x, Linear())
```
"""
function fill_nans!(x, intp::Linear)
    if isnan(x[1]) && isnan(x[end])
        nan_chunks = findall_nan_chunks(x)[2:end-1]
    elseif isnan(x[1])
        nan_chunks = findall_nan_chunks(x)[2:end]
    elseif isnan(x[end])
        nan_chunks = findall_nan_chunks(x)[1:end-1]
    else
        nan_chunks = findall_nan_chunks(x)
    end
        
    for (start_idx, stop_idx) in nan_chunks
        x1 = start_idx - 1
        x2 = stop_idx + 1
        
        y1 = x[start_idx - 1]
        y2 = x[stop_idx + 1]

        slope = (y2 - y1) / (x2 - x1)
        
        intcpt = y1 - slope*x1
        
        for (i, idx) in enumerate(start_idx:stop_idx)
            x[idx] = y1 + i*slope
        end
    end
    
    return x
end


export fill_nans, fill_nans!