""" 
    CertainScalar

A simple wrapper type for values with no uncertainty (i.e. represented by a scalar).

## Examples 

The two following ways of constructing values without uncertainty are equivalent. 

```julia 
u1, u2 = CertainScalar(2.2), CertainScalar(6)
w1, w2 = UncertainValue(2.2), UncertainValue(6)
```
"""
struct CertainScalar{T} <: AbstractUncertainValue
    value::T
end

Broadcast.broadcastable(x::CertainScalar) = Ref(x.value)

function summarise(uval::CertainScalar)
    _type = typeof(uval)
    val = uval.value
    "$_type($val)"
end
Base.show(io::IO, uval::CertainScalar) = print(io, summarise(uval))

eltype(v::CertainScalar{T}) where {T} = T

Base.size(x::CertainScalar) = ()
Base.size(x::CertainScalar,d) = convert(Int,d)<1 ? throw(BoundsError()) : 1
Base.axes(x::CertainScalar) = ()
Base.axes(x::CertainScalar,d) = convert(Int,d)<1 ? throw(BoundsError()) : Base.OneTo(1)
Base.ndims(x::CertainScalar) = 0
Base.ndims(::Type{<:CertainScalar}) = 0
Base.length(x::CertainScalar) = 1
Base.firstindex(x::CertainScalar) = 1
Base.lastindex(x::CertainScalar) = 1
Base.IteratorSize(::Type{<:CertainScalar}) = Base.HasShape{0}()
Base.keys(::CertainScalar) = Base.OneTo(1)
Base.getindex(x::CertainScalar) = x

function Base.getindex(x::CertainScalar, i::Integer)
    Base.@_inline_meta
    @boundscheck i == 1 || throw(BoundsError())
    x
end
function Base.getindex(x::CertainScalar, I::Integer...)
    Base.@_inline_meta
    @boundscheck all([i == 1 for i in I]) || throw(BoundsError())
    x
end

Base.first(x::CertainScalar) = x
Base.last(x::CertainScalar) = x
Base.copy(x::CertainScalar) = x

Base.minimum(v::CertainScalar) = v.value
Base.maximum(v::CertainScalar) = v.value
Base.isnan(x::CertainScalar) = Base.isnan(x.value)
Base.abs2(x::CertainScalar) = Base.abs2(x.value)

StatsBase.mean(v::CertainScalar) = v.value
StatsBase.median(v::CertainScalar) = v.value
StatsBase.middle(v::CertainScalar) = v.value
StatsBase.quantile(v::CertainScalar, q) = v.value
StatsBase.quantile(v::CertainScalar, q, n::Int) = v.value
StatsBase.std(v::CertainScalar{T}) where {T} = zero(T)

Base.rand(v::CertainScalar) = v.value
Base.rand(v::CertainScalar{T}, n::Int) where T = repeat([v.value], n)

Base.float(v::CertainScalar) = float(v.value)

function Base.:<(x::CertainScalar{T1}, y::CertainScalar{T2}) where {
        T1 <: Real, T2 <: Real} 
    x.value < y.value
end

function IntervalArithmetic.interval(x::CertainScalar{T1}, y::CertainScalar{T2}) where {
        T1 <: Real, T2 <: Real} 
    interval(x.value, y.value)
end 


export
CertainScalar,
UncertainValue