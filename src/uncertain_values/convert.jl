convert(::Type{CertainValue}, x::T) where {T <: Number} = CertainValue(x)
convert(::Type{T1}, x::T2) where {T1 <: AbstractUncertainValue, T2 <: Number} = CertainValue(x)
