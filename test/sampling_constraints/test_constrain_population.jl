pop1 = UncertainValue(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3),
        UncertainValue(Uniform, rand(1000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

pop2 = UncertainValue(1:10 |> collect, rand(10))
pop3 = UncertainValue(1.0:10.0 |> collect, Weights(rand(10)))

# Uncertain population consisting of uncertain populations and other stuff
pop4 = UncertainValue([pop1, pop2], [0.1, 0.5])
pop5 = UncertainValue([pop1, pop2, 2, UncertainValue(Normal, -2, 3)], Weights(rand(4)));

uncertain_scalar_populations = [pop1, pop2, pop3, pop4, pop5];

T = Union{Nothing, ConstrainedUncertainScalarPopulation}

@test constrain(pop1, TruncateMinimum(0.2)) isa T
@test constrain(pop1, TruncateMaximum(3.0)) isa T
@test constrain(pop1, TruncateRange(0.0, 3.0)) isa T
@test constrain(pop1, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop1, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop1, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop1, TruncateStd(1)) isa T
@test constrain(pop1, TruncateStd(0.5)) isa T

# pop2.values = [1, 2, 3]
@test constrain(pop2, TruncateMinimum(0.2)) isa T
@test constrain(pop2, TruncateMaximum(2.5)) isa T
@test constrain(pop2, TruncateRange(0.5, 2.5)) isa T
@test constrain(pop2, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop2, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop2, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop2, TruncateStd(1)) isa T
@test constrain(pop2, TruncateStd(0.5)) isa T


# pop3.values = [1.0, 2.0, 3.0]
@test constrain(pop3, TruncateMinimum(0.2)) isa T
@test constrain(pop3, TruncateMaximum(2.5)) isa T
@test constrain(pop3, TruncateRange(0.5, 2.5)) isa T
@test constrain(pop3, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop3, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop3, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop3, TruncateStd(1)) isa T
@test constrain(pop3, TruncateStd(0.5)) isa T

@test constrain(pop4, TruncateMinimum(-10)) isa T
@test constrain(pop4, TruncateMaximum(10)) isa T
@test constrain(pop4, TruncateRange(-10, 10)) isa T
@test constrain(pop4, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop4, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop4, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop4, TruncateStd(1)) isa T
@test constrain(pop4, TruncateStd(0.5)) isa T

@test constrain(pop5, TruncateMinimum(-10)) isa T
@test constrain(pop5, TruncateMaximum(10)) isa T
@test constrain(pop5, TruncateRange(-10, 10)) isa T
@test constrain(pop5, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop5, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop5, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop5, TruncateStd(1)) isa T
@test constrain(pop5, TruncateStd(0.5)) isa T

# Some subpopulations consisting of both scalar values and distributions
subpop1_members = [UncertainValue(Normal, 0, 1), UncertainValue(Uniform, -2, 2), -5]
subpop2_members = [
    UncertainValue(Normal, -2, 1), 
    UncertainValue(Uniform, -6, -1), 
    -3,
    UncertainValue(Gamma, 1, 0.4)]

# Define the probabilities of sampling the different population members within the 
# subpopulations. Weights are normalised, so we can input any numbers here indicating 
# relative importance
subpop1_probs = [1, 2, 1]
subpop2_probs = [0.1, 0.2, 0.3, 0.1]

pop1 = UncertainValue(subpop1_members, subpop1_probs)
pop2 = UncertainValue(subpop2_members, subpop2_probs)

# Define the probabilities of sampling the two subpopulations in the overall population.
pop_probs = [0.3, 0.7]

# Construct overall population
pop_mixed = UncertainValue([pop1, pop2], pop_probs)

@test constrain(pop_mixed, TruncateMinimum(1)) isa T
@test constrain(pop_mixed, TruncateMaximum(2)) isa T
@test constrain(pop_mixed, TruncateRange(1, 2)) isa T
@test constrain(pop_mixed, TruncateQuantiles(0.1, 0.9)) isa T
@test constrain(pop_mixed, TruncateLowerQuantile(0.1)) isa T
@test constrain(pop_mixed, TruncateUpperQuantile(0.9)) isa T
@test constrain(pop_mixed, TruncateStd(1)) isa T
@test constrain(pop_mixed, TruncateStd(0.5)) isa T


# Truncation
#------------------------------------------
pop1 = UncertainValue(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3), 
        UncertainValue(Uniform, rand(1000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

pop2 = UncertainValue([1, 2, 3], rand(3))
pop3 = UncertainValue([1.0, 2.0, 3.0], Weights(rand(3)))

# Uncertain population consisting of uncertain populations and other stuff
pop4 = UncertainValue([pop1, pop2], [0.1, 0.5])
pop5 = UncertainValue([pop1, pop2, 2, UncertainValue(Normal, -2, 3)], Weights(rand(4)));

n = 2000
p = pop1
sb = resample(p, n)

v_min, v_max = -1, 1
r_min, r_max = -1, 1
c_max = TruncateMaximum(v_max)
c_min = TruncateMinimum(v_min)
c_range = TruncateRange(r_min, r_max)
ql, qh = 0.2, 0.8
c_ql = TruncateLowerQuantile(ql)
c_qh = TruncateUpperQuantile(qh)
c_qs = TruncateQuantiles(ql, qh)
c_std = TruncateStd(1.0)

@test truncate(p, c_max) isa T
@test truncate(p, c_min) isa T
@test truncate(p, c_range) isa T
@test truncate(p, c_ql) isa T
@test truncate(p, c_qh) isa T
@test truncate(p, c_qs) isa T
@test truncate(p, c_std) isa T

n = 2000
p = pop2
sb = resample(p, n)

v_min, v_max = -1, 1
r_min, r_max = -1, 1
c_max = TruncateMaximum(v_max)
c_min = TruncateMinimum(v_min)
c_range = TruncateRange(r_min, r_max)
ql, qh = 0.2, 0.8
c_ql = TruncateLowerQuantile(ql)
c_qh = TruncateUpperQuantile(qh)
c_qs = TruncateQuantiles(ql, qh)
c_std = TruncateStd(1.0)

@test truncate(p, c_max) isa T
@test truncate(p, c_min) isa T
@test truncate(p, c_range) isa T
@test truncate(p, c_ql) isa T
@test truncate(p, c_qh) isa T
@test truncate(p, c_qs) isa T
@test truncate(p, c_std) isa T

n = 2000
p = pop3
sb = resample(p, n)

v_min, v_max = -1, 1
r_min, r_max = -1, 1
c_max = TruncateMaximum(v_max)
c_min = TruncateMinimum(v_min)
c_range = TruncateRange(r_min, r_max)
ql, qh = 0.2, 0.8
c_ql = TruncateLowerQuantile(ql)
c_qh = TruncateUpperQuantile(qh)
c_qs = TruncateQuantiles(ql, qh)
c_std = TruncateStd(1.0)

@test truncate(p, c_max) isa T
@test truncate(p, c_min) isa T
@test truncate(p, c_range) isa T
@test truncate(p, c_ql) isa T
@test truncate(p, c_qh) isa T
@test truncate(p, c_qs) isa T
@test truncate(p, c_std) isa T

n = 2000
p = pop4
sb = resample(p, n)

v_min, v_max = -2, 2
r_min, r_max = -2, 2
c_max = TruncateMaximum(v_max)
c_min = TruncateMinimum(v_min)
c_range = TruncateRange(r_min, r_max)
ql, qh = 0.2, 0.8
c_ql = TruncateLowerQuantile(ql)
c_qh = TruncateUpperQuantile(qh)
c_qs = TruncateQuantiles(ql, qh)
c_std = TruncateStd(1.0)

@test truncate(p, c_max) isa T
@test truncate(p, c_min) isa T
@test truncate(p, c_range) isa T
@test truncate(p, c_ql) isa T
@test truncate(p, c_qh) isa T
@test truncate(p, c_qs) isa T
@test truncate(p, c_std) isa T

n = 2000
p = pop5
sb = resample(p, n)

v_min, v_max = -2, 2
r_min, r_max = -2, 2
c_max = TruncateMaximum(v_max)
c_min = TruncateMinimum(v_min)
c_range = TruncateRange(r_min, r_max)
ql, qh = 0.2, 0.8
c_ql = TruncateLowerQuantile(ql)
c_qh = TruncateUpperQuantile(qh)
c_qs = TruncateQuantiles(ql, qh)
c_std = TruncateStd(1.0)

@test truncate(p, c_max) isa T
@test truncate(p, c_min) isa T
@test truncate(p, c_range) isa T
@test truncate(p, c_ql) isa T
@test truncate(p, c_qh) isa T
@test truncate(p, c_qs) isa T
@test truncate(p, c_std) isa T

pop1 = UncertainValue(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3),
        UncertainValue(Uniform, rand(10000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

pop2 = UncertainValue([1, 2, 3], rand(3))
pop3 = UncertainValue([1.0, 2.0, 3.0], Weights(rand(3)))

# Uncertain population consisting of uncertain populations and other stuff
pop4 = UncertainValue([pop1, pop2], [0.1, 0.5])
pop5 = UncertainValue([pop1, pop2, 2, UncertainValue(Normal, -2, 3)], Weights(rand(4)));

uncertain_scalar_populations = [pop1, pop2, pop3, pop4, pop5];


@test constrain(pop1, TruncateMinimum(0.2)) isa T
@test constrain(pop1, TruncateMaximum(3.0)) isa T
@test constrain(pop1, TruncateRange(0.0, 3.0)) isa T
@test constrain(pop1, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop1, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop1, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop1, TruncateStd(1)) isa T

# pop2.values = [1, 2, 3]
@test constrain(pop2, TruncateMinimum(0.2)) isa T
@test constrain(pop2, TruncateMaximum(2.5)) isa T
@test constrain(pop2, TruncateRange(0.5, 2.5)) isa T
@test constrain(pop2, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop2, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop2, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop2, TruncateStd(1)) isa T

# pop3.values = [1.0, 2.0, 3.0]
@test constrain(pop3, TruncateMinimum(0.2)) isa T
@test constrain(pop3, TruncateMaximum(2.5)) isa T
@test constrain(pop3, TruncateRange(0.5, 2.5)) isa T
@test constrain(pop3, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop3, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop3, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop3, TruncateStd(1)) isa T

@test constrain(pop4, TruncateMinimum(-10)) isa T
@test constrain(pop4, TruncateMaximum(10)) isa T
@test constrain(pop4, TruncateRange(-10, 10)) isa T
@test constrain(pop4, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop4, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop4, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop4, TruncateStd(1)) isa T

@test constrain(pop5, TruncateMinimum(-10)) isa T
@test constrain(pop5, TruncateMaximum(10)) isa T
@test constrain(pop5, TruncateRange(-10, 10)) isa T
@test constrain(pop5, TruncateLowerQuantile(0.2)) isa T
@test constrain(pop5, TruncateUpperQuantile(0.8)) isa T
@test constrain(pop5, TruncateQuantiles(0.2, 0.8)) isa T
@test constrain(pop5, TruncateStd(1)) isa T

# Some subpopulations consisting of both scalar values and distributions
subpop1_members = [UncertainValue(Normal, 0, 1), UncertainValue(Uniform, -2, 2), -5]
subpop2_members = [
    UncertainValue(Normal, -2, 1), 
    UncertainValue(Uniform, -6, -1), 
    -3,
    UncertainValue(Gamma, 1, 0.4)]

# Define the probabilities of sampling the different population members within the 
# subpopulations. Weights are normalised, so we can input any numbers here indicating 
# relative importance
subpop1_probs = [1, 2, 1]
subpop2_probs = [0.1, 0.2, 0.3, 0.1]
pop1 = UncertainValue(subpop1_members, subpop1_probs)
pop2 = UncertainValue(subpop2_members, subpop2_probs)

# Define the probabilities of sampling the two subpopulations in the overall population.
pop_probs = [0.3, 0.7]

# Construct overall population
pop_mixed = UncertainValue([pop1, pop2], pop_probs)

@test constrain(pop_mixed, TruncateMinimum(1)) isa T
@test constrain(pop_mixed, TruncateMaximum(2)) isa T
@test constrain(pop_mixed, TruncateRange(1, 2)) isa T
@test constrain(pop_mixed, TruncateQuantiles(0.1, 0.9)) isa T
@test constrain(pop_mixed, TruncateLowerQuantile(0.1)) isa T
@test constrain(pop_mixed, TruncateUpperQuantile(0.9)) isa T
@test constrain(pop_mixed, TruncateStd(1)) isa T