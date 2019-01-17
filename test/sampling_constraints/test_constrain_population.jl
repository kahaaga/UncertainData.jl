vals = rand(200)
weights = rand(200)


uv = UncertainValue(vals, weights)
@test constrain(uv, TruncateMinimum(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateMaximum(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateRange(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateUpperQuantile(0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateQuantiles(0.2, 0.8)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateStd(1)) isa ConstrainedUncertainScalarPopulation
@test constrain(uv, TruncateStd(1.3)) isa ConstrainedUncertainScalarPopulation