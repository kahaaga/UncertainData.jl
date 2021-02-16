
# resample(uvals::Vector{AbstractUncertainValue})
@test resample(uvals) isa Vector
@test length(resample(uvals)) == length(uvals)

# resample(uvals::Vector{AbstractUncertainValue}, n::Int) 
n = 2
@test resample(uvals, n) isa Vector{Vector{T}} where T<:Real
# TODO: make sure all values are promoted to floats, otherwise performance loss is
# significant
#@test resample(uvals, n) isa Vector{Vector{Float}}

@test length(resample(uvals, n)) == n

# resample_elwise(uvals::Vector{AbstractUncertainValue}, n::Int) 
n = 2
@test resample_elwise(uvals, n) isa Vector{Vector{T}} where T<:Real
@test length(resample_elwise(uvals, n)) == length(uvals)
@test length(resample_elwise(uvals, n)[1]) == n
