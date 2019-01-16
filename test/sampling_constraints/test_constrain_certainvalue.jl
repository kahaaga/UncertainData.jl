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

for constraint in test_constraints 
    @test constrain(x, constraint) isa CertainValue
end