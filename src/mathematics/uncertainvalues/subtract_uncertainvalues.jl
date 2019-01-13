import ..UncertainValues: 
    AbstractUncertainValue
import ..Resampling:
    resample

#############
# Subtraction
#############

"""
    Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue) -> UncertainValue

Subtraction operator for pairs of uncertain values. 
    
Computes the element-wise differences between for a default of `n = 30000` realizations of `a` and 
`b`, then returns an uncertain value based on a kernel density estimate to the distribution 
of the element-wise differences.

Use the `-(a, b, n)` syntax to tune the number (`n`) of draws.
"""
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000)
    UncertainValue(resample(a, n) .- resample(b, n))
end

"""
    Base.:-(a::Real, b::AbstractUncertainValue) -> UncertainValue

Subtraction operator for between scalars and uncertain values. 

Computes the element-wise differences between `a` and `b` for a default of `n = 30000` realizations
of `b`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise differences.
    
Use the `-(a, b, n)` syntax to tune the number (`n`) of draws.
"""
Base.:-(a::Real, b::AbstractUncertainValue; n::Int = 30000) = 
    UncertainValue(a .- resample(b, n))

"""
    Base.:-(a::AbstractUncertainValue, b::Real) -> UncertainValue

Subtraction operator for between uncertain values and scalars. 

Computes the element-wise differences between `a` and `b` for a default of `n = 30000` realizations
of `a`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise differences.
    
Use the `-(a, b, n)` syntax to tune the number (`n`) of draws.
"""
Base.:-(a::AbstractUncertainValue, b::Real; n::Int = 30000) = 
    UncertainValue(resample(a, n) .- b)

"""
    Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int) -> UncertainValue

Subtraction operator for pairs of uncertain values. 

Computes the element-wise differences between `a` and `b` for `n` realizations
of `a` and `b`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise differences.

Call this function using the `-(a, b, n)` syntax.
"""
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    UncertainValue(resample(a, n) .- resample(b, n))
end
"""
    Base.:-(a::Real, b::AbstractUncertainValue, n::Int) -> UncertainValue

Subtraction operator for scalar-uncertain value pairs. 

Computes the element-wise differences between `a` and `b` for `n` realizations
of `b`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise differences.

Call this function using the `-(a, b, n)` syntax.
"""
Base.:-(a::Real, b::AbstractUncertainValue, n::Int) = 
    UncertainValue(a .- resample(b, n))

"""
    Base.:-(a::AbstractUncertainValue, b::Real, n::Int) -> UncertainValue

Subtraction operator for scalar-uncertain value pairs. 

Computes the element-wise differences between `a` and `b` for `n` realizations
of `a`, then returns an uncertain value based on a kernel density estimate to the 
distribution of the element-wise differences.

Call this function using the `-(a, b, n)` syntax.
"""
Base.:-(a::AbstractUncertainValue, b::Real, n::Int) = 
    UncertainValue(resample(a, n) .- b)

