using Distributions, UncertainData

# Test all combinations of different types of uncertain values
M = MixtureModel([Normal(3, 0.2), Normal(2, 1)])

r1 = UncertainValue(Normal, rand(), rand())
r2 = UncertainValue(rand(M, 10000))
r3 = UncertainValue(Normal, rand(Normal(4, 3.2), 10000))

uvals = [r1; r2; r3]

n = 5
for uval in uvals 
    # Sine and inverse sine
    @test sin(uval) isa Vector{Float64}
    @test sin(uval, n) isa Vector{Float64}
    @test sind(uval) isa Vector{Float64}
    @test sind(uval, n) isa Vector{Float64}
    @test sinh(uval) isa Vector{Float64}
    @test sinh(uval, n) isa Vector{Float64}

    #@test asin(uval) isa Vector{Float64}
    #@test asin(uval, n) isa Vector{Float64}
    #@test asind(uval) isa Vector{Float64}
    #@test asind(uval, n) isa Vector{Float64}
    #@test asinh(uval) isa Vector{Float64}
    #@test asinh(uval, n) isa Vector{Float64}

    # Cosine and inverse cosine
    @test cos(uval) isa Vector{Float64}
    @test cos(uval, n) isa Vector{Float64}
    @test cosd(uval) isa Vector{Float64}
    @test cosd(uval, n) isa Vector{Float64}
    @test cosh(uval) isa Vector{Float64}
    @test cosh(uval, n) isa Vector{Float64}

    # @test acos(uval) isa Vector{Float64}
    # @test acos(uval, n) isa Vector{Float64}
    # @test acosd(uval) isa Vector{Float64}
    # @test acosd(uval, n) isa Vector{Float64}
    # @test acosh(uval) isa Vector{Float64}
    # @test acosh(uval, n) isa Vector{Float64}


    # Tangent and inverse tangent
    @test tan(uval) isa Vector{Float64}
    @test tan(uval, n) isa Vector{Float64}
    @test tand(uval) isa Vector{Float64}
    @test tand(uval, n) isa Vector{Float64}
    @test tanh(uval) isa Vector{Float64}
    @test tanh(uval, n) isa Vector{Float64}

    # @test atan(uval) isa Vector{Float64}
    # @test atan(uval, n) isa Vector{Float64}
    # @test atand(uval) isa Vector{Float64}
    # @test atand(uval, n) isa Vector{Float64}
    # @test atanh(uval) isa Vector{Float64}
    # @test atanh(uval, n) isa Vector{Float64}

    # Cosecant and inverse cosecant
    @test csc(uval) isa Vector{Float64}
    @test csc(uval, n) isa Vector{Float64}
    @test cscd(uval) isa Vector{Float64}
    @test cscd(uval, n) isa Vector{Float64}
    @test csch(uval) isa Vector{Float64}
    @test csch(uval, n) isa Vector{Float64}

    # @test acsc(uval) isa Vector{Float64}
    # @test acsc(uval, n) isa Vector{Float64}
    # @test acscd(uval) isa Vector{Float64}
    # @test acscd(uval, n) isa Vector{Float64}
    # @test acsch(uval) isa Vector{Float64}
    # @test acsch(uval, n) isa Vector{Float64}

    # Secant and inverse secant 
    @test sec(uval) isa Vector{Float64}
    @test sec(uval, n) isa Vector{Float64}
    @test secd(uval) isa Vector{Float64}
    @test secd(uval, n) isa Vector{Float64}
    @test sech(uval) isa Vector{Float64}
    @test sech(uval, n) isa Vector{Float64}

    # @test asec(uval) isa Vector{Float64}
    # @test asec(uval, n) isa Vector{Float64}
    # @test asecd(uval) isa Vector{Float64}
    # @test asecd(uval, n) isa Vector{Float64}
    # @test asech(uval) isa Vector{Float64}
    # @test asech(uval, n) isa Vector{Float64}

    # Cotangent and inverse cotangent
    @test cot(uval) isa Vector{Float64}
    @test cot(uval, n) isa Vector{Float64}
    @test cotd(uval) isa Vector{Float64}
    @test cotd(uval, n) isa Vector{Float64}
    @test coth(uval) isa Vector{Float64}
    @test coth(uval, n) isa Vector{Float64}

    # @test acot(uval) isa Vector{Float64}
    # @test acot(uval, n) isa Vector{Float64}
    # @test acotd(uval) isa Vector{Float64}
    # @test acotd(uval, n) isa Vector{Float64}
    # @test acoth(uval) isa Vector{Float64}
    # @test acoth(uval, n) isa Vector{Float64}

    # Related trig functions 
    @test sincos(uval) isa Vector{Tuple{Float64, Float64}}
    @test sincos(uval, n) isa Vector{Tuple{Float64, Float64}}

    @test sinc(uval) isa Vector{Float64}
    @test sinc(uval, n) isa Vector{Float64}

    @test sinpi(uval) isa Vector{Float64}
    @test sinpi(uval, n) isa Vector{Float64}

    @test cosc(uval) isa Vector{Float64}
    @test cosc(uval, n) isa Vector{Float64}

    @test cospi(uval) isa Vector{Float64}
    @test cospi(uval, n) isa Vector{Float64}
end