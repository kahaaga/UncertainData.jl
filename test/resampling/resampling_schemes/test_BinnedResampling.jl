n_draws = 100
grid = 0:10:500
resampling = BinnedResampling(grid, n_draws)

@test resampling isa BinnedResampling
@test typeof(resampling) <: AbstractBinnedUncertainValueResampling

# Create the resampling scheme. Use kernel density estimates to distribution 
# in each bin.
resampling = BinnedResampling(grid, n_draws, bin_repr = UncertainScalarKDE)
@test resampling isa BinnedResampling{UncertainScalarKDE}
resampling = BinnedResampling(UncertainScalarKDE, grid, n_draws)
@test resampling isa BinnedResampling{UncertainScalarKDE}

# Represent each bin as an equiprobably population 
resampling = BinnedResampling(grid, n_draws, bin_repr = UncertainScalarPopulation)
@test resampling isa BinnedResampling{UncertainScalarPopulation}
resampling = BinnedResampling(UncertainScalarPopulation, grid, n_draws)
@test resampling isa BinnedResampling{UncertainScalarPopulation}

# Keep raw values for each bin (essentially the same as UncertainScalarPopulation,
# but avoids storing an additional vector of weights for the population members).
resampling = BinnedResampling(grid, n_draws, bin_repr = RawValues)
@test resampling isa BinnedResampling{RawValues}
resampling = BinnedResampling(RawValues, grid, n_draws)
@test resampling isa BinnedResampling{RawValues}
