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
