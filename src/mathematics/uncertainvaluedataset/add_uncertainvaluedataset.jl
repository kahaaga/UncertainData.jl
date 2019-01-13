
""" 
    Base.:+(a::UncertainValueDataset, b::UncertainValueDataset; n = 30000)

Addition operator for two uncertain value datasets. 

To obtain the sum for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th added uncertain value is a kernel density estimate to those sums, i.e.
`added_val = UncertainValue(UnivariateKDE, sample_xᵢ .+ sample_yᵢ)`.
""" 
function Base.:+(a::UncertainValueDataset, b::UncertainValueDataset; n = 30000)
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainValueDataset([a[i] + b[i] for i = 1:N])
end 

""" 
    Base.:+(a::Real, b::UncertainValueDataset;
        n = 30000)

Addition operator for scalars and uncertain value datasets. 

To obtain the sum for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th added uncertain value is a kernel density estimate to those sums, i.e.
`added_val = UncertainValue(UnivariateKDE, sample_xᵢ .+ sample_yᵢ)`.
""" 
function Base.:+(a::T, b::UncertainValueDataset; n = 30000) where {T <: Number}
    N = length(a)
    UncertainValueDataset([a + b[i] for i = 1:N])
end 

""" 
    Base.:+(a::Vector{Real}, b::UncertainValueDataset; n = 30000)

Addition operator for scalars and uncertain value datasets. 

To obtain the sum for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th added uncertain value is a kernel density estimate to those sums, i.e.
`added_val = UncertainValue(UnivariateKDE, sample_xᵢ .+ sample_yᵢ)`.
""" 
function Base.:+(a::Vector{T}, b::UncertainValueDataset; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    UncertainValueDataset([a[i] + b[i] for i = 1:N])
end 

""" 
    Base.:+(a::UncertainValueDataset, b::Real; n = 30000)

Addition scalars to uncertain value datasets. 

To obtain the sum for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th added uncertain value is a kernel density estimate to those sums, i.e.
`added_val = UncertainValue(UnivariateKDE, sample_xᵢ .+ sample_yᵢ)`.
""" 
function Base.:+(a::UncertainValueDataset, b::T; n = 30000) where {T <: Number}
    N = length(a)

    UncertainValueDataset([a[i] + b for i = 1:N])
end 


""" 
    Base.:+(a::UncertainValueDataset, b::Real; n = 30000)

Addition scalars to uncertain value datasets. 

To obtain the sum for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th added uncertain value is a kernel density estimate to those sums, i.e.
`added_val = UncertainValue(UnivariateKDE, sample_xᵢ .+ sample_yᵢ)`.
""" 
function Base.:+(a::UncertainValueDataset, b::Vector{T}; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    
    UncertainValueDataset([a[i] + b[i] for i = 1:N])
end 