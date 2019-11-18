n_draws = 100
grid = 0:10:500
wts = Weights(rand(10))
resampling = BinnedWeightedResampling(grid, wts, n_draws)

@test resampling isa BinnedWeightedResampling
@test typeof(resampling) <: AbstractBinnedUncertainValueResampling

# Create the resampling scheme. Use kernel density estimates to distribution 
# in each bin.
resampling = BinnedWeightedResampling(grid, wts, n_draws, bin_repr = UncertainScalarKDE)
@test resampling isa BinnedWeightedResampling{UncertainScalarKDE}
resampling = BinnedWeightedResampling(UncertainScalarKDE, grid, wts, n_draws)
@test resampling isa BinnedWeightedResampling{UncertainScalarKDE}

# Represent each bin as an equiprobably population 
resampling = BinnedWeightedResampling(grid, wts, n_draws, bin_repr = UncertainScalarPopulation)
@test resampling isa BinnedWeightedResampling{UncertainScalarPopulation}
resampling = BinnedWeightedResampling(UncertainScalarPopulation, grid, wts, n_draws)
@test resampling isa BinnedWeightedResampling{UncertainScalarPopulation}

# Keep raw values for each bin (essentially the same as UncertainScalarPopulation,
# but avoids storing an additional vector of weights for the population members).
resampling = BinnedWeightedResampling(grid, wts, n_draws, bin_repr = RawValues)
@test resampling isa BinnedWeightedResampling{RawValues}
resampling = BinnedWeightedResampling(RawValues, grid, wts, n_draws)
@test resampling isa BinnedWeightedResampling{RawValues}
