import Distributions

using Distributions, UncertainData 

# Create an uncertain dataset containing both theoretical values with known parameters, 
# theoretical values with fitted parameters and kernel density estimated distributions.
u1 = UncertainValue(Gamma, rand(Gamma(), 500))
u2 = UncertainValue(rand(MixtureModel([Normal(1, 0.3), Normal(-3, 3)]), 500))
uvals3 = [UncertainValue(Normal, rand(), rand()) for i = 1:11]

measurements = [u1; u2; uvals3]
d = UncertainDataset(measurements)

# Test that constraining work for all available constraints, applying the same 
# constraint to all uncertain values in the dataset
@test constrain(d, NoConstraint()) isa ConstrainedUncertainDataset
@test constrain(d, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateUpperQuantile(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateQuantiles(0.2, 0.6)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateMaximum(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateMinimum(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateRange(0.2, 0.6)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateStd(1)) isa ConstrainedUncertainDataset

n = length(d)


# Test that constraining work for all available constraints, applying a different constraint 
# to each uncertain value in the dataset
@test constrain(d, [NoConstraint() for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateQuantiles(0.2, 0.8) for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateLowerQuantile(0.2) for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateUpperQuantile(0.2) for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateMaximum(0.2) for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateMinimum(0.2) for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateRange(0.2, 0.6) for i = 1:length(d)]) isa ConstrainedUncertainDataset
@test constrain(d, [TruncateStd(1) for i = 1:length(d)]) isa ConstrainedUncertainDataset


@test constrain(d, [NoConstraint(); [TruncateQuantiles(0.2, 0.8) for i = 1:(n-1)]]) isa ConstrainedUncertainDataset
