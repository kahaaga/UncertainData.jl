import UncertainData: 
    UncertainDataset, 
    resample, 
    UncertainValue, 
    StrictlyDecreasing,
    NoConstraint,
    TruncateLowerQuantile,
    TruncateUpperQuantile,
    TruncateQuantiles,
    TruncateMinimum,
    TruncateMaximum,
    TruncateRange,
    TruncateStd

import Distributions: 
    Uniform, 
    Normal

import Test 


# Create some uncertain data with decreasing magnitude and zero overlap between values, 
# so we're guaranteed that a strictly decreasing sequence through the dataset exists.
N = 10
u_timeindices = [UncertainValue(Normal, i, rand(Uniform(0.1, 0.45))) for i = N:-1:1]
u = UncertainDataset(u_timeindices)

# No further constraints other than the order constraint
x = resample(u, StrictlyDecreasing())
@test x isa Vector{Float64}

n_realizations = 100
X = [resample(u, StrictlyDecreasing()) for i = 1:n_realizations]

# We're getting vectors 
@test all([x isa Vector{Float64} for x in X])

# All sequences 
@test all([all(diff(x) .< 0) for x in X])

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

# First constrain using a single regular constraint, then apply the order constraint.  
for i = 1:length(test_constraints)
    constraint = test_constraints[i]
    @test resample(u, constraint, StrictlyDecreasing()) isa Vector{Float64}
    @test all([resample(u, constraint, StrictlyDecreasing()) isa Vector{Float64} for k = 1:n_realizations])
end

#First element-wise apply a vector of regular constraints to each element in the dataset, 
#then apply the order constraint.  
for i = 1:length(test_constraints)
    constraints = [test_constraints[i] for k = 1:length(u)]
    @test resample(u, constraints, StrictlyDecreasing()) isa Vector{Float64}
    @test all([resample(u, constraints, StrictlyDecreasing()) isa Vector{Float64} for k = 1:n_realizations])
end

iv = UncertainIndexValueDataset(u, u)
@test resample(iv, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}}

# First constrain using a single regular constraint, then apply the order constraint.  
for i = 1:length(test_constraints)
    constraint = test_constraints[i]
    @test resample(iv, constraint, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}}
    @test resample(iv, constraint, constraint, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}}
    @test all([resample(iv, constraint, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}} for k = 1:n_realizations])
    @test all([resample(iv, constraint, constraint, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}} for k = 1:n_realizations])

    cs = [test_constraints[i] for k = 1:length(u)]
    @test resample(iv, cs, cs, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}}
    @test resample(iv, cs, constraint, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}}
    @test resample(iv, constraint, cs, StrictlyDecreasing()) isa Tuple{Vector{Float64}, Vector{Float64}}
end