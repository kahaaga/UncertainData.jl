# Trigonometric functions


Trigonometric functions are supported for arbitrary uncertain values of different types.
Like for [elementary operations](elementary_operations.md), a resampling approach is 
used for the computations.

## Syntax
Because elementary operations should work on arbitrary uncertain values, a resampling 
approach is used to perform the mathematical operations. All mathematical 
operations thus return a vector containing the results of repeated element-wise operations 
(where each element is a resampled draw from the furnishing distribution(s) of the 
uncertain value(s)). 

Each trigonometric function comes in two versions. 

- The first syntax allows skipping providing the number of draws, which is set to 10000 by default 
    (e.g. `cos(x::AbstractUncertainValue; n::Int = 10000)`. 
- Using the second syntax, you have to explicitly provide the number of draws (e.g. `cos(x::AbstractUncertainValue, n::Int)`).

## Possible errors

Beware: if the support of the funishing distribution for an uncertain value lies partly 
outside the domain of the function, you risk encountering errors.

# Supported trigonometric functions

## Sine

```@docs 
Base.sin(x::AbstractUncertainValue; n::Int)
Base.sin(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.sind(x::AbstractUncertainValue; n::Int)
Base.sind(x::AbstractUncertainValue, n::Int)
```

```
Base.sinh(x::AbstractUncertainValue; n::Int)
Base.sinh(x::AbstractUncertainValue, n::Int)
```

## Cosine

```@docs 
Base.cos(x::AbstractUncertainValue; n::Int)
Base.cos(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cosd(x::AbstractUncertainValue; n::Int)
Base.cosd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cosh(x::AbstractUncertainValue; n::Int)
Base.cosh(x::AbstractUncertainValue, n::Int)
```


## Tangent

```@docs 
Base.atan(x::AbstractUncertainValue; n::Int)
Base.atan(x::AbstractUncertainValue, n::Int)
```

```@docs
Base.atand(x::AbstractUncertainValue; n::Int)
Base.atand(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.atanh(x::AbstractUncertainValue; n::Int)
Base.atanh(x::AbstractUncertainValue, n::Int)
```


## Reciprocal trig functions 

### Cosecant

```@docs 
Base.csc(x::AbstractUncertainValue; n::Int)
Base.csc(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cscd(x::AbstractUncertainValue; n::Int)
Base.cscd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.csch(x::AbstractUncertainValue; n::Int)
Base.csch(x::AbstractUncertainValue, n::Int)
```

### Secant

```@docs 
Base.sec(x::AbstractUncertainValue; n::Int)
Base.sec(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.secd(x::AbstractUncertainValue; n::Int)
Base.secd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.sech(x::AbstractUncertainValue; n::Int)
Base.sech(x::AbstractUncertainValue, n::Int)
```

### Cotangent

```@docs 
Base.cot(x::AbstractUncertainValue; n::Int)
Base.cot(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cotd(x::AbstractUncertainValue; n::Int)
Base.cotd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.coth(x::AbstractUncertainValue; n::Int)
Base.coth(x::AbstractUncertainValue, n::Int)
```

## Inverse trig functions 

### Sine 

```@docs 
Base.asin(x::AbstractUncertainValue; n::Int)
Base.asin(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.asind(x::AbstractUncertainValue; n::Int)
Base.asind(x::AbstractUncertainValue, n::Int)
```

```
Base.asinh(x::AbstractUncertainValue; n::Int)
Base.asinh(x::AbstractUncertainValue, n::Int)
```

### Cosine 

```@docs 
Base.acos(x::AbstractUncertainValue; n::Int)
Base.acos(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acosd(x::AbstractUncertainValue; n::Int)
Base.acosd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acosh(x::AbstractUncertainValue; n::Int)
Base.acosh(x::AbstractUncertainValue, n::Int)
```

### Tangent

```@docs 
Base.tan(x::AbstractUncertainValue; n::Int)
Base.tan(x::AbstractUncertainValue, n::Int)
```

```@docs
Base.tand(x::AbstractUncertainValue; n::Int)
Base.tand(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.tanh(x::AbstractUncertainValue; n::Int)
Base.tanh(x::AbstractUncertainValue, n::Int)
```

### Inverse cosecant


```@docs 
Base.acsc(x::AbstractUncertainValue; n::Int)
Base.acsc(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acscd(x::AbstractUncertainValue; n::Int)
Base.acscd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acsch(x::AbstractUncertainValue; n::Int)
Base.acsch(x::AbstractUncertainValue, n::Int)
```

### Inverse secant

```@docs 
Base.asec(x::AbstractUncertainValue; n::Int)
Base.asec(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.asecd(x::AbstractUncertainValue; n::Int)
Base.asecd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.asech(x::AbstractUncertainValue; n::Int)
Base.asech(x::AbstractUncertainValue, n::Int)
```

### Inverse cotangent

```@docs 
Base.acot(x::AbstractUncertainValue; n::Int)
Base.acot(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acotd(x::AbstractUncertainValue; n::Int)
Base.acotd(x::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acoth(x::AbstractUncertainValue; n::Int)
Base.acoth(x::AbstractUncertainValue, n::Int)
```

## Other trig functions 

```@docs 
Base.sincos(x::AbstractUncertainValue; n::Int)
Base.sincos(x::AbstractUncertainValue, n::Int)
```

```@docs
Base.sinc(x::AbstractUncertainValue; n::Int)
Base.sinc(x::AbstractUncertainValue, n::Int)
```

```@docs
Base.sinpi(x::AbstractUncertainValue; n::Int)
Base.sinpi(x::AbstractUncertainValue, n::Int)
```

```@docs
Base.cosc(x::AbstractUncertainValue; n::Int)
Base.cosc(x::AbstractUncertainValue, n::Int)
```

```@docs
Base.cospi(x::AbstractUncertainValue; n::Int)
Base.cospi(x::AbstractUncertainValue, n::Int)
```