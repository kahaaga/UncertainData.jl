
""" 
    Base.:-(a::UncertainIndexDataset, b::UncertainIndexDataset;
        n = 30000)

Subtraction operator for uncertain value datasets. 

To obtain the difference for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th subtracted uncertain value is a kernel density estimate to those differences, i.e.
`subt_val = UncertainValue(UnivariateKDE, sample_xᵢ .- sample_yᵢ)`.
""" 
function Base.:-(a::UncertainIndexDataset, b::UncertainIndexDataset; n = 30000)
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Dataset lengths do not match ($N, $n_vals_b)"))
    end

    sum_dists = [resample(a[i], n) .- resample(b[i], n) for i = 1:N]
    UncertainIndexDataset([UncertainValue(sum_dists[i]) for i = 1:N])
end 

""" 
    Base.:-(a::Real, b::UncertainIndexDataset;
        n = 30000)

Subtraction operator for scalars and uncertain value datasets. 

To obtain the difference for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th subtracted uncertain value is a kernel density estimate to those differences, i.e.
`subt_val = UncertainValue(UnivariateKDE, sample_xᵢ .- sample_yᵢ)`.
""" 
function Base.:-(a::T, b::UncertainIndexDataset; n = 30000) where {T <: Number}
    N = length(a)

    UncertainIndexDataset([UncertainValue(a .- resample(b[i], n)) for i = 1:N])
end 

""" 
    Base.:-(a::Vector{Real}, b::UncertainIndexDataset;
        n = 30000)

Subtraction operator for scalars and uncertain value datasets. 

To obtain the difference for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th subtracted uncertain value is a kernel density estimate to those differences, i.e.
`subt_val = UncertainValue(UnivariateKDE, sample_xᵢ .- sample_yᵢ)`.
""" 
function Base.:-(a::Vector{T}, b::UncertainIndexDataset; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Lengths do not match ($N, $n_vals_b)"))
    end

    UncertainIndexDataset([UncertainValue(a[i] .- resample(b[i], n)) for i = 1:N])
end 

""" 
    Base.:-(a::UncertainIndexDataset, b::Real;
        n = 30000)

Subtraction operator for scalars and uncertain value datasets. 

To obtain the difference for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th subtracted uncertain value is a kernel density estimate to those differences, i.e.
`subt_val = UncertainValue(UnivariateKDE, sample_xᵢ .- sample_yᵢ)`.
""" 
function Base.:-(a::UncertainIndexDataset, b::T; n = 30000) where {T <: Number}
    N = length(a)

    UncertainIndexDataset([UncertainValue(resample(a[i], n) .- b) for i = 1:N])
end 

""" 
    Base.:-(a::UncertainIndexDataset, b::Real;
        n = 30000)

Subtraction operator for scalars and uncertain value datasets. 

To obtain the difference for a pair of uncertain values `(xᵢ ∈ a, yᵢ ∈ b)`, both `u₁` and `u₂` are 
resampled `n` times each, so `sample_xᵢ = resample(x, n)` and `sample_yᵢ = resample(y, n)`.

The i-th subtracted uncertain value is a kernel density estimate to those differences, i.e.
`subt_val = UncertainValue(UnivariateKDE, sample_xᵢ .- sample_yᵢ)`.
""" 
function Base.:-(a::UncertainIndexDataset, b::Vector{T}; n = 30000) where {T <: Number}
    N = length(a)
    n_vals_b = length(b) 

    if N != n_vals_b 
        throw(ArgumentError("Lengths do not match ($N, $n_vals_b)"))
    end

    UncertainIndexDataset([UncertainValue(resample(a[i], n) .- b[i]) for i = 1:N])
end 



