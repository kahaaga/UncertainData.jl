using Distributions, UncertainData, Combinatorics

# Test all combinations of different types of uncertain values
M = MixtureModel([Normal(3, 0.2), Normal(2, 1)])

r1 = UncertainValue(Normal, rand(), rand())
r2 = UncertainValue(rand(M, 10000))
r3 = UncertainValue(Normal, rand(Normal(4, 3.2), 10000))

uvals = [r1; r2; r3]

a = UncertainValueDataset(uvals)
b = UncertainValueDataset(uvals[end:-1:1])
N = length(a)

###########
# Addition 
###########
@test a + b isa UncertainValueDataset
@test 2 + b isa UncertainValueDataset
@test [2 for i = 1:N] + b isa UncertainValueDataset
@test 2.2 + b isa UncertainValueDataset
@test [2.2 for i = 1:N] + b isa UncertainValueDataset
@test a + [2 for i = 1:N] isa UncertainValueDataset
@test a + [2.2 for i = 1:N] isa UncertainValueDataset

#############
# Subtraction
#############
@test a - b isa UncertainValueDataset
@test 2 - b isa UncertainValueDataset
@test [2 for i = 1:N] - b isa UncertainValueDataset
@test 2.2 - b isa UncertainValueDataset
@test [2.2 for i = 1:N] - b isa UncertainValueDataset
@test a - [2 for i = 1:N] isa UncertainValueDataset
@test a - [2.2 for i = 1:N] isa UncertainValueDataset

################
# Multiplication
################
@test a * b isa UncertainValueDataset
@test 2 * b isa UncertainValueDataset
@test [2 for i = 1:N] * b isa UncertainValueDataset
@test 2.2 * b isa UncertainValueDataset
@test [2.2 for i = 1:N] * b isa UncertainValueDataset
@test a * [2 for i = 1:N] isa UncertainValueDataset
@test a * [2.2 for i = 1:N] isa UncertainValueDataset


################
# Division
################
@test a * b isa UncertainValueDataset
@test 2 * b isa UncertainValueDataset
@test [2 for i = 1:N] * b isa UncertainValueDataset
@test 2.2 * b isa UncertainValueDataset
@test [2.2 for i = 1:N] * b isa UncertainValueDataset
@test a * [2 for i = 1:N] isa UncertainValueDataset
@test a * [2.2 for i = 1:N] isa UncertainValueDataset


################
# Exponentiation
################
@test a * b isa UncertainValueDataset
@test 2 * b isa UncertainValueDataset
@test [2 for i = 1:N] * b isa UncertainValueDataset
@test 2.2 * b isa UncertainValueDataset
@test [2.2 for i = 1:N] * b isa UncertainValueDataset
@test a * [2 for i = 1:N] isa UncertainValueDataset
@test a * [2.2 for i = 1:N] isa UncertainValueDataset