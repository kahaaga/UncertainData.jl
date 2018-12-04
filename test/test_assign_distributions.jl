using UncertainDatasets
using Test
using Distributions


@test assigndist_uniform(-3, 3) isa Uniform
@test assign_dist(0, -2, 2, Uniform) isa Uniform
@test assign_dist(0, -2, 2, Uniform) isa Uniform

@test assigndist_normal(0, -3, 3) isa Truncated
@test assigndist_normal(0, -3, 3, nσ = 2) isa Truncated
@test assigndist_normal(0, -3, 3, trunc_lower = -2) isa Truncated
@test assigndist_normal(0, -3, 3, trunc_upper = 2) isa Truncated
@test assign_dist(0, -2, 2, Normal) isa Truncated
@test assign_dist(0, -2, 2, Normal, trunc_lower = -3) isa Truncated
@test assign_dist(0, -2, 2, Normal, trunc_upper = 3) isa Truncated
@test assign_dist(0, -2, 2, Normal, trunc_upper = 3, nσ = 3) isa Truncated
