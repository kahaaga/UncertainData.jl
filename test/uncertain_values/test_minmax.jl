uval1 = UncertainValue(Normal, 1, 5)
uval2 = UncertainValue(Uniform, rand(1000))
uval3 = UncertainValue(rand(10000))


v = [uval1, uval2, uval3]

@test minimum(uval1) isa Float64
@test minimum(uval2) isa Float64
@test minimum(uval3) isa Float64

@test maximum(uval1) isa Float64
@test maximum(uval2) isa Float64
@test maximum(uval3) isa Float64

@test minimum(v) isa Float64
@test maximum(v) isa Float64
