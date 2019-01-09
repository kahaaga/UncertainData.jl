o1 = UncertainValue(Normal, 0, 0.2)
o2 = UncertainValue(Normal, 1, 0.3)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(rand(Normal(), 1000))

D1 = UncertainDataset([o1, o2, o3, o5])
D2 = UncertainDataset([o1, o2, o4, o5])

##################
# Uncertain values
##################
@test mean(o1) isa Float64
@test median(o1) isa Float64
@test quantile(o1, 0.86) isa Float64
@test std(o1) isa Float64
@test var(o1) isa Float64
@test mean(o1, 10) isa Float64
@test median(o1, 10) isa Float64
@test middle(o1, 10) isa Float64
@test quantile(o1, 0.86, 10) isa Float64
@test std(o1, 10) isa Float64
@test var(o1, 10) isa Float64

#####################
## Uncertain datasets
#####################
@test mean(D1, 10) isa Vector{Float64}
@test median(D1, 10) isa Vector{Float64}
@test middle(D1, 10) isa Vector{Float64}
@test std(D1, 10) isa Vector{Float64}
@test var(D1, 10) isa Vector{Float64}
@test quantile(D1, 0.4, 10) isa Vector{Float64}

@test cor(D1, D2, 10) isa Vector{Float64}
@test cov(D1, D2, 10) isa Vector{Float64}
