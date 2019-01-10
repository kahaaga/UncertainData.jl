import ..UncertainValues: 
    AbstractUncertainValue
import ..Resampling:
    resample

##########
# Addition 
##########

# Specifying the number of draws.
function Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .+ resample(b, n)
end
Base.:+(a::Real, b::AbstractUncertainValue, n::Int) = a .+ resample(b, n)
Base.:+(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .+ b

# Using the default number of draws (n = 10000) 
function Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .+ resample(b, 10000)
end
Base.:+(a::Real, b::AbstractUncertainValue) = a .+ resample(b, 10000)
Base.:+(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .+ b


#############
# Subtraction 
#############

# Specifying the number of draws.
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .- resample(b, n)
end
Base.:-(a::Real, b::AbstractUncertainValue, n::Int) = a .- resample(b, n)
Base.:-(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .- b
Base.:-(a::AbstractUncertainValue, n::Int) = -(resample(a, n))

# Using the default number of draws (n = 10000) 
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .- resample(b, 10000)
end
Base.:-(a::Real, b::AbstractUncertainValue) = a .- resample(b, 10000)
Base.:-(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .- b
Base.:-(a::AbstractUncertainValue) = -(resample(a, 10000))


################
# Multiplication
################

# Specifying the number of draws.
function Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
    resample(a, n) .* resample(b, n)
end
Base.:*(a::Real, b::AbstractUncertainValue, n::Int) = a .* resample(b, n)
Base.:*(a::AbstractUncertainValue, b::Real, n::Int) = resample(a, n) .* b

# Using the default number of draws (n = 10000) 
function Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue)
    resample(a, 10000) .* resample(b, 10000)
end
Base.:*(a::Real, b::AbstractUncertainValue) = a .* resample(b, 10000)
Base.:*(a::AbstractUncertainValue, b::Real) = resample(a, 10000) .* b


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
