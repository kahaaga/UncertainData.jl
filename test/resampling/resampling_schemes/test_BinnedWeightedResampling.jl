n_draws = 100
grid = 0:10:500
wts = Weights(rand(10))
resampling = BinnedWeightedResampling(grid, wts, n_draws)

@test resampling isa BinnedResampling