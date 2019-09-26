
constraints = [i % 2 == 0 ? TruncateStd(0.3) : TruncateQuantiles(0.1, 0.9) 
    for i in 1:length(uvals)]

# Draw one realisation
@test resample(uvals) isa Vector{<:Real}
@test resample(uvals, constraints[1]) isa Vector{<:Real}
@test resample(uvals, constraints) isa Vector{<:Real}

# Draw multiple realisations
@test resample(uvals, 5) isa Vector{Vector{T}} where T<:Real
@test resample(uvals, constraints, 5) isa Vector{Vector{T}} where T<:Real
@test resample(uvals, constraints[1], 5) isa Vector{Vector{T}} where T<:Real
