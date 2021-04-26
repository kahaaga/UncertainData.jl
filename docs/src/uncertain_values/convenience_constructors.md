# Convenience constructors

```@docs
UncertainValue(d::Distributions.Distribution)
UncertainValue(d::Type{D}, empiricaldata::Vector{T}) where {D<:Distribution, T}
UncertainValue(::AbstractVector{<:Real})
UncertainValue(::Vector, ::Vector)
UncertainValue(::Real)
```