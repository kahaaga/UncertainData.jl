using Distributions, UncertainData, Combinatorics

# Test all combinations of different types of uncertain values
M = MixtureModel([Normal(3, 0.2), Normal(2, 1)])

r1 = UncertainValue(Normal, rand(), rand())
r2 = UncertainValue(rand(M, 10000))
r3 = UncertainValue(Normal, rand(Normal(4, 3.2), 10000))
r4 = CertainValue(2.2)
r5 = CertainValue(2)

uvals = [r1; r2; r3]

# Find all the different ways of combining two uncertain values in `uvals`.
# We let the order matter, so that if the order of operations for some reason causes 
# things to fail when using different types of uncertain values, the errors are caught.
perms = permutations(1:3, 2) |> collect

# A random number 
x = rand() 

# Number of draws when deviating from default n = 10000
n = 10 

for perm in perms 
    r1, r2 = uvals[perm[1]], uvals[perm[2]]

    # Addition 
    @test r1 + r2 isa AbstractUncertainValue
    @test x + r2 isa AbstractUncertainValue
    @test r1 + x isa AbstractUncertainValue
    @test +(r1, r2, n) isa AbstractUncertainValue
    @test +(x, r2, n) isa AbstractUncertainValue
    @test +(r1, x, n) isa AbstractUncertainValue

    # Subtraction 
    @test r1 - r2 isa AbstractUncertainValue
    @test x - r2 isa AbstractUncertainValue
    @test r1 - x isa AbstractUncertainValue
    @test -(r1, r2, n) isa AbstractUncertainValue
    @test -(x, r2, n) isa AbstractUncertainValue
    @test -(r1, x, n) isa AbstractUncertainValue

    # Multiplication
    @test r1 * r2 isa AbstractUncertainValue
    @test x * r2 isa AbstractUncertainValue
    @test r1 * x isa AbstractUncertainValue
    @test *(r1, r2, n) isa AbstractUncertainValue
    @test *(x, r2, n) isa AbstractUncertainValue
    @test *(r1, x, n) isa AbstractUncertainValue

    # Division
    @test r1 / r2 isa AbstractUncertainValue
    @test x / r2 isa AbstractUncertainValue
    @test r1 / x isa AbstractUncertainValue
    @test /(r1, r2, n) isa AbstractUncertainValue
    @test /(x, r2, n) isa AbstractUncertainValue
    @test /(r1, x, n) isa AbstractUncertainValue

    # Exponentiation
    #@test r1 ^ r2 isa AbstractUncertainValue # implement for complex numbers.
end

# Elementary operations when one or both arguments is a vector of uncertain values 
for val in uvals 
    @test val + uvals isa Vector{<:AbstractUncertainValue}
    @test uvals + val isa Vector{<:AbstractUncertainValue}
    @test uvals + uvals isa Vector{<:AbstractUncertainValue}
end