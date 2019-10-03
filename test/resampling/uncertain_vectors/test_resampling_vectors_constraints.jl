
constraints = [TruncateQuantiles(0.1, 0.9) 
    for i in 1:length(example_uvals)] #i % 2 == 0 ? TruncateStd(0.3) : 

# Draw one realisation
@test resample(example_uvals) isa Vector{<:Real}
@test resample(example_uvals, constraints[1]) isa Vector{<:Real}
@test resample(example_uvals, constraints) isa Vector{<:Real}

# Draw multiple realisations
@test resample(example_uvals, 5) isa Vector{Vector{T}} where T<:Real
@test resample(example_uvals, constraints, 5) isa Vector{Vector{T}} where T<:Real
@test resample(example_uvals, constraints[1], 5) isa Vector{Vector{T}} where T<:Real
