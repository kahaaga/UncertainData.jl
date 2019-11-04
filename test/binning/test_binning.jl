using StatsBase

xs = sort(rand(1000))
ys = diff(rand(1001));
T = eltype(ys)

g = -0.3:0.025:1.2
nbins = length(g) - 1

ybinned = bin(median, g, xs, ys)
@test length(ybinned) == nbins
@test ybinned isa Vector{T}

ybinned = bin(quantile, g, xs, ys, [0.5])
@test length(ybinned) == nbins
@test ybinned isa Vector{T}

ybinned = bin_mean(g, xs, ys)
@test ybinned isa Vector
@test length(ybinned) == nbins