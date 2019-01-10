import ..UncertainValues: 
    AbstractUncertainValue
import ..Resampling:
    resample

##########
# Addition 
##########

# Specifying the number of draws.


# Using the default number of draws (n = 10000) 

"""
    Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue)

Addition operator for pairs of uncertain values. Computes the element-wise 
sum for 10000 realizations.
"""
function Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .+ resample(b, 10000)
end

"""
    Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue)

Addition operator for between scalars and uncertain values. Computes the 
element-wise sum for 10000 realizations.
"""
Base.:+(a::Real, b::AbstractUncertainValue) = a .+ resample(b, 10000)

"""
    Base.:+(a::AbstractUncertainValue, b::Real)

Addition operator for between scalars and uncertain values. Computes the 
element-wise sum for 10000 realizations.
"""
Base.:+(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .+ b

"""
    Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)

Addition operator for pairs of uncertain values. Computes the 
element-wise sum for `n` realizations.
"""
function Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .+ resample(b, n)
end
"""
    Base.:+(a::Real, b::AbstractUncertainValue, n::Int)

Addition operator for scalar-uncertain value pairs. Computes the 
element-wise sum for `n` realizations.
"""
Base.:+(a::Real, b::AbstractUncertainValue, n::Int) = a .+ resample(b, n)

"""
    Base.:+(a::AbstractUncertainValue, b::Real, n::Int)

Addition operator for scalar-uncertain value pairs. Computes the 
element-wise sum for `n` realizations.
"""
Base.:+(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .+ b


#############
# Subtraction 
#############

# Specifying the number of draws.

"""
    Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)

Subtraction operator for pairs of uncertain values. Computes the 
element-wise difference for `n` realizations.
"""
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .- resample(b, n)
end

"""
    Base.:-(a::Real, b::AbstractUncertainValue, n::Int)

Subtraction operator for scalar-uncertain value pairs. Computes the 
element-wise difference for `n` realizations.
"""
Base.:-(a::Real, b::AbstractUncertainValue, n::Int) = a .- resample(b, n)

"""
    Base.:-(a::AbstractUncertainValue, b::Real, n::Int)

Subtraction operator for scalar-uncertain value pairs. Computes the 
element-wise difference for `n` realizations.
"""
Base.:-(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .- b

Base.:-(a::AbstractUncertainValue, n::Int) = -(resample(a, n))

# Using the default number of draws (n = 10000) 


"""
    Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue)

Subtraction operator for pairs of uncertain values. Computes the 
element-wise difference for 10000 realizations.
"""
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .- resample(b, 10000)
end

"""
    Base.:-(a::Real, b::AbstractUncertainValue)

Subtraction operator for scalar-uncertain value pairs. Computes the 
element-wise difference for 10000 realizations.
"""
Base.:-(a::Real, b::AbstractUncertainValue) = a .- resample(b, 10000)

"""
    Base.:-(a::AbstractUncertainValue, b::Real)

Subtraction operator for scalar-uncertain value pairs. Computes the 
element-wise difference for 10000 realizations.
"""
Base.:-(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .- b
Base.:-(a::AbstractUncertainValue) = -(resample(a, 10000))


################
# Multiplication
################

# Specifying the number of draws.
"""
    Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)

Multiplication operator for pairs of uncertain values. Computes the 
element-wise product for `n` realizations.
"""
function Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .* resample(b, n)
end

"""
    Base.:*(a::Real, b::AbstractUncertainValue, n::Int)

Multiplication operator for scalar-uncertain value pairs. Computes the 
element-wise product for `n` realizations.
"""
Base.:*(a::Real, b::AbstractUncertainValue, n::Int) = a .* resample(b, n)

"""
    Base.:*(a::AbstractUncertainValue, b::Real, n::Int)

Multiplication operator for scalar-uncertain value pairs. Computes the 
element-wise product for `n` realizations.
"""
Base.:*(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .* b

# Using the default number of draws (n = 10000) 
"""
    Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue)

Multiplication operator for pairs of uncertain values. Computes the 
element-wise product for 10000 realizations.
"""
function Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .* resample(b, 10000)
end

"""
    Base.:*(a::Real, b::AbstractUncertainValue)

Multiplication operator for scalar-uncertain value pairs. Computes the 
element-wise product for 10000 realizations.
"""
Base.:*(a::Real, b::AbstractUncertainValue) = a .* resample(b, 10000)

"""
    Base.:*(a::AbstractUncertainValue, b::Real)

Multiplication operator for scalar-uncertain value pairs. Computes the 
element-wise product for 10000 realizations.
"""
Base.:*(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .* b


################
# Division
################

# Specifying the number of draws.
"""
    Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)

Division operator for pairs of uncertain values. Computes the 
element-wise quotient for `n` realizations.
"""
function Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) ./ resample(b, n)
end

"""
    Base.:/(a::Real, b::AbstractUncertainValue, n::Int)

Division operator for scalar-uncertain value pairs. Computes the 
element-wise quotient for `n` realizations.
"""
Base.:/(a::Real, b::AbstractUncertainValue, n::Int) = a ./ resample(b, n)

"""
    Base.:/(a::AbstractUncertainValue, b::Real, n::Int)

Division operator for scalar-uncertain value pairs. Computes the 
element-wise quotient for `n` realizations.
"""
Base.:/(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) ./ b

# Using the default number of draws (n = 10000) 
"""
    Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue)

Division operator for pairs of uncertain values. Computes the 
element-wise quotient for 10000 realizations.
"""
function Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) ./ resample(b, 10000)
end

"""
    Base.:/(a::Real, b::AbstractUncertainValue)

Division operator for scalar-uncertain value pairs. Computes the 
element-wise quotient for 10000 realizations.
"""
Base.:/(a::Real, b::AbstractUncertainValue) = a ./ resample(b, 10000)

"""
    Base.:/(a::AbstractUncertainValue, b::Real)

Division operator for scalar-uncertain value pairs. Computes the 
element-wise quotient for 10000 realizations.
"""
Base.:/(a::AbstractUncertainValue, b::Real) = resample(a, 10000) ./ b


################
# Exponentiation
################

# Specifying the number of draws.
function Base.:^(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .^ resample(b, n)
end
Base.:^(a::Real, b::AbstractUncertainValue, n::Int) = a .^ resample(b, n)
Base.:^(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .^ b

# Using the default number of draws (n = 10000) 
function Base.:^(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .^ resample(b, 10000)
end
Base.:^(a::Real, b::AbstractUncertainValue) = a .^ resample(b, 10000)
Base.:^(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .^ b
