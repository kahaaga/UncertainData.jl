import ..UncertainValues: 
    AbstractUncertainValue
import ..Resampling:
    resample

#############
# Subtraction
#############

"""
    Base.:-(a::AbstractUncertainValue, b::Real; n::Int = 30000) -> UncertainScalarKDE
    Base.:-(a::Real, b::AbstractUncertainValue; n::Int = 30000) -> UncertainScalarKDE
    Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000) -> UncertainScalarKDE

Subtraction operator. Subtract `b` from `a` by drawing `n` realizations of the uncertain value(s), 
then performing element-wise subtraction on the draws. 
A kernel density estimate to the distribution of sums is returned.
    
Use the `-(a, b, n)` syntax to tune the number of draws.

## Example

```julia
using UncertainData
x = UncertainValue(Normal, 0, 1)
y = UncertainValue([1, 2, -15, -20], [0.2, 0.3, 0.2, 0.3])
x - y # uses the default number of draws (n = 30000)
-(x, y, 100000) # use more samples
```
"""
function Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue; n::Int = 30000)
    UncertainValue(resample(a, n) .- resample(b, n))
end

Base.:-(a::Real, b::AbstractUncertainValue; n::Int = 30000) = 
    UncertainValue(a .- resample(b, n))
Base.:-(a::AbstractUncertainValue, b::Real; n::Int = 30000) = 
    UncertainValue(resample(a, n) .- b)
Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int) =
    UncertainValue(resample(a, n) .- resample(b, n))
Base.:-(a::Real, b::AbstractUncertainValue, n::Int) = 
    UncertainValue(a .- resample(b, n))
Base.:-(a::AbstractUncertainValue, b::Real, n::Int) = 
    UncertainValue(resample(a, n) .- b)



#####################################################################################
# Special cases 
#####################################################################################

import ..UncertainValues: CertainScalar

##################
# `CertainScalar`s
#################

#Subtraction of certain values with themselves or scalars acts as regular subtraction, 
#but returns the result wrapped in a `CertainScalar` instance.
Base.:-(a::Union{CertainScalar, Real}, b::Union{CertainScalar, Real}) 

Base.:-(a::CertainScalar, b::CertainScalar) = CertainScalar(a.value - b.value)
Base.:-(a::CertainScalar, b::Real) = CertainScalar(a.value - b)
Base.:-(a::Real, b::CertainScalar) = CertainScalar(a - b.value)

