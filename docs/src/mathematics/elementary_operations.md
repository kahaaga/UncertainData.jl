# Elementary mathematical operations

Elementary mathematical operations (`+`, `-`, `*`, and `/`) between arbitrary 
uncertain values of different types and scalars are supported. 

### Syntax
Because elementary operations should work on arbitrary uncertain values, a resampling 
approach is used to perform the mathematical operations. All mathematical 
operations thus return a vector containing the results of repeated element-wise operations 
(where each element is a resampled draw from the furnishing distribution(s) of the 
uncertain value(s)). 

The default number of realizations is set to `10000`. This allows calling `uval1 + uval2` 
for two uncertain values `uval1` and `uval2`. If you need to tune the number of resample 
draws to `n`, use the `+(uval1, uval2, n)` syntax. 

### Future improvements
In the future, elementary operations might be improved for certain combinations of uncertain 
values where exact expressions for error propagation are now, for example using the 
machinery in `Measurements.jl` for normally distributed values.


# Supported operations 

## Addition 


```@docs 
Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue)
Base.:+(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:+(a::Real, b::AbstractUncertainValue)
Base.:+(a::Real, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:+(a::AbstractUncertainValue, b::Real)
Base.:+(a::AbstractUncertainValue, b::Real, n::Int)
```


## Subtraction

```@docs 
Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue)
Base.:-(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:-(a::Real, b::AbstractUncertainValue)
Base.:-(a::Real, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:-(a::AbstractUncertainValue, b::Real)
Base.:-(a::AbstractUncertainValue, b::Real, n::Int)
```


## Multiplication

```@docs 
Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue)
Base.:*(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:*(a::Real, b::AbstractUncertainValue)
Base.:*(a::Real, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:*(a::AbstractUncertainValue, b::Real)
Base.:*(a::AbstractUncertainValue, b::Real, n::Int)
```

## Division

```@docs 
Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue)
Base.:/(a::AbstractUncertainValue, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:/(a::Real, b::AbstractUncertainValue)
Base.:/(a::Real, b::AbstractUncertainValue, n::Int)
```

```@docs 
Base.:/(a::AbstractUncertainValue, b::Real)
Base.:/(a::AbstractUncertainValue, b::Real, n::Int)
```

## Special cases

### `CertainValue`s

Performing elementary operations with `CertainValue`s behaves as for scalars. 