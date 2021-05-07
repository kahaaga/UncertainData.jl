
##########
# Addition 
##########

"""
    Base.:+(a::AbstractUncertainValue, b::Real; n::Int = 30000) -> UncertainScalarKDE
    Base.:+(a::Real, b::AbstractUncertainValue; n::Int = 30000) -> UncertainScalarKDE
    Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000) -> UncertainScalarKDE

Addition operator. Perform the operation `a + b` by drawing `n` realizations of the uncertain value(s), 
then performing element-wise addition on the draws. Use the `+(a, b, n)` syntax to tune the number of draws.
A kernel density estimate to the distribution of sums is returned.
    

## Example

```julia
using UncertainData
x = UncertainValue(Normal, 0, 1)
y = UncertainValue([1, 2, -15, -20], [0.2, 0.3, 0.2, 0.3])
x + y # uses the default number of draws (n = 30000)
+(x, y, 100000) # use more samples
```
"""
function Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000)
    UncertainValue(resample(a, n) .+ resample(b, n))
end

Base.:+(a::Real, b::AbstractUncertainValue; n::Int = 30000) = 
    UncertainValue(a .+ resample(b, n))
Base.:+(a::AbstractUncertainValue, b::Real; n::Int = 30000) = 
    UncertainValue(resample(a, n) .+ b)
Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int) = 
    UncertainValue(resample(a, n) .+ resample(b, n))
Base.:+(a::Real, b::AbstractUncertainValue, n::Int) = UncertainValue(a .+ resample(b, n))
Base.:+(a::AbstractUncertainValue, b::Real, n::Int) = UncertainValue(resample(a, n) .+ b)


#####################################################################################
# Special cases 
#####################################################################################

import ..UncertainValues: CertainScalar

##################
# `CertainScalar`s
#################

# Addition of certain values with themselves or scalars acts as regular addition, but 
# returns the result wrapped in a `CertainScalar` instance.
Base.:+(a::Union{CertainScalar, Real}, b::Union{CertainScalar, Real}) 
Base.:+(a::CertainScalar, b::CertainScalar) = CertainScalar(a.value + b.value)
Base.:+(a::CertainScalar, b::Real) = CertainScalar(a.value + b)
Base.:+(a::Real, b::CertainScalar) = CertainScalar(a + b.value)



#######################################
# Adding vectors of uncertain values
#######################################
function Base.:+(a::AbstractVector{AbstractUncertainValue}, 
        b::AbstractVector{AbstractUncertainValue})
    [a[i] + b[i] for i = 1:length(a)]
end

function Base.:+(a::AbstractVector{AbstractUncertainValue}, b::AbstractUncertainValue)
    [a[i] + b for i = 1:length(a)]
end

function Base.:+(a::AbstractUncertainValue, b::AbstractVector{AbstractUncertainValue})
    [a + b[i] for i = 1:length(b)]
end

function Base.:+(a::AbstractVector{AbstractUncertainValue}, 
        b::AbstractVector{AbstractUncertainValue}, n::Int)
    
    [+(a[i], b[i], n) for i = 1:length(a)]
end

function Base.:+(a::AbstractVector{AbstractUncertainValue}, 
        b::AbstractUncertainValue, n::Int)
    
    [+(a[i], b, n) for i = 1:length(a)]
end

function Base.:+(a::AbstractUncertainValue, 
        b::AbstractVector{AbstractUncertainValue}, n::Int)
    
    [+(a, b[i], n) for i = 1:length(b)]
end

