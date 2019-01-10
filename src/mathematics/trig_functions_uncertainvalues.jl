import ..UncertainValues: 
    AbstractUncertainValue
import ..Resampling:
    resample

# Cosine functions 
Base.cos(a::AbstractUncertainValue) = cos.(resample(a, 10000))
Base.cos(a::AbstractUncertainValue, n::Int) = cos.(resample(a, n))

Base.cosd(a::AbstractUncertainValue) = cosd.(resample(a, 10000))
Base.cosd(a::AbstractUncertainValue, n::Int) = cosd.(resample(a, n))

Base.cosh(a::AbstractUncertainValue) = cosh.(resample(a, 10000))
Base.cosh(a::AbstractUncertainValue, n::Int) = cosh.(resample(a, n))

# Sine functions 
Base.sin(a::AbstractUncertainValue) = sin.(resample(a, 10000))
Base.sin(a::AbstractUncertainValue, n::Int) = sin.(resample(a, n))

Base.sind(a::AbstractUncertainValue) = sind.(resample(a, 10000))
Base.sind(a::AbstractUncertainValue, n::Int) = sind.(resample(a, n))

Base.sinh(a::AbstractUncertainValue) = sinh.(resample(a, 10000))
Base.sinh(a::AbstractUncertainValue, n::Int) = sinh.(resample(a, n))


# Tan functions
Base.tan(a::AbstractUncertainValue) = tan.(resample(a, 10000))
Base.tan(a::AbstractUncertainValue, n::Int) = tan.(resample(a, n))

Base.tand(a::AbstractUncertainValue) = tand.(resample(a, 10000))
Base.tand(a::AbstractUncertainValue, n::Int) = tand.(resample(a, n))

Base.tanh(a::AbstractUncertainValue) = tanh.(resample(a, 10000))
Base.tanh(a::AbstractUncertainValue, n::Int) = tanh.(resample(a, n))


# Other 


Base.sincos(a::AbstractUncertainValue) = sincos.(resample(a, 10000))
Base.sincos(a::AbstractUncertainValue, n::Int) = sincos.(resample(a, n))

Base.sinc(a::AbstractUncertainValue) = sinc.(resample(a, 10000))
Base.sinc(a::AbstractUncertainValue, n::Int) = sinc.(resample(a, n))

Base.sinpi(a::AbstractUncertainValue) = sinpi.(resample(a, 10000))
Base.sinpi(a::AbstractUncertainValue, n::Int) = sinpi.(resample(a, n))

Base.cosc(a::AbstractUncertainValue) = cosc.(resample(a, 10000))
Base.cosc(a::AbstractUncertainValue, n::Int) = cosc.(resample(a, n))

Base.cospi(a::AbstractUncertainValue) = cospi.(resample(a, 10000))
Base.cospi(a::AbstractUncertainValue, n::Int) = cospi.(resample(a, n))


############################
# Inverse trig functions 
############################
Base.acos(a::AbstractUncertainValue) = acos.(resample(a, 10000))
Base.acos(a::AbstractUncertainValue, n::Int) = acos.(resample(a, n))

Base.acosd(a::AbstractUncertainValue) = acosd.(resample(a, 10000))
Base.acosd(a::AbstractUncertainValue, n::Int) = acosd.(resample(a, n))

Base.acosh(a::AbstractUncertainValue) = acosh.(resample(a, 10000))
Base.acosh(a::AbstractUncertainValue, n::Int) = acosh.(resample(a, n))


Base.asin(a::AbstractUncertainValue) = asin.(resample(a, 10000))
Base.asin(a::AbstractUncertainValue, n::Int) = asin.(resample(a, n))

Base.asind(a::AbstractUncertainValue) = asind.(resample(a, 10000))
Base.asind(a::AbstractUncertainValue, n::Int) = asind.(resample(a, n))

Base.asinh(a::AbstractUncertainValue) = asinh.(resample(a, 10000))
Base.asinh(a::AbstractUncertainValue, n::Int) = asinh.(resample(a, n))


Base.atan(a::AbstractUncertainValue) = atan.(resample(a, 10000))
Base.atan(a::AbstractUncertainValue, n::Int) = atan.(resample(a, n))

Base.atand(a::AbstractUncertainValue) = atand.(resample(a, 10000))
Base.atand(a::AbstractUncertainValue, n::Int) = atand.(resample(a, n))

Base.atanh(a::AbstractUncertainValue) = atanh.(resample(a, 10000))
Base.atanh(a::AbstractUncertainValue, n::Int) = atanh.(resample(a, n))


Base.asec(a::AbstractUncertainValue) = asec.(resample(a, 10000))
Base.asec(a::AbstractUncertainValue, n::Int) = asec.(resample(a, n))

Base.acsc(a::AbstractUncertainValue) = acsc.(resample(a, 10000))
Base.acsc(a::AbstractUncertainValue, n::Int) = acsc.(resample(a, n))

Base.acot(a::AbstractUncertainValue) = acot.(resample(a, 10000))
Base.acot(a::AbstractUncertainValue, n::Int) = acot.(resample(a, n))

Base.asech(a::AbstractUncertainValue) = asech.(resample(a, 10000))
Base.asech(a::AbstractUncertainValue, n::Int) = asech.(resample(a, n))

Base.acsch(a::AbstractUncertainValue) = acsch.(resample(a, 10000))
Base.acsch(a::AbstractUncertainValue, n::Int) = acsch.(resample(a, n))

Base.acoth(a::AbstractUncertainValue) = acoth.(resample(a, 10000))
Base.acoth(a::AbstractUncertainValue, n::Int) = acoth.(resample(a, n))

############################
# Reciprocal trig functions 
############################

Base.csc(a::AbstractUncertainValue) = csc.(resample(a, 10000))
Base.csc(a::AbstractUncertainValue, n::Int) = csc.(resample(a, n))

Base.cscd(a::AbstractUncertainValue) = cscd.(resample(a, 10000))
Base.cscd(a::AbstractUncertainValue, n::Int) = cscd.(resample(a, n))

Base.csch(a::AbstractUncertainValue) = csch.(resample(a, 10000))
Base.csch(a::AbstractUncertainValue, n::Int) = csch.(resample(a, n))


Base.sec(a::AbstractUncertainValue) = sec.(resample(a, 10000))
Base.sec(a::AbstractUncertainValue, n::Int) = sec.(resample(a, n))

Base.secd(a::AbstractUncertainValue) = secd.(resample(a, 10000))
Base.secd(a::AbstractUncertainValue, n::Int) = secd.(resample(a, n))

Base.sech(a::AbstractUncertainValue) = sech.(resample(a, 10000))
Base.sech(a::AbstractUncertainValue, n::Int) = sech.(resample(a, n))


Base.cot(a::AbstractUncertainValue) = cot.(resample(a, 10000))
Base.cot(a::AbstractUncertainValue, n::Int) = cot.(resample(a, n))

Base.cotd(a::AbstractUncertainValue) = cotd.(resample(a, 10000))
Base.cotd(a::AbstractUncertainValue, n::Int) = cotd.(resample(a, n))

Base.coth(a::AbstractUncertainValue) = coth.(resample(a, 10000))
Base.coth(a::AbstractUncertainValue, n::Int) = coth.(resample(a, n))
