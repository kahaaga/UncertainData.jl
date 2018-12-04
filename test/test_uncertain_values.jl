@test UncertainValue(0, -2, 2, Normal, nσ = 2, trunc_lower = -5) isa UncertainScalarValue
@test UncertainValue(0, -2, 2, Normal) isa UncertainScalarValue
@test_broken UncertainValue(-5, -10, 0, Normal) isa UncertainScalarValue

@test UncertainValue(0, -2, 2, Uniform) isa UncertainScalarValue
@test UncertainValue(1, 7, Uniform) isa UncertainScalarValue
@test UncertainValue(-1, 7, Uniform) isa UncertainScalarValue
@test UncertainValue(-6, -2, Uniform) isa UncertainScalarValue

@test UncertainEmpiricalValue(rand(100), Uniform) isa UncertainEmpiricalScalarValue
@test UncertainEmpiricalValue(rand(Normal(), 100), Normal) isa UncertainEmpiricalScalarValue

@test UncertainEmpiricalScalarValue(rand(100), Uniform) isa UncertainEmpiricalScalarValue
@test UncertainEmpiricalScalarValue(rand(Normal(), 100), Normal) isa UncertainEmpiricalScalarValue


#@test @uncertainvalue(0, -2, 2, Normal()) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), nσ = 2) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), trunc_lower = 5) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), trunc_upper = 5) isa AbstractUncertainObservation
#@test @uncertainvalue(0, -2, 2, Normal(), tolerance = 1e-4) isa AbstractUncertainObservation
