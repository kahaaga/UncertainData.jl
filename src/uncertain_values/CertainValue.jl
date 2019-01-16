
""" 
    CertainValue

A simple wrapper type for values with no uncertainty (i.e. represented by a scalar).

## Examples 
```julia 
uval = CertainValue(2)
uval2 = CertainValue(2.2)
```
"""
struct CertainValue{T} <: AbstractUncertainValue
    value::T
end

Broadcast.broadcastable(uval::CertainValue) = Ref(uval)

function summarise(uval::CertainValue)
    _type = typeof(uval)
    val = uval.value
    "$_type($val)"
end
Base.show(io::IO, uval::CertainValue) = print(io, summarise(uval))

eltype(v::CertainValue{T}) where {T} = T

size(x::CertainValue) = ()
size(x::CertainValue,d) = convert(Int,d)<1 ? throw(BoundsError()) : 1
axes(x::CertainValue) = ()
axes(x::CertainValue,d) = convert(Int,d)<1 ? throw(BoundsError()) : OneTo(1)
ndims(x::CertainValue) = 0
ndims(::Type{<:CertainValue}) = 0
length(x::CertainValue) = 1
firstindex(x::CertainValue) = 1
lastindex(x::CertainValue) = 1
IteratorSize(::Type{<:CertainValue}) = HasShape{0}()
keys(::CertainValue) = OneTo(1)
getindex(x::CertainValue) = x
function getindex(x::CertainValue, i::Integer)
    Base.@_inline_meta
    @boundscheck i == 1 || throw(BoundsError())
    x
end
function getindex(x::CertainValue, I::Integer...)
    Base.@_inline_meta
    @boundscheck all([i == 1 for i in I]) || throw(BoundsError())
    x
end
first(x::CertainValue) = x
last(x::CertainValue) = x
copy(x::CertainValue) = x

UncertainValue(value::T) where {T <: Real} = CertainValue{T}(value)

StatsBase.mean(v::CertainValue) = v.value
StatsBase.median(v::CertainValue) = v.value
StatsBase.middle(v::CertainValue) = v.value
StatsBase.quantile(v::CertainValue, q) = v.value
StatsBase.std(v::CertainValue{T}) where {T} = zero(T)
StatsBase.minimum(v::CertainValue) = v.value
StatsBase.maximum(v::CertainValue) = v.value

export
CertainValue,
UncertainValue