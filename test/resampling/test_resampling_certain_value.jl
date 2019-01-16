x = CertainValue(2.0)

test_constraints = [
    NoConstraint(), 
    TruncateLowerQuantile(0.2), 
    TruncateUpperQuantile(0.2),
    TruncateQuantiles(0.2, 0.8),
    TruncateMaximum(50),
    TruncateMinimum(-50),
    TruncateRange(-50, 50),
    TruncateStd(1)
]

T = eltype(x)

@test resample(x) isa T
@test resample(x, 10) isa Vector
@test all(resample(x, 10) .== x.value)

for constraint in test_constraints 
    @test resample(x, constraint) isa T
    @test resample(x, constraint, 10) isa Vector
    @test all(resample(x, constraint, 10) .== x.value)
end