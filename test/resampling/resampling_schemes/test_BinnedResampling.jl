n_draws = 100
grid = 0:10:500
resampling = BinnedResampling(grid, n_draws)

@test resampling isa BinnedResampling