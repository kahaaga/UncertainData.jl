

function Base.:^(a::UncertainDataset, b::UncertainDataset; n = 10000)
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainDataset([a[i] ^ b[i] for i = 1:N])
end 

function Base.:^(a::T, b::UncertainDataset; n = 10000) where {T <: Number}
    N = length(a)
    UncertainDataset([a ^ b[i] for i = 1:N])
end 

function Base.:^(a::Vector{T}, b::UncertainDataset; n = 10000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainDataset([a[i] ^ b[i] for i = 1:N])
end 

function Base.:^(a::UncertainDataset, b::T; n = 10000) where {T <: Number}
    N = length(a)

    UncertainDataset([a[i] ^ b for i = 1:N])
end 


function Base.:^(a::UncertainDataset, b::Vector{T}; n = 10000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    
    UncertainDataset([a[i] ^ b[i] for i = 1:N])
end 