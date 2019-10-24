n_draws = 100
grid = 0:10:500
wts = rand(10)
resampling = BinnedMeanWeightedResampling(grid, wts, n_draws)

@test resampling isa BinnedMeanWeightedResampling
@test resampling isa AbstractBinnedSummarisedResampling