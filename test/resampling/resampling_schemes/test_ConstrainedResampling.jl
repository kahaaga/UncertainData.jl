v1 = ConstrainedResampling(
    TruncateStd(1.5), 
    NoConstraint(), 
    [i % 2 == 0 ? TruncateQuantiles(0.1, 0.1*i) : TruncateStd(0.1*i) for i = 2:10])

@test v1 isa ConstrainedResampling
@test length(v1) == 3
@test v1[1] |> typeof <: SamplingConstraint