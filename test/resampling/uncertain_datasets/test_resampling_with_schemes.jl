################
# Example data 
################
N = 50
x_uncertain = [UncertainValue(Normal, x, rand(Uniform(0.1, 0.8))) for x in rand(N)]
y_uncertain = [UncertainValue(Normal, y, rand(Uniform(0.1, 0.8))) for y in rand(N)]
x = UncertainValueDataset(x_uncertain)
y = UncertainValueDataset(y_uncertain)

time_uncertain = [UncertainValue(Normal, i, 1) for i = 1:length(x)];
time_certain = [CertainScalar(i) for i = 1:length(x)];
timeinds_x = UncertainIndexDataset(time_uncertain)
timeinds_y = UncertainIndexDataset(time_certain)

X = UncertainIndexValueDataset(timeinds_x, x)
Y = UncertainIndexValueDataset(timeinds_y, y);

###########################################################
# SequentialResampling
###########################################################
seq = SequentialResampling(StrictlyIncreasing())

@test resample(X, seq) isa NTuple{2, Vector{<:Real}}
@test resample(X, seq)[1] |> length == N
@test resample(X, seq)[2] |> length == N
@test resample(Y, seq) isa NTuple{2, Vector{<:Real}}
@test resample(Y, seq)[1] |> length == N
@test resample(Y, seq)[2] |> length == N

###########################################################
# SequentialInterpolatedResampling
###########################################################
seq_intp = SequentialInterpolatedResampling(StrictlyIncreasing(), RegularGrid(0, N, 2))

@test resample(X, seq_intp) isa Tuple{AbstractRange, Vector{<:Real}}
@test resample(X, seq_intp)[1] |> length == length(0:2:N)
@test resample(X, seq_intp)[2] |> length == length(0:2:N)
@test resample(Y, seq_intp) isa Tuple{AbstractRange, Vector{<:Real}}
@test resample(Y, seq_intp)[1] |> length == length(0:2:N)
@test resample(Y, seq_intp)[2] |> length == length(0:2:N)

#################################
# ConstrainedValueResampling
#################################

c = ConstrainedValueResampling(10, TruncateStd(1))

r = resample(timeinds_y, c)
@test length(r) == c.n
@test length(r[1]) == N

r = resample(timeinds_x, c)
@test length(r) == c.n
@test length(r[1]) == N

r = resample(x, c)
@test length(r) == c.n
@test length(r[1]) == N

r = resample(y, c)
@test length(r) == c.n
@test length(r[1]) == N

#################################
# ConstrainedIndexValueResampling
#################################

c = ConstrainedIndexValueResampling(10, (TruncateStd(1), TruncateStd(1)))
rx = resample(X, c)
ry = resample(Y, c)

@test rx isa Vector{Tuple{Vector{Float64},Vector{Float64}}}
@test ry isa Vector{Tuple{Vector{Float64},Vector{Float64}}}

@test length(rx) == c.n
@test length(ry) == c.n
@test length(rx[1]) == 2
@test length(ry[1]) == 2
@test length(rx[1][1]) == N
@test length(ry[1][2]) == N
@test length(rx[2][1]) == N
@test length(ry[2][2]) == N