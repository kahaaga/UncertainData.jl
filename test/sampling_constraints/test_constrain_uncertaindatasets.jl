measurements = [UncertainValue(Normal, 0, 0.1) for i = 1:5]
measurements = [measurements; UncertainValue(rand(100))]

d = UncertainDataset(measurements)

@test constrain(d, NoConstraint()) isa ConstrainedUncertainDataset
@test constrain(d, TruncateLowerQuantile(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateUpperQuantile(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateQuantiles(0.2, 0.6)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateMaximum(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateMinimum(0.2)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateRange(0.2, 0.6)) isa ConstrainedUncertainDataset
@test constrain(d, TruncateStd(1)) isa ConstrainedUncertainDataset
