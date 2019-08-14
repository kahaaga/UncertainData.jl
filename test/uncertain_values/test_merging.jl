import StatsBase: ProbabilityWeights, pweights

v1 = UncertainValue(UnivariateKDE, rand(4:0.25:6, 1000), bandwidth = 0.01)
v2 = UncertainValue(Normal, 0.8, 0.4)
v3 = UncertainValue([rand() for i = 1:3], [0.3, 0.3, 0.4])
v4 = UncertainValue(Normal, 3.7, 0.8)
uvals = [v1, v2, v3, v4];

# Combining without weights
r1 = combine(uvals)
r2 = combine(uvals, n = 10000)
@test r1 isa AbstractUncertainValue
@test r2 isa AbstractUncertainValue

# Combining with ProbabilityWeights
r1 = combine(uvals, ProbabilityWeights([0.2, 0.1, 0.3, 0.2]))
r2 = combine(uvals, pweights([0.2, 0.1, 0.3, 0.2]))
@test r1 isa AbstractUncertainValue
@test r2 isa AbstractUncertainValue

# Combining with AnalyticWeights
combine(uvals, AnalyticWeights([0.2, 0.1, 0.3, 0.2]))
combine(uvals, aweights([0.2, 0.1, 0.3, 0.2]))
@test r1 isa AbstractUncertainValue
@test r2 isa AbstractUncertainValue

# Combining with FrequencyWeights
combine(uvals, FrequencyWeights([100, 200, 300, 400]))
combine(uvals, fweights([500, 700, 800, 124]))
@test r1 isa AbstractUncertainValue
@test r2 isa AbstractUncertainValue

# Combining with generic Weights
r1 = combine(uvals, Weights([0.2, 0.1, 0.3, 0.2]))
@test r1 isa AbstractUncertainValue
