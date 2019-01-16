import ..UncertainValues: 
    AbstractUncertainValue
import ..Resampling:
    resample


# Cosine functions 
""" 
    Base.cos(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the cosine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise cosine for `n` realizations.
""" 
Base.cos(x::AbstractUncertainValue; n::Int = 10000) = cos.(resample(x, n))

""" 
    Base.cos(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the cosine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise cosine for `n` realizations.
""" 
Base.cos(x::AbstractUncertainValue, n::Int) = cos.(resample(x, n))

""" 
    Base.cos(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the cosine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cosine for `n` realizations.
""" 
Base.cosd(x::AbstractUncertainValue; n::Int = 10000) = cosd.(resample(x, n))

""" 
    Base.cos(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the cosine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cosine for `n` realizations.
""" 
Base.cosd(x::AbstractUncertainValue, n::Int) = cosd.(resample(x, n))

""" 
    Base.cos(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic cosine of the uncertain value `x`.
Computes the element-wise hyperbolic cosine for `n` realizations.
""" 
Base.cosh(x::AbstractUncertainValue; n::Int = 10000) = cosh.(resample(x, n))

""" 
    Base.cos(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic cosine of the uncertain value `x`.
Computes the element-wise hyperbolic cosine for `n` realizations.
""" 
Base.cosh(x::AbstractUncertainValue, n::Int) = cosh.(resample(x, n))

# Sine functions 
""" 
    Base.sin(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the sine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise sine for `n` realizations.
""" 
Base.sin(x::AbstractUncertainValue; n::Int = 10000) = sin.(resample(x, n))

""" 
    Base.sin(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the sine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise sine for `n` realizations.
""" 
Base.sin(x::AbstractUncertainValue, n::Int) = sin.(resample(x, n))

""" 
    Base.sind(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the sine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise sine for `n` realizations.
""" 
Base.sind(x::AbstractUncertainValue; n::Int = 10000) = sind.(resample(x, n))

""" 
    Base.sind(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the sine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise sine for `n` realizations.
""" 
Base.sind(x::AbstractUncertainValue, n::Int) = sind.(resample(x, n))

""" 
    Base.sinh(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic sine of the uncertain value `x`.
Computes the element-wise hyperbolic sine for `n` realizations.
""" 
Base.sinh(x::AbstractUncertainValue; n::Int = 10000) = sinh.(resample(x, n))

""" 
    Base.sinh(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic sine of the uncertain value `x`.
Computes the element-wise hyperbolic sine for `n` realizations.
""" 
Base.sinh(x::AbstractUncertainValue, n::Int) = sinh.(resample(x, n))


# Tan functions
""" 
    Base.tan(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the tangent of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise tangent for `n` realizations.
""" 
Base.tan(x::AbstractUncertainValue; n::Int = 10000) = tan.(resample(x, n))

""" 
    Base.tan(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the tangent of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise tangent for `n` realizations.
""" 
Base.tan(x::AbstractUncertainValue, n::Int) = tan.(resample(x, n))

""" 
    Base.tand(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the tangent of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise tangent for `n` realizations.
""" 
Base.tand(x::AbstractUncertainValue; n::Int = 10000) = tand.(resample(x, n))

""" 
    Base.tand(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the tangent of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise tangent for `n` realizations.
""" 
Base.tand(x::AbstractUncertainValue, n::Int) = tand.(resample(x, n))

""" 
    Base.tanh(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic tangent of the uncertain value `x`.
Computes the element-wise hyperbolic tangent for `n` realizations.
""" 
Base.tanh(x::AbstractUncertainValue; n::Int = 10000) = tanh.(resample(x, n))

""" 
    Base.tanh(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic tangent of the uncertain value `x`. 
Computes the element-wise hyperbolic tangent for `n` realizations.
""" 
Base.tanh(x::AbstractUncertainValue, n::Int) = tanh.(resample(x, n))


# Other 

""" 
    Base.sincos(x::AbstractUncertainValue; n::Int = 10000)

Simultaneously compute the sine and cosine of the uncertain value `x`, where `x` is in 
radians. Computes the element-wise `sincos` for `n` realizations.
""" 
Base.sincos(x::AbstractUncertainValue; n::Int = 10000) = sincos.(resample(x, n))


""" 
    Base.sincos(x::AbstractUncertainValue, n::Int = 10000)

Simultaneously compute the sine and cosine of the uncertain value `x`, where `x` is in 
radians. Computes the element-wise `sincos` for `n` realizations.
""" 
Base.sincos(x::AbstractUncertainValue, n::Int) = sincos.(resample(x, n))

""" 
    Base.sinc(x::AbstractUncertainValue; n::Int = 10000)

In an element-wise manner for `n` realizations of the uncertain value `x`, compute 
``\\sin(\\pi x) / (\\pi x)`` if ``x \\neq 0``, and ``1`` if ``x = 0``.
""" 
Base.sinc(x::AbstractUncertainValue; n::Int = 10000) = sinc.(resample(x, n))

""" 
    Base.sinc(x::AbstractUncertainValue, n::Int = 10000)

Compute ``\\sin(\\pi x) / (\\pi x)`` if ``x \\neq 0``, and ``1`` if ``x = 0`` element-wise 
over `n` realizations of the uncertain value `x`. 
""" 
Base.sinc(x::AbstractUncertainValue, n::Int) = sinc.(resample(x, n))

""" 
    Base.sinpi(x::AbstractUncertainValue; n::Int = 10000)

Compute ``\\sin(\\pi x)`` more accurately than `sin(pi*x)`, especially for large `x`, 
in an element-wise over `n` realizations of the uncertain value `x`. 
""" 
Base.sinpi(x::AbstractUncertainValue; n::Int = 10000) = sinpi.(resample(x, n))

""" 
    Base.sinpi(x::AbstractUncertainValue; n::Int = 10000)

Compute ``\\sin(\\pi x)`` more accurately than `sin(pi*x)`, especially for large `x`, 
in an element-wise over `n` realizations of the uncertain value `x`. 
""" 
Base.sinpi(x::AbstractUncertainValue, n::Int) = sinpi.(resample(x, n))

""" 
    Base.cosc(x::AbstractUncertainValue; n::Int = 10000)

Compute ``\\cos(\\pi x) / x - \\sin(\\pi x) / (\\pi x^2)`` if ``x \\neq 0``, and ``0`` if
``x = 0``, in an element-wise manner over `n` realizations of the uncertain value `x`. 

This is the derivative of `sinc(x)`.
""" 
Base.cosc(x::AbstractUncertainValue; n::Int = 10000) = cosc.(resample(x, n))

""" 
    Base.cosc(x::AbstractUncertainValue, n::Int = 10000)

Compute ``\\cos(\\pi x) / x - \\sin(\\pi x) / (\\pi x^2)`` if ``x \\neq 0``, and ``0`` if
``x = 0``, in an element-wise manner over `n` realizations of the uncertain value `x`. 

This is the derivative of `sinc(x)`.
""" 
Base.cosc(x::AbstractUncertainValue, n::Int) = cosc.(resample(x, n))

""" 
    Base.cospi(x::AbstractUncertainValue; n::Int = 10000)

Compute ``\\cos(\\pi x)`` more accurately than `cos(pi*x)`, especially for large `x`, 
in an element-wise over `n` realizations of the uncertain value `x`. 
""" 
Base.cospi(x::AbstractUncertainValue; n::Int = 10000) = cospi.(resample(x, n))

""" 
    Base.cospi(x::AbstractUncertainValue, n::Int = 10000)

Compute ``\\cos(\\pi x)`` more accurately than `cos(pi*x)`, especially for large `x`, 
in an element-wise over `n` realizations of the uncertain value `x`. 
""" 
Base.cospi(x::AbstractUncertainValue, n::Int) = cospi.(resample(x, n))


############################
# Inverse trig functions 
############################
""" 
    Base.acos(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse cosine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise inverse cosine for `n` realizations.
""" 
Base.acos(x::AbstractUncertainValue; n::Int = 10000) = acos.(resample(x, n))

""" 
    Base.acos(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse cosine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise inverse cosine for `n` realizations.
""" 
Base.acos(x::AbstractUncertainValue, n::Int) = acos.(resample(x, n))

""" 
    Base.acosd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse cosine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise inverse cosine for `n` realizations.
""" 
Base.acosd(x::AbstractUncertainValue; n::Int = 10000) = acosd.(resample(x, n))

""" 
    Base.acosd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse cosine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise inverse cosine for `n` realizations.
""" 
Base.acosd(x::AbstractUncertainValue, n::Int) = acosd.(resample(x, n))

""" 
    Base.acosh(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic cosine of the uncertain value `x`.
Computes the element-wise inverse hyperbolic cosine for `n` realizations.
""" 
Base.acosh(x::AbstractUncertainValue; n::Int = 10000) = acosh.(resample(x, n))

""" 
    Base.acosh(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic cosine of the uncertain value `x`.
Computes the element-wise inverse hyperbolic cosine for `n` realizations.
""" 
Base.acosh(x::AbstractUncertainValue, n::Int) = acosh.(resample(x, n))

""" 
    Base.asin(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse sine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise inverse sine for `n` realizations.
""" 
Base.asin(x::AbstractUncertainValue; n::Int = 10000) = asin.(resample(x, n))

""" 
    Base.asin(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse sine of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise inverse sine for `n` realizations.
""" 
Base.asin(x::AbstractUncertainValue, n::Int) = asin.(resample(x, n))

""" 
    Base.asind(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse sine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise inverse sine for `n` realizations.
""" 
Base.asind(x::AbstractUncertainValue; n::Int = 10000) = asind.(resample(x, n))

""" 
    Base.asind(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse sine of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise inverse sine for `n` realizations.
""" 
Base.asind(x::AbstractUncertainValue, n::Int) = asind.(resample(x, n))

""" 
    Base.asinh(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic sine of the uncertain value `x`.
Computes the element-wise inverse hyperbolic csine for `n` realizations.
""" 
Base.asinh(x::AbstractUncertainValue; n::Int = 10000) = asinh.(resample(x, n))

""" 
    Base.asinh(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic sine of the uncertain value `x`.
Computes the element-wise inverse hyperbolic csine for `n` realizations.
""" 
Base.asinh(x::AbstractUncertainValue, n::Int) = asinh.(resample(x, n))

""" 
    Base.atan(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse tangent of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse tangent for `n` realizations.
""" 
Base.atan(x::AbstractUncertainValue; n::Int = 10000) = atan.(resample(x, n))

""" 
    Base.atan(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse tangent of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse tangent for `n` realizations.
""" 
Base.atan(x::AbstractUncertainValue, n::Int) = atan.(resample(x, n))

""" 
    Base.atand(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse tangent of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise inverse tangent for `n` realizations.
""" 
Base.atand(x::AbstractUncertainValue; n::Int = 10000) = atand.(resample(x, n))

""" 
    Base.atand(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse tangent of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise inverse tangent for `n` realizations.
""" 
Base.atand(x::AbstractUncertainValue, n::Int) = atand.(resample(x, n))

""" 
    Base.atanh(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse hypoerbolic tangent of the uncertain value `x`.
Computes the element-wise inverse hypoerbolic tangent for `n` realizations.
""" 
Base.atanh(x::AbstractUncertainValue; n::Int = 10000) = atanh.(resample(x, n))

""" 
    Base.atanh(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse hypoerbolic tangent of the uncertain value `x`.
Computes the element-wise inverse hypoerbolic tangent for `n` realizations.
""" 
Base.atanh(x::AbstractUncertainValue, n::Int) = atanh.(resample(x, n))

""" 
    Base.asec(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse secant of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.asec(x::AbstractUncertainValue; n::Int = 10000) = asec.(resample(x, n))

""" 
    Base.asec(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse secant of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.asec(x::AbstractUncertainValue, n::Int) = asec.(resample(x, n))

""" 
    Base.asecd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse secant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.asecd(x::AbstractUncertainValue; n::Int = 10000) = asec.(resample(x, n))

""" 
    Base.asecd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse secant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.asecd(x::AbstractUncertainValue, n::Int) = asec.(resample(x, n))

""" 
    Base.asech(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic secant of the uncertain value `x`.
Computes the element-wise inverse hyperbolic secant for `n` realizations.
""" 
Base.asech(x::AbstractUncertainValue; n::Int = 10000) = asec.(resample(x, n))

""" 
    Base.asech(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic secant of the uncertain value `x`.
Computes the element-wise inverse hyperbolic secant for `n` realizations.
""" 
Base.asech(x::AbstractUncertainValue, n::Int) = asec.(resample(x, n))

""" 
    Base.acsc(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse cosecant of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse cosecant for `n` realizations.
""" 
Base.acsc(x::AbstractUncertainValue; n::Int = 10000) = acsc.(resample(x, n))

""" 
    Base.acsc(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse cosecant of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse cosecant for `n` realizations.
""" 
Base.acsc(x::AbstractUncertainValue, n::Int) = acsc.(resample(x, n))

""" 
    Base.acscd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse cosecant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise inverse cosecant for `n` realizations.
""" 
Base.acscd(x::AbstractUncertainValue; n::Int = 10000) = acsc.(resample(x, n))

""" 
    Base.acscd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse cosecant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise inverse cosecant for `n` realizations.
""" 
Base.acscd(x::AbstractUncertainValue, n::Int) = acsc.(resample(x, n))

""" 
    Base.acscd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic cosecant of the uncertain value `x`.
Computes the element-wise inverse hypoerbolic cosecant for `n` realizations.
""" 
Base.acsch(x::AbstractUncertainValue; n::Int = 10000) = acsc.(resample(x, n))

""" 
    Base.acscd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic cosecant of the uncertain value `x`.
Computes the element-wise inverse hypoerbolic cosecant for `n` realizations.
""" 
Base.acsch(x::AbstractUncertainValue, n::Int) = acsc.(resample(x, n))

""" 
    Base.acot(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse cotangent of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.acot(x::AbstractUncertainValue; n::Int = 10000) = acot.(resample(x, n))

""" 
    Base.acot(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse cotangent of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.acot(x::AbstractUncertainValue, n::Int) = acot.(resample(x, n))

""" 
    Base.acotd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse cotangent of the uncertain value `x`, where `x` is in degrees.
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.acotd(x::AbstractUncertainValue; n::Int = 10000) = acot.(resample(x, n))

""" 
    Base.acotd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse cotangent of the uncertain value `x`, where `x` is in degrees.
Computes the element-wise inverse secant for `n` realizations.
""" 
Base.acotd(x::AbstractUncertainValue, n::Int) = acot.(resample(x, n))

""" 
    Base.acoth(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic cotangent of the uncertain value `x`.
Computes the element-wise inverse hyperbolic secant for `n` realizations.
""" 
Base.acoth(x::AbstractUncertainValue; n::Int = 10000) = acot.(resample(x, n))

""" 
    Base.acoth(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the inverse hyperbolic cotangent of the uncertain value `x`.
Computes the element-wise inverse hyperbolic secant for `n` realizations.
""" 
Base.acoth(x::AbstractUncertainValue, n::Int) = acot.(resample(x, n))


############################
# Reciprocal trig functions 
############################

""" 
    Base.csc(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the cosecant of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise cosecant for `n` realizations.
""" 
Base.csc(x::AbstractUncertainValue; n::Int = 10000) = csc.(resample(x, n))

""" 
    Base.csc(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the cosecant of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise cosecant for `n` realizations.
""" 
Base.csc(x::AbstractUncertainValue, n::Int) = csc.(resample(x, n))

""" 
    Base.cscd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the cosecant of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cosecant for `n` realizations.
""" 
Base.cscd(x::AbstractUncertainValue; n::Int = 10000) = cscd.(resample(x, n))

""" 
    Base.cscd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the cosecant of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cosecant for `n` realizations.
""" 
Base.cscd(x::AbstractUncertainValue, n::Int) = cscd.(resample(x, n))

""" 
    Base.cscd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic cosecant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise hyperbolic cosecant for `n` realizations.
""" 
Base.csch(x::AbstractUncertainValue; n::Int = 10000) = csch.(resample(x, n))

""" 
    Base.cscd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic cosecant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise hyperbolic cosecant for `n` realizations.
""" 
Base.csch(x::AbstractUncertainValue, n::Int) = csch.(resample(x, n))

""" 
    Base.sec(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the secant of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise secant for `n` realizations.
""" 
Base.sec(x::AbstractUncertainValue; n::Int = 10000) = sec.(resample(x, n))

""" 
    Base.sec(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the secant of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise secant for `n` realizations.
""" 
Base.sec(x::AbstractUncertainValue, n::Int) = sec.(resample(x, n))

""" 
    Base.secd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the secant of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cosecant for `n` realizations.
""" 
Base.secd(x::AbstractUncertainValue; n::Int = 10000) = secd.(resample(x, n))

""" 
    Base.secd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the secant of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cosecant for `n` realizations.
""" 
Base.secd(x::AbstractUncertainValue, n::Int) = secd.(resample(x, n))

""" 
    Base.sech(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic secant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise hyperbolic secant for `n` realizations.
""" 
Base.sech(x::AbstractUncertainValue; n::Int = 10000) = sech.(resample(x, n))


""" 
    Base.sech(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic secant of the uncertain value `x`, where `x` is in degrees. 
Computes the element-wise hyperbolic secant for `n` realizations.
""" 
Base.sech(x::AbstractUncertainValue, n::Int) = sech.(resample(x, n))


""" 
    Base.cot(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the cotangent of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise cotangent for `n` realizations.
""" 
Base.cot(x::AbstractUncertainValue; n::Int = 10000) = cot.(resample(x, n))

""" 
    Base.cot(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the cotangent of the uncertain value `x`, where `x` is in radians. Computes the 
element-wise cotangent for `n` realizations.
""" 
Base.cot(x::AbstractUncertainValue, n::Int) = cot.(resample(x, n))

""" 
    Base.cotd(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the cotangent of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cotangent for `n` realizations.
""" 
Base.cotd(x::AbstractUncertainValue; n::Int = 10000) = cotd.(resample(x, n))

""" 
    Base.cotd(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the cotangent of the uncertain value `x`, where `x` is in degrees. Computes the 
element-wise cotangent for `n` realizations.
""" 
Base.cotd(x::AbstractUncertainValue, n::Int) = cotd.(resample(x, n))

""" 
    Base.coth(x::AbstractUncertainValue; n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic cotangent of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise hyperbolic cotangent for `n` realizations.
""" 
Base.coth(x::AbstractUncertainValue; n::Int = 10000) = coth.(resample(x, n))

""" 
    Base.coth(x::AbstractUncertainValue, n::Int = 10000) -> Vector{Float64}

Compute the hyperbolic cotangent of the uncertain value `x`, where `x` is in radians. 
Computes the element-wise hyperbolic cotangent for `n` realizations.
""" 
Base.coth(x::AbstractUncertainValue, n::Int) = coth.(resample(x, n))


#####################################################################################
# Special cases 
#####################################################################################

trigfuncs = [:(cos), :(cosd), :(cosh), :(sin), :(sind), :(sinh), :(tan), :(tand), :(tanh), 
    :(sincos), :(sinc), :(sinpi), :(cosc), :(cospi), :(acos), :(acosd), :(acosh), :(asin), 
    :(asind), :(asinh), :(atan), :(atand), :(atanh), :(asec), :(asecd), :(asech), :(acsc), 
    :(acscd), :(acsch), :(acot), :(acotd), :(acoth), :(csc), :(cscd), :(csch), :(sec), 
    :(secd), :(sech), :(cot), :(cotd), :(coth)]

##################
# `CertainValue`s
#################
import ..UncertainValues: CertainValue

"""
    Base.:-(a::Union{CertainValue, Real}, b::Union{CertainValue, Real})

Subtraction of certain values with themselves or scalars acts as regular subtraction, 
but returns the result wrapped in a `CertainValue` instance.
"""

for trigfunc in trigfuncs
    f = Meta.parse("Base.$(trigfunc)")

    regular_func = quote 
        """ 
            $($f)(x::CertainValue)
        
        Compute `$($trigfunc)(x)`.
        """
        $(f)(x::CertainValue) = x.value
    end

    n_reps_func = quote 
        """ 
            $($f)(x::CertainValue, n::Int)
        
        Compute `$($trigfunc)(x)` `n` times and return the result(s) as a vector (just 
        repeating the value `n` times).
        """
        $(f)(x::CertainValue, n::Int) = [x.value for i = 1:n]
    end

    eval(regular_func)
    eval(n_reps_func)
end