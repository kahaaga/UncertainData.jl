###########################################################
# SequentialResampling and SequentialInterpolatedResampling
###########################################################

N = 50
x_uncertain = [UncertainValue(Normal, x, rand(Uniform(0.1, 0.8))) for x in rand(N)]
y_uncertain = [UncertainValue(Normal, y, rand(Uniform(0.1, 0.8))) for y in rand(N)]
x = UncertainValueDataset(x_uncertain)
y = UncertainValueDataset(y_uncertain)

time_uncertain = [UncertainValue(Normal, i, 1) for i = 1:length(x)];
time_certain = [CertainValue(i) for i = 1:length(x)];
timeinds_x = UncertainIndexDataset(time_uncertain)
timeinds_y = UncertainIndexDataset(time_certain)

X = UncertainIndexValueDataset(timeinds_x, x)
Y = UncertainIndexValueDataset(timeinds_y, y);

seq = SequentialResampling(StrictlyIncreasing())
seq_intp = SequentialInterpolatedResampling(StrictlyIncreasing(), RegularGrid(0, N, 2))

@test resample(X, seq) isa NTuple{2, Vector{<:Real}}
@test resample(X, seq)[1] |> length == N
@test resample(X, seq)[2] |> length == N
@test resample(X, seq_intp) isa Tuple{AbstractRange, Vector{<:Real}}
@test resample(X, seq_intp)[1] |> length == length(0:2:N)
@test resample(X, seq_intp)[2] |> length == length(0:2:N)

@test resample(Y, seq) isa NTuple{2, Vector{<:Real}}
@test resample(Y, seq)[1] |> length == N
@test resample(Y, seq)[2] |> length == N
@test resample(Y, seq_intp) isa Tuple{AbstractRange, Vector{<:Real}}
@test resample(Y, seq_intp)[1] |> length == length(0:2:N)
@test resample(Y, seq_intp)[2] |> length == length(0:2:N)

# Add uncertainties to the time series values
x_uncertain = [UncertainValue(Normal, x, rand(Uniform(0.1, 0.8))) for x in rand(N)]
y_uncertain = [UncertainValue(Normal, y, rand(Uniform(0.1, 0.8))) for y in rand(N)]
x = UncertainValueDataset(x_uncertain)
y = UncertainValueDataset(y_uncertain)

time_uncertain = [UncertainValue(Normal, i, 1) for i = 1:length(x)];
time_certain = [CertainValue(i) for i = 1:length(x)];
timeinds_x = UncertainIndexDataset(time_uncertain)
timeinds_y = UncertainIndexDataset(time_certain)

X = UncertainIndexValueDataset(timeinds_x, x)
Y = UncertainIndexValueDataset(timeinds_y, y);

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