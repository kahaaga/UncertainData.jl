"""
    findall_nan_chunks(x)

Finds the `(start, stop)` indices of each `NaN` chunk in `x` and returns a vector 
of index tuples for the `NaN` ranges.

See also: [`findall_nan_chunks!`](@ref)

## Examples 

```julia
x = [NaN, NaN, 2.3, NaN, 5.6, NaN, NaN, NaN]
findall_nan_chunks(x)
```
"""
function findall_nan_chunks(x)
    N = length(x)
    x_isnans = isnan.(x)

    # (start_idx, stop_idx) for each chunk of nans
    nan_chunks = Vector{Tuple{Int, Int}}(undef, 0)
    
    i = 1
    @inbounds while i <= N
        if x_isnans[i] == true
            # Now we know that the Nan range starts at position i           
            j = i
            
            # Update j until there are no more nans
            while j < N && x_isnans[j + 1]
                j += 1
            end
            
            # So now we know the end of the range is at position j            
            push!(nan_chunks, (i, j))
            
            # Update current position based on how many NaNs we found
            i = j + 1
        end
        
        i += 1
    end

    return nan_chunks
end

"""
    findall_nan_chunks!(v, x)

Finds the (start,a stop) indices of each `NaN` chunk in `x` and returns a vector 
of those index tuples, using a preallocated boolean vector `v`, where 
`length(x) == length(v)`, to keep track of `NaN` positions.

See also: [`findall_nan_chunks`](@ref)

## Example 

```julia
x = [NaN, NaN, 2.3, NaN, 5.6, NaN, NaN, NaN]
v = zeros(Bool, length(x))
findall_nan_chunks!(v, x)
```
"""
function findall_nan_chunks!(v::AbstractVector{Bool}, x)
    v .= isnan.(x)

    # (start_idx, stop_idx) for each chunk of nans
    nan_chunks = Vector{Tuple{Int, Int}}(undef, 0)
    
    i = 1
    N = length(x)

    @inbounds while i <= N
        if v[i] == true
            # Now we know that the Nan range starts at position i           
            j = i
            
            # Update j until there are no more nans
            while j < N && v[j + 1]
                j += 1
            end
            
            # So now we know the end of the range is at position j            
            push!(nan_chunks, (i, j))
            
            # Update current position based on how many NaNs we found
            i = j + 1
        end
        
        i += 1
    end

    return nan_chunks
end

export findall_nan_chunks, findall_nan_chunks!