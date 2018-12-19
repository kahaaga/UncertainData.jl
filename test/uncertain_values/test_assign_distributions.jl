using UncertainData
using Test
using Distributions


@test assigndist_uniform(-3, 3) isa Uniform
@test assigndist_uniform(0, 0.2) isa Uniform
@test assigndist_uniform(-2, 1) isa Uniform

@test assigndist_normal(0, 0.3) isa Truncated
@test assigndist_normal(2, 0.2, nσ = 2) isa Truncated
@test assigndist_normal(10.0, 2, trunc_lower = -2) isa Truncated
@test assigndist_normal(5, 0.2, trunc_upper = 2) isa Truncated
@test assigndist_normal(0, 0.2) isa Truncated
@test assigndist_normal(2, 0.1, trunc_lower = -3) isa Truncated
@test assigndist_normal(-2, 0.1, trunc_upper = 3) isa Truncated
@test assigndist_normal(0, 0.3, trunc_upper = 3, nσ = 3) isa Truncated
