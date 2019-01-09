import Distributions

# Create an uncertain dataset containing both theoretical values with known parameters, 
# theoretical values with fitted parameters and kernel density estimated distributions.
measurements = [[UncertainValue(Normal, 0, 0.1) for i = 1:5]
                UncertainValue(rand(500))]; 
                #UncertainValue(Normal, rand(Normal(2, 0.35), 10000))]

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
