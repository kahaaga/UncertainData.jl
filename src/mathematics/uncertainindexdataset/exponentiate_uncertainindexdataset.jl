

function Base.:^(a::UncertainIndexDataset, b::UncertainIndexDataset; n = 30000)
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainIndexDataset([a[i] ^ b[i] for i = 1:N])
end 

function Base.:^(a::T, b::UncertainIndexDataset; n = 30000) where {T <: Number}
    N = length(a)
    UncertainIndexDataset([a ^ b[i] for i = 1:N])
end 

function Base.:^(a::Vector{T}, b::UncertainIndexDataset; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainIndexDataset([a[i] ^ b[i] for i = 1:N])
end 

function Base.:^(a::UncertainIndexDataset, b::T; n = 30000) where {T <: Number}
    N = length(a)

    UncertainIndexDataset([a[i] ^ b for i = 1:N])
end 


function Base.:^(a::UncertainIndexDataset, b::Vector{T}; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    
    UncertainIndexDataset([a[i] ^ b[i] for i = 1:N])
end 