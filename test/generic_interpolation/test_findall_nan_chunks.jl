
# 1 NaN chunk, no NaNs at edges
x  = [1.0, 2.0, NaN, NaN, 2.3, 5.6]
fs = findall_nan_chunks(x)

@test length(fs) == 1
@test fs[1] == (3, 4)

# > 1 NaN chunk, no NaNs at edges

x  = [1.0, 2.0, NaN, NaN, 2.3, 5.6, NaN, NaN, NaN, 2.0]
fs = findall_nan_chunks(x)
@test length(findall_nan_chunks(x)) == 2
@test fs[1] == (3, 4)
@test fs[2] == (7, 9)

# NaN chunk at left boundary
x = [NaN, 1.0, 2.0, NaN, NaN, 2.3, 5.6, NaN, NaN, NaN, 2.0]
fs = findall_nan_chunks(x)
fs[1] == (1, 1)
fs[2] == (4, 5)
fs[3] == (8, 10)

# NaN chunk at right boundary
x = [2.3, 5.6, NaN, NaN, NaN]
fs = findall_nan_chunks(x)
fs[1] == (3, 5)

# The number of NaNs in the ranges matches the total number of NaNs 
x = rand(10000)
x[rand(1:1000, 1000)] .= NaN
tupdiff(t::Tuple{Int, Int}) = t[2] - t[1]
sum(tupdiff.(findall_nan_chunks(x)) .+ 1) == length(findall(isnan.(x)))

# In-place method matches regular method
v = zeros(Bool, length(x));
findall_nan_chunks!(v, x) == findall_nan_chunks(x)