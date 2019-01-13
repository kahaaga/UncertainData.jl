

function Base.:^(a::UncertainValueDataset, b::UncertainValueDataset; n = 30000)
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainValueDataset([a[i] ^ b[i] for i = 1:N])
end 

function Base.:^(a::T, b::UncertainValueDataset; n = 30000) where {T <: Number}
    N = length(a)
    UncertainValueDataset([a ^ b[i] for i = 1:N])
end 

function Base.:^(a::Vector{T}, b::UncertainValueDataset; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainValueDataset([a[i] ^ b[i] for i = 1:N])
end 

function Base.:^(a::UncertainValueDataset, b::T; n = 30000) where {T <: Number}
    N = length(a)

    UncertainValueDataset([a[i] ^ b for i = 1:N])
end 


function Base.:^(a::UncertainValueDataset, b::Vector{T}; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    
    UncertainValueDataset([a[i] ^ b[i] for i = 1:N])
end 