"""
    resample!(v::AbstractArray{T, 1}, x::AbstractUncertainValue)
    resample!(v::AbstractArray{T, 1}, x::UVAL_COLLECTION_TYPES) where T
    resample!(v::AbstractArray{T, 2}, x::UVAL_COLLECTION_TYPES) where T
    resample!(idxs::::AbstractArray{T, 1}, vals::AbstractArray{T, 1}, 
        x::AbstractUncertainIndexValueDataset) where T
    resample!(idxs::::AbstractArray{T, 2}, vals::AbstractArray{T, 2}, 
        x::AbstractUncertainIndexValueDataset) where T

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

## Uncertain index-value collections 

- If two mutable vector-like containers, `idxs` and `vals`, are provided along 
    with an uncertain index-value dataset `x`, then fill `idxs[i]` with a 
    random draw from `x.indices[i]` and fill `vals[i]` with a random draw 
    from `x.values[i]`.
- If two mutable matrix-like containers, `idxs` and `vals`, are provided along
    with an uncertain index-value dataset `x` (where the number of 
    columns in both `idxs` and `vals` matches `length(x)`), then fill the 
    `i`-th column of `idxs` with `size(idxs, 1)` draws from `x.indices[i]`,
    and fill the `i`-th column of `vals` with `size(idxs, 1)` draws 
    from `x.values[i]`.
"""
function resample! end 

function resample!(v, x::AbstractUncertainValue)
    v[:] = rand(x, length(v))

    return v
end

function resample!(v, x::UVAL_COLLECTION_TYPES) where T
    for i in eachindex(v)
        @inbounds v[i] = rand(x[i])
    end

    return v
end

function resample!(v::AbstractArray{T, 2}, x::UVAL_COLLECTION_TYPES) where T
    # The i-th column is filled with random values from the ith uncertain 
    # value in the collection.
    n_draws = size(v, 1)
    n_vals = length(x)
    for i in 1:n_vals
        v[:, i] = rand(x[i], n_draws)
    end

    return v
end

function resample!(idxs::Vector{T}, vals::Vector{T}, x::AbstractUncertainIndexValueDataset) where T
    if !(length(idxs) == length(vals) == length(x))
        error("`length(idxs) == length(vals) == length(x)` evaluated to false")
    end
    
    for i in eachindex(idxs)
        @inbounds idxs[i] = rand(x.indices[i])
        @inbounds vals[i] = rand(x.values[i])
    end
    
    return idxs, vals
end

function resample!(idxs::AbstractArray{T, 2}, vals::AbstractArray{T, 2}, x::AbstractUncertainIndexValueDataset) where T
    if !(size(idxs, 2) == size(vals, 2) == length(x))
        error("`length(idxs) == length(vals) == length(x)` evaluated to false")
    end
    n_draws = size(idxs, 1)
    n_uvals = length(x)
    
    # The i-th column in `idxs` is filled with random values from the ith uncertain 
    # index in the collection, and vice versa for `vals`.
    for i in 1:n_uvals
        @inbounds idxs[:, i] = rand(x.indices[i], n_draws)
        @inbounds vals[:, i] = rand(x.values[i], n_draws)
    end
    
    return idxs, vals
end