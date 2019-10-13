N = 10
#################################
# ConstrainedIndexValueResampling
#################################

# Truncate each of the indices for x at 0.8 their standard deviation around the mean
constraints_x_inds = TruncateStd(0.8)

# Truncate each of the indices for y at 1.5 their standard deviation around the mean
constraints_y_inds = TruncateStd(1.5)

# Truncate each of the values of x at the 20th percentile range
constraints_x_vals = [TruncateQuantiles(0.4, 0.6) for i = 1:N];

# Truncate each of the values of x at the 80th percentile range
constraints_y_vals = [TruncateQuantiles(0.1, 0.9) for i = 1:N];

cs_x = (constraints_x_inds, constraints_x_vals)
cs_y = (constraints_y_inds, constraints_y_vals)

resampling_idxval_scheme = ConstrainedIndexValueResampling(cs_x, cs_y, cs_x)

@test length(resampling_idxval_scheme) == 3

# There should be two 
@test length(resampling_idxval_scheme[1]) == 2
@test length(resampling_idxval_scheme[2]) == 2
@test resampling_idxval_scheme[1][1] isa SamplingConstraint
@test resampling_idxval_scheme[1][2] isa Vector{<:SamplingConstraint}
@test length(resampling_idxval_scheme[1][2]) == N
@test resampling_idxval_scheme[2][1] isa SamplingConstraint
@test resampling_idxval_scheme[2][2] isa Vector{<:SamplingConstraint}
@test length(resampling_idxval_scheme[2][2]) == N
@test resampling_idxval_scheme.n == 1

resampling_idxval_scheme = ConstrainedIndexValueResampling(105, cs_x, cs_y)
@test resampling_idxval_scheme.n == 105