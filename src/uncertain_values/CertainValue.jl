
""" 
    CertainValue

A simple wrapper type for values with no uncertainty (i.e. represented by a scalar).

## Examples 
The two following ways of constructing values without uncertainty are equivalent. 

```julia 
u1, u2 = CertainValue(2.2), CertainValue(6)
```

```julia 
w1, w2 = UncertainValue(2.2), UncertainValue(6)
```
"""
struct CertainValue{T} <: AbstractUncertainValue
    value::T
end

function summarise(uval::CertainValue)
    _type = typeof(uval)
    val = uval.value
    "$_type($val)"
end
Base.show(io::IO, uval::CertainValue) = print(io, summarise(uval))

eltype(v::CertainValue{T}) where {T} = T

Base.size(x::CertainValue) = ()
Base.size(x::CertainValue,d) = convert(Int,d)<1 ? throw(BoundsError()) : 1
Base.axes(x::CertainValue) = ()
Base.axes(x::CertainValue,d) = convert(Int,d)<1 ? throw(BoundsError()) : Base.OneTo(1)
Base.ndims(x::CertainValue) = 0
Base.ndims(::Type{<:CertainValue}) = 0
Base.length(x::CertainValue) = 1
Base.firstindex(x::CertainValue) = 1
Base.lastindex(x::CertainValue) = 1
Base.IteratorSize(::Type{<:CertainValue}) = Base.HasShape{0}()
Base.keys(::CertainValue) = Base.OneTo(1)
Base.getindex(x::CertainValue) = x

function Base.getindex(x::CertainValue, i::Integer)
    Base.@_inline_meta
    @boundscheck i == 1 || throw(BoundsError())
    x
end
function Base.getindex(x::CertainValue, I::Integer...)
    Base.@_inline_meta
    @boundscheck all([i == 1 for i in I]) || throw(BoundsError())
    x
end
Base.first(x::CertainValue) = x
Base.last(x::CertainValue) = x
Base.copy(x::CertainValue) = x

UncertainValue(value::T) where {T <: Real} = CertainValue{T}(value)

StatsBase.mean(v::CertainValue) = v.value
StatsBase.median(v::CertainValue) = v.value
StatsBase.middle(v::CertainValue) = v.value
StatsBase.quantile(v::CertainValue, q) = v.value
StatsBase.std(v::CertainValue{T}) where {T} = zero(T)
Base.minimum(v::CertainValue) = v.value
Base.maximum(v::CertainValue) = v.value

export
CertainValue,
UncertainValue