import StaticArrays: FieldVector, MVector 

"""
    resample!(v::AbstractArray{T, 1}, x::AbstractUncertainValue)
    resample!(v::MVector{N, T}, x::AbstractUncertainValue) where {N, T}
    resample!(v::FieldVector{N, T}, x::AbstractUncertainValue) where {N, T}

    resample!(v::MVector{N, T}, x::Vararg{AbstractUncertainValue, N}) where {N, T}
    resample!(v::FieldVector{N, T}, x::Vararg{AbstractUncertainValue, N}) where {N, T}

    resample!(v::AbstractArray{T, 1}, x::UVAL_COLLECTION_TYPES) where T
    resample!(v::AbstractArray{T, 2}, x::UVAL_COLLECTION_TYPES) where T

    resample!(idxs::AbstractArray{T, 1}, vals::AbstractArray{T, 1}, 
        x::AbstractUncertainIndexValueDataset) where T
    resample!(idxs::AbstractArray{T, 2}, vals::AbstractArray{T, 2}, 
        x::AbstractUncertainIndexValueDataset) where T

Resample a uncertain value `x`, or a collection of uncertain values `x`, into a 
pre-allocated container `v`.

## Uncertain values

- If `x` is a single uncertain value, and `v` is vector-like, then fill 
    `v` with `N` draws of `x`. Works with vectors of length `N`, 
    `MVector{N, T}`s or `FieldVector{N, T}`s. 

## Uncertain collections 

Uncertain collections may be a `Vector{AbstractUncertainValue}` of length `N`, 
an  `AbstractUncertainValueDataset`, or an `NTuple{N, AbstractUncertainValue}`.
See also [`UVAL_COLLECTION_TYPES`](@ref).

- If `x` is a collection of uncertain values and `v` is vector-like, then 
    fill `v[i]` with a draw of `x[i]` for `i = 1:N`. 
- If `x` is a collection of uncertain values and `v` is a 2D-array, then 
    fill the `i`-th column of `v` with `length(x)` draws of the `i`-th 
    uncertain value in `x`.

## Uncertain index-value collections 

- If two mutable vector-like containers, `idxs` and `vals`, are provided along 
    with an uncertain index-value dataset `x`, then fill `idxs[i]` with a 
    random draw from `x.indices[i]` and fill `vals[i]` with a random draw 
    from `x.values[i]`.
- If two mutable matrix-like containers, `idxs` and `vals` are provided along
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

function resample!(idxs::Vector{T}, vals::Vector{T}, 
        x::AbstractUncertainIndexValueDataset) where T
    
    if !(length(idxs) == length(vals) == length(x))
        error("`length(idxs) == length(vals) == length(x)` evaluated to false")
    end
    
    for i in eachindex(idxs)
        @inbounds idxs[i] = rand(x.indices[i])
        @inbounds vals[i] = rand(x.values[i])
    end
    
    return idxs, vals
end

function resample!(idxs::AbstractArray{T, 2}, vals::AbstractArray{T, 2}, 
        x::AbstractUncertainIndexValueDataset) where T
    
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

#################################################################################
# Multiple draws of a single uncertain value into mutable vector-like containers. 
#################################################################################
function resample!(v::MVector{N, T}, x::AbstractUncertainValue) where {N, T}
    v[:] = resample(x, N)
    
    return v
end

function resample!(v::FieldVector{N, T}, x::AbstractUncertainValue) where {N, T}
    v[:] = resample(x, N)
    
    return v
end


##########################################################################################
# A single draw of `N` uncertain values into a length-`N` a mutable vector-like container.
##########################################################################################
function resample!(v::MVector{N, T}, x::Vararg{AbstractUncertainValue, N}) where {N, T}
    @inbounds for i = 1:N
        v[i] = resample(x[i])
    end
    
    return v
end
function resample!(v::MVector{N, T}, x::NTuple{N, AbstractUncertainValue}) where {N, T}
    for i = 1:N
        @inbounds v[i] = resample(x[i])
    end
    
    return v
end

function resample!(v::FieldVector{N, T}, x::Vararg{AbstractUncertainValue, N}) where {N, T}
    @inbounds for i = 1:N
        v[i] = resample(x[i])
    end
    
    return v
end

function resample!(v::FieldVector{N, T}, x::NTuple{N, AbstractUncertainValue}) where {N, T}
    for i = 1:N
        @inbounds v[i] = resample(x[i])
    end
    
    return v
end
