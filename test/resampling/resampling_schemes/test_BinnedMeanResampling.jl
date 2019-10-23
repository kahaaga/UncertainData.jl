n_draws = 100
grid = 0:10:500
resampling = BinnedMeanResampling(grid, n_draws)

@test resampling isa BinnedMeanResampling