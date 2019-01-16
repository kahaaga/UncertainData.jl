
################
# Exponentiation
################

"""
    Base.:^(a::AbstractUncertainValue, b::AbstractUncertainValue) -> UncertainValue

Exponentiation operator for pairs of uncertain values. 
    
The operator first computes a default of `n = 10000` realizations of both `a` and `b`,
which gives `10000` base-exponent pairs. Then, it exponentiates element-wise over these 
base-exponent pairs, and finally returns an uncertain value based on a kernel density 
estimate to the distribution of numbers resulting from the exponentiation operations.

Use the `^(a, b, n)` syntax to tune the number (`n`) of draws.
"""
function Base.:^(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000)
    UncertainValue(resample(a, n) .^ resample(b, n))
end

"""
    Base.:^(a::Real, b::AbstractUncertainValue) -> UncertainValue

Exponentiation operator for between scalars and uncertain values. 

The operator first computes a default of `n = 10000` realizations of `b`, which are used 
as exponents. Then, it makes `10000` base-exponent pairs, where the base is always `a` and 
the exponents are the exponents generated from `b`. Next, it exponentiates element-wise 
over these base-exponent pairs, and finally returns an uncertain value based on a kernel 
density estimate to the distribution of numbers resulting from the exponentiation operations.
    
Use the `^(a, b, n)` syntax to tune the number (`n`) of draws.
"""
Base.:^(a::Real, b::AbstractUncertainValue; n::Int = 30000) = 
    UncertainValue(a .^ resample(b, n))

"""
    Base.:^(a::AbstractUncertainValue, b::Real) -> UncertainValue

Exponentiation operator for between uncertain values and scalars. 

The operator first computes a default of `n = 10000` realizations of `a`, which are used 
as exponents. Then, it makes `10000` base-exponent pairs, where the base is always `b` and 
the exponents are the exponents generated from `a`. Next, it exponentiates element-wise 
over these base-exponent pairs, and finally returns an uncertain value based on a kernel 
density estimate to the distribution of numbers resulting from the exponentiation operations.
        
Use the `^(a, b, n)` syntax to tune the number (`n`) of draws.
"""
Base.:^(a::AbstractUncertainValue, b::Real; n::Int = 30000) = 
    UncertainValue(resample(a, n) .^ b)

"""
    Base.:^(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int) -> UncertainValue

Exponentiation operator for pairs of uncertain values. 
    
The operator first computes `n` realizations of both `a` and `b`,
which gives `n` base-exponent pairs. Then, it exponentiates element-wise over these 
base-exponent pairs, and finally returns an uncertain value based on a kernel density 
estimate to the distribution of numbers resulting from the exponentiation operations.

Call this function using the `^(a, b, n)` syntax.
"""
function Base.:^(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    UncertainValue(resample(a, n) .^ resample(b, n))
end

""" 
    Base.:^(a::Real, b::AbstractUncertainValue, n::Int) -> UncertainValue

Exponentiation operator for between scalars and uncertain values. 

The operator first computes `n = 10000` realizations of `b`, which are used 
as exponents. Then, it makes `n` base-exponent pairs, where the base is always `a` and 
the exponents are the exponents generated from `b`. Next, it exponentiates element-wise 
over these base-exponent pairs, and finally returns an uncertain value based on a kernel 
density estimate to the distribution of numbers resulting from the exponentiation operations.
    
Call this function using the `^(a, b, n)` syntax.
"""
Base.:^(a::Real, b::AbstractUncertainValue, n::Int) = 
    UncertainValue(a .^ resample(b, n))

""" 
    Base.:^(a::AbstractUncertainValue, b::Real, n::Int) -> UncertainValue

Exponentiation operator for between scalars and uncertain values. 

The operator first computes `n = 10000` realizations of `a`, which are used 
as exponents. Then, it makes `n` base-exponent pairs, where the base is always `b` and 
the exponents are the exponents generated from `a`. Next, it exponentiates element-wise 
over these base-exponent pairs, and finally returns an uncertain value based on a kernel 
density estimate to the distribution of numbers resulting from the exponentiation operations.
    
Call this function using the `^(a, b, n)` syntax.
"""
Base.:^(a::AbstractUncertainValue, b::Real, n::Int) = 
    UncertainValue(resample(a, n) .^ b)



#####################################################################################
# Special cases 
#####################################################################################

import ..UncertainValues: CertainValue

##################
# `CertainValue`s
#################
"""
    Base.:^(a::Union{CertainValue, Real}, b::Union{CertainValue, Real})

Exponentiation of certain values with themselves or scalars acts as regular exponentiation, 
but returns the result wrapped in a `CertainValue` instance.
"""
Base.:^(a::Union{CertainValue, Real}, b::Union{CertainValue, Real}) 

Base.:^(a::CertainValue, b::CertainValue) = CertainValue(a.value ^ b.value)
Base.:^(a::CertainValue, b::Real) = CertainValue(a.value ^ b)
Base.:^(a::Real, b::CertainValue) = CertainValue(a ^ b.value)

