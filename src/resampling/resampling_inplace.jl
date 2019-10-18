"""
    resample!(v, x)

Resample a uncertain value `x`, or a collection of uncertain values `x`, into a 
pre-allocated container `v`.

## Uncertain values

- If `x` is a single uncertain value, fill `v` with `length(v)` draws of `x`.

## Uncertain collections 

- If `x` is a collection uncertain values and `v` is a vector, fill the `i`-th 
    element of `v` with a draw of the `i`-th uncertain value in `x`.
- If `x` is a collection of uncertain values and `v` is a 2D-array, fill the 
    `i`-th column of `v` with `length(x)` draws of the `i`-th uncertain value
    in `x`.
"""
function resample! end 

function resample!(v, x::AbstractUncertainValue)
    v[:] = rand(x, length(v))
end

function resample!(v::Vector{T}, x::UVAL_COLLECTION_TYPES) where T
    for i in eachindex(v)
        @inbounds v[i] = rand(x[i])
    end
end

function resample!(v::AbstractArray{T, 2}, x::UVAL_COLLECTION_TYPES) where T
    # The i-th column is filled with random values from the ith uncertain 
    # value in the collection.
    n_draws = size(v, 1)
    n_vals = length(x)
    for i in 1:n_vals
        v[:, i] = rand(x[i], n_draws)
    end
end