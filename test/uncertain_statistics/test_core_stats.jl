o1 = UncertainValue(0, 0.2, Normal)
o2 = UncertainValue(1, 0.3, Normal)
o3 = UncertainValue(0, 4, Uniform)
o4 = UncertainValue(rand(100), Uniform)
D1 = UncertainDataset([o1, o2, o3,])
D2 = UncertainDataset([o1, o2, o4])

##################
# Uncertain values
##################
@test mean(o1) isa Float64
@test median(o1) isa Float64
@test middle(o1) isa Float64
@test quantile(o1, 0.86) isa Float64
@test std(o1) isa Float64
@test var(o1) isa Float64

#####################
## Uncertain datasets
#####################
@test mean(D1, 10) isa Vector{Float64}
@test median(D1, 10) isa Vector{Float64}
@test middle(D1, 10) isa Vector{Float64}
@test std(D1, 10) isa Vector{Float64}
@test var(D1, 10) isa Vector{Float64}
@test quantile(D1, 0.4, 10) isa Vector{Float64}

@test cor(D1, D2) isa Vector{Float64}
@test cov(D1, D2) isa Vector{Float64}
