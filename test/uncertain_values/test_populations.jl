
@test UncertainScalarPopulation(rand(10), rand(10)) isa UncertainScalarPopulation{Float64}
@test UncertainScalarPopulation([1, 2, 3, 4, 5], rand(5)) isa UncertainScalarPopulation{Int}