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

The default number of realizations is set to `10000`, so when you do for example, 
`cos(x::AbstractUncertainValue)`, you'll get a vector containing the element-wise cosines 
of `10000` realizations of `x`. The `cos(x::AbstractUncertainValue, n::Int)` syntax allows
you to tune the number of draws.

## A warning: watch the domain of the function and the uncertain value support

Beware: if the support of the funishing distribution for an uncertain value lies partly 
outside the domain of the function, you risk encountering errors.

# Supported trigonometric functions

## Sine

```@docs 
Base.sin(a::AbstractUncertainValue)
Base.sin(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.sind(a::AbstractUncertainValue)
Base.sind(a::AbstractUncertainValue, n::Int)
```

```
Base.sinh(a::AbstractUncertainValue)
Base.sinh(a::AbstractUncertainValue, n::Int)
```

## Cosine

```@docs 
Base.cos(a::AbstractUncertainValue)
Base.cos(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cosd(a::AbstractUncertainValue)
Base.cosd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cosh(a::AbstractUncertainValue)
Base.cosh(a::AbstractUncertainValue, n::Int)
```


## Tangent

```@docs 
Base.atan(a::AbstractUncertainValue)
Base.atan(a::AbstractUncertainValue, n::Int)
```

```@docs
Base.atand(a::AbstractUncertainValue)
Base.atand(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.atanh(a::AbstractUncertainValue)
Base.atanh(a::AbstractUncertainValue, n::Int)
```


## Reciprocal trig functions 

### Cosecant

```@docs 
Base.csc(a::AbstractUncertainValue)
Base.csc(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cscd(a::AbstractUncertainValue)
Base.cscd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.csch(a::AbstractUncertainValue)
Base.csch(a::AbstractUncertainValue, n::Int)
```

### Secant

```@docs 
Base.sec(a::AbstractUncertainValue)
Base.sec(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.secd(a::AbstractUncertainValue)
Base.secd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.sech(a::AbstractUncertainValue)
Base.sech(a::AbstractUncertainValue, n::Int)
```

### Cotangent

```@docs 
Base.cot(a::AbstractUncertainValue)
Base.cot(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cotd(a::AbstractUncertainValue)
Base.cotd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.coth(a::AbstractUncertainValue)
Base.coth(a::AbstractUncertainValue, n::Int)
```

## Inverse trig functions 

### Sine 

```@docs 
Base.asin(a::AbstractUncertainValue)
Base.asin(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.asind(a::AbstractUncertainValue)
Base.asind(a::AbstractUncertainValue, n::Int)
```

```
Base.asinh(a::AbstractUncertainValue)
Base.asinh(a::AbstractUncertainValue, n::Int)
```

### Cosine 

```@docs 
Base.acos(a::AbstractUncertainValue)
Base.acos(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acosd(a::AbstractUncertainValue)
Base.acosd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acosh(a::AbstractUncertainValue)
Base.acosh(a::AbstractUncertainValue, n::Int)
```

### Tangent

```@docs 
Base.tan(a::AbstractUncertainValue)
Base.tan(a::AbstractUncertainValue, n::Int)
```

```@docs
Base.tand(a::AbstractUncertainValue)
Base.tand(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.tanh(a::AbstractUncertainValue)
Base.tanh(a::AbstractUncertainValue, n::Int)
```

### Inverse cosecant


```@docs 
Base.acsc(a::AbstractUncertainValue)
Base.acsc(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acscd(a::AbstractUncertainValue)
Base.acscd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.acsch(a::AbstractUncertainValue)
Base.acsch(a::AbstractUncertainValue, n::Int)
```

### Inverse secant

```@docs 
Base.asec(a::AbstractUncertainValue)
Base.asec(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.asecd(a::AbstractUncertainValue)
Base.asecd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.asech(a::AbstractUncertainValue)
Base.asech(a::AbstractUncertainValue, n::Int)
```

### Inverse cotangent

```@docs 
Base.cot(a::AbstractUncertainValue)
Base.cot(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.cotd(a::AbstractUncertainValue)
Base.cotd(a::AbstractUncertainValue, n::Int)
```

```@docs 
Base.coth(a::AbstractUncertainValue)
Base.coth(a::AbstractUncertainValue, n::Int)
```

## Other trig functions 

```@docs 
Base.sincos(a::AbstractUncertainValue)
Base.sincos(a::AbstractUncertainValue, n::Int)
```

```@docs
Base.sinc(a::AbstractUncertainValue)
Base.sinc(a::AbstractUncertainValue, n::Int)
```

```@docs
Base.sinpi(a::AbstractUncertainValue)
Base.sinpi(a::AbstractUncertainValue, n::Int)
```

```@docs
Base.cosc(a::AbstractUncertainValue)
Base.cosc(a::AbstractUncertainValue, n::Int)
```

```@docs
Base.cospi(a::AbstractUncertainValue)
Base.cospi(a::AbstractUncertainValue, n::Int)
```