using Distributions, UncertainData, Combinatorics

# Test all combinations of different types of uncertain values
M = MixtureModel([Normal(3, 0.2), Normal(2, 1)])

r1 = UncertainValue(Normal, rand(), rand())
r2 = UncertainValue(rand(M, 10000))
r3 = UncertainValue(Normal, rand(Normal(4, 3.2), 10000))

uvals = [r1; r2; r3]

a = UncertainDataset(uvals)
b = UncertainDataset(uvals[end:-1:1])
N = length(a)

###########
# Addition 
###########
@test a + b isa UncertainDataset
@test 2 + b isa UncertainDataset
@test [2 for i = 1:N] + b isa UncertainDataset
@test 2.2 + b isa UncertainDataset
@test [2.2 for i = 1:N] + b isa UncertainDataset
@test a + [2 for i = 1:N] isa UncertainDataset
@test a + [2.2 for i = 1:N] isa UncertainDataset

#############
# Subtraction
#############
@test a - b isa UncertainDataset
@test 2 - b isa UncertainDataset
@test [2 for i = 1:N] - b isa UncertainDataset
@test 2.2 - b isa UncertainDataset
@test [2.2 for i = 1:N] - b isa UncertainDataset
@test a - [2 for i = 1:N] isa UncertainDataset
@test a - [2.2 for i = 1:N] isa UncertainDataset

################
# Multiplication
################
@test a * b isa UncertainDataset
@test 2 * b isa UncertainDataset
@test [2 for i = 1:N] * b isa UncertainDataset
@test 2.2 * b isa UncertainDataset
@test [2.2 for i = 1:N] * b isa UncertainDataset
@test a * [2 for i = 1:N] isa UncertainDataset
@test a * [2.2 for i = 1:N] isa UncertainDataset


################
# Division
################
@test a * b isa UncertainDataset
@test 2 * b isa UncertainDataset
@test [2 for i = 1:N] * b isa UncertainDataset
@test 2.2 * b isa UncertainDataset
@test [2.2 for i = 1:N] * b isa UncertainDataset
@test a * [2 for i = 1:N] isa UncertainDataset
@test a * [2.2 for i = 1:N] isa UncertainDataset


################
# Exponentiation
################
@test a * b isa UncertainDataset
@test 2 * b isa UncertainDataset
@test [2 for i = 1:N] * b isa UncertainDataset
@test 2.2 * b isa UncertainDataset
@test [2.2 for i = 1:N] * b isa UncertainDataset
@test a * [2 for i = 1:N] isa UncertainDataset
@test a * [2.2 for i = 1:N] isa UncertainDataset