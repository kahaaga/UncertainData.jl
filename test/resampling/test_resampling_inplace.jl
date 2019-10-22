val = UncertainValue([1, 2, 3], [0.3, 0.3, 0.3])
val2 = UncertainValue([1, 2, 3], [0.3, 0.3, 0.3])
vals = UncertainValue([val2, val], [1, 2])
val3 = UncertainValue(Normal, 0, 1)



###################################
# Single values
###################################
x = zeros(Float64, 10)

# There should be no zero entries after resampling in place
resample!(x, val)
@test any(x .== 0) == false

resample!(x, vals)
@test any(x .== 0) == false

resample!(x, val3)
@test any(x .== 0) == false

###################################
# Collections into vectors
###################################
v = fill(NaN, length(example_uvals))
resample!(v, example_uvals)
@test any(isnan.(v)) == false

###################################
# Collections into arrays
###################################
arr = fill(NaN, 100, length(example_uvals))
resample!(arr, example_uvals)
@test any(isnan.(arr)) == false


#################################################
# Uncertain index-value collections into vectors
#################################################
ids = UncertainIndexDataset(example_uidxs)
vals = UncertainValueDataset(example_uvals)
U = UncertainIndexValueDataset(ids, vals)

idxs = fill(NaN, length(U))
vals = fill(NaN, length(U))

resample!(idxs, vals, U)

@test any(isnan.(idxs)) == false
@test any(isnan.(vals)) == false

#################################################
# Uncertain index-value collections into arrays
#################################################
ids = UncertainIndexDataset(example_uidxs)
vals = UncertainValueDataset(example_uvals)
U = UncertainIndexValueDataset(ids, vals)

n_draws = 10
idxs = fill(NaN, n_draws, length(U))
vals = fill(NaN, n_draws, length(U))

resample!(idxs, vals, U)

@test any(isnan.(idxs)) == false
@test any(isnan.(vals)) == false



###################################################################################
# Draw N realisations of an uncertain value into vector-like containers of length N
###################################################################################

# A single uncertain value resampled multiple times into a N-element vector
N = 10
x = fill(NaN, 10)

resample!(x, UncertainValue(Normal(0, 1)))
@test any(isnan.(x)) == false

# A single uncertain value resampled multiple times into a N-element MVector
N = 10
x = MVector{N, Float64}(repeat([NaN], N))

resample!(x, UncertainValue(Normal(0, 1)))
@test any(isnan.(x)) == false

# A single uncertain value resampled multiple times into a 3-element FieldVector-type
mutable struct Vector3DType <: FieldVector{3, Float64}
    x::Float64
    y::Float64
    z::Float64
end

x = Vector3DType(NaN, NaN, NaN)

resample!(x, UncertainValue(Normal(0, 1)))
@test any(isnan.(x)) == false

#########################################################################################
# Draw single realisations of N uncertain values into vector-like containers of length N
#########################################################################################

# Three uncertain values resampled element-wise into a 3-element vector
x = repeat([NaN], 3)
resample!(x, val, val, val)
@test any(isnan.(x)) == false

# when the number of elements does not match the number of uncertain values,
# an error should be thrown
x = repeat([NaN], 2)
uval = UncertainValue(Normal(0, 1))
@test_throws ArgumentError resample!(x, uval)

# Three uncertain values resampled element-wise into a 3-element MVector
N = 3
x = MVector{N, Float64}(repeat([NaN], N))
uvals = [UncertainValue([0], [1]), UncertainValue([1], [1]), UncertainValue([2], [1])]
resample!(x, uvals)
@test any(isnan.(x)) == false

# when the number of elements does not match the number of uncertain values
x = MVector{2, Float64}(repeat([NaN], 2))
uval = UncertainValue(Normal(0, 1))
resample!(x, uval)

# Two uncertain values resampled elementwise into a 2-element vector-like type
mutable struct VectorLikeType <: FieldVector{2, Float64}
    x::Float64
    y::Float64
end

x = VectorLikeType(NaN, NaN)
uvals = [UncertainValue([0], [1]), UncertainValue([1], [1])]
resample!(x, uvals)
@test any(isnan.(x)) == false