o1 = UncertainValue(0, 0.5, Normal)
o2 = UncertainValue(2.0, 0.1, Normal)
o3 = UncertainValue(0, 4, Uniform)
o4 = UncertainValue(rand(100), Uniform)
o5 = UncertainValue(4, 5, Beta)
o6 = UncertainValue(4, 5, Gamma)
o7 = UncertainValue(1, 2, Frechet)
o8 = UncertainValue(1, 2, BetaPrime)
o9 = UncertainValue(10, 3, 2, BetaBinomial)
o10 = UncertainValue(10, 0.3, Binomial)


@test realise(o1) isa Float64
@test realise(o2) isa Float64
@test realise(o3) isa Float64
@test realise(o4) isa Float64
@test realise(o5) isa Float64
@test realise(o6) isa Float64
@test realise(o7) isa Float64
@test realise(o8) isa Float64
@test realise(o9) isa Int
@test realise(o10) isa Int


D = UncertainDataset([o1, o2, o3, o4, o5, o6, o7, o8, o9, o10])
UV = UncertainValueDataset(D)
UIV = UncertainIndexValueDataset(D, D)

n = length(D)
@test realise(D) isa SArray{Tuple{n}, Float64, 1, n}
@test realise(UV) isa SArray{Tuple{n}, Float64, 1, n}

@test realise(D, 10) isa Vector{SArray{Tuple{n},Float64,1,n}}
@test realise(UV, 10) isa Vector{SArray{Tuple{n},Float64,1,n}}
@test realise(UIV, 10) isa Vector{SArray{Tuple{n},Float64,1,n}}
