convert(::Type{CertainScalar}, x::T) where {T <: Number} = CertainScalar(x)
convert(::Type{T1}, x::T2) where {T1 <: AbstractUncertainValue, T2 <: Number} = CertainScalar(x)
