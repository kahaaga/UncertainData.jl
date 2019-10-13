# Note: these function live in the Resampling module, which extends the SamplingConstraints methods

# Add uncertainties to the time series values
n_points = 40
x_uncertain = [UncertainValue(Normal, x, rand(Uniform(0.1, 0.8))) for x in rand(n_points)]
y_uncertain = [UncertainValue(Normal, y, rand(Uniform(0.1, 0.8))) for y in rand(n_points)]
x = UncertainValueDataset(x_uncertain)
y = UncertainValueDataset(y_uncertain)

time_uncertain = [UncertainValue(Normal, i, 1) for i = 1:length(x)];
time_certain = [CertainValue(i) for i = 1:length(x)];
timeinds_x = UncertainIndexDataset(time_uncertain)
timeinds_y = UncertainIndexDataset(time_certain)

X = UncertainIndexValueDataset(timeinds_x, x)
Y = UncertainIndexValueDataset(timeinds_y, y);

# Truncate each of the indices for x at 0.8 their standard deviation around the mean
constraints_x_inds = TruncateStd(0.8)

# Truncate each of the indices for y at 1.5 their standard deviation around the mean
constraints_y_inds = TruncateStd(1.5)

# Truncate each of the values of x at the 20th percentile range
constraints_x_vals = [TruncateQuantiles(0.4, 0.6) for i = 1:length(x)];

# Truncate each of the values of x at the 80th percentile range
constraints_y_vals = [TruncateQuantiles(0.1, 0.9) for i = 1:length(x)];

@test constrain(X.indices, ConstrainedValueResampling(constraints_x_inds)) isa ConstrainedUncertainIndexDataset
@test constrain(X.values, ConstrainedValueResampling(constraints_x_vals)) isa ConstrainedUncertainValueDataset
@test constrain(X, ConstrainedValueResampling(constraints_x_inds), ConstrainedValueResampling(constraints_x_vals)) isa UncertainIndexValueDataset

idxval_resampling = ConstrainedIndexValueResampling((constraints_x_inds, constraints_x_vals))
@test constrain(X, idxval_resampling) isa UncertainIndexValueDataset
@test constrain(X, constraints_x_inds, constraints_x_vals) isa UncertainIndexValueDataset