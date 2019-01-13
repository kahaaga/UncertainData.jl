import Distributions

using Distributions, UncertainData 

# Create an uncertain dataset containing both theoretical values with known parameters, 
# theoretical values with fitted parameters and kernel density estimated distributions.
u1 = UncertainValue(Gamma, rand(Gamma(), 500))
u2 = UncertainValue(rand(MixtureModel([Normal(1, 0.3), Normal(-3, 3)]), 500))
uvals3 = [UncertainValue(Normal, rand(), rand()) for i = 1:11]
measurements = [u1; u2; uvals3]
d = UncertainValueDataset(measurements)

# Test all available constraints 
constraints = [
    NoConstraint(),
    TruncateLowerQuantile(0.2),
    TruncateUpperQuantile(0.3),
    TruncateQuantiles(0.2, 0.6),
    TruncateMaximum(0.2),
    TruncateMinimum(0.2),
    TruncateRange(0.2, 0.6),
    TruncateStd(1)
]

for i = 1:length(constraints)
    
    # A single constraint applied to all values in the dataset 
    @test constrain(d, constraints[i]) isa ConstrainedUncertainValueDataset

    # Element-wise application of different constraints to the values in the dataset 
    @test constrain(d, [constraints[i] for k = 1:length(d)]) isa ConstrainedUncertainValueDataset

    # Constraining constrained datasets (might be nested several times)
    constrained_dataset = constrain(d, constraints[i])
    @test constrain(constrained_dataset, constraints[i]) isa ConstrainedUncertainValueDataset
    @test constrain(constrained_dataset, [constraints[i] for k = 1:length(d)]) isa ConstrainedUncertainValueDataset

end