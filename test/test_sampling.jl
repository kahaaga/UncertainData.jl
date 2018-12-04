o1 = UncertainValue(0, -5, 5, Normal)
o2 = UncertainValue(2, 0, 4, Normal)
o3 = UncertainValue(0, 4, Uniform)
o4 = UncertainEmpiricalValue(rand(100), Uniform)

@test realise(o1) isa Float64
@test realise(o2) isa Float64
@test realise(o3) isa Float64
@test realise(o4) isa Float64


D = UncertainDataset([o1, o2, o3])
UV = UncertainValueDataset(D)
UIV = UncertainIndexValueDataset(D, D)

@test realise(D) isa SArray{Tuple{3}, Float64, 1, 3}
@test realise(UV) isa SArray{Tuple{3}, Float64, 1, 3}

@test realise(D, 10) isa Vector{SArray{Tuple{3},Float64,1,3}}
@test realise(UV, 10) isa Vector{SArray{Tuple{3},Float64,1,3}}
@test realise(UIV, 10) isa Vector{SArray{Tuple{3},Float64,1,3}}
