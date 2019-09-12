# Define some example data 
import KernelDensity.UnivariateKDE
o1 = UncertainValue(Normal, 0, 0.5)
o2 = UncertainValue(Normal, 2.0, 0.1)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(Beta, 4, 5)
o6 = UncertainValue(Gamma, 4, 5)
o7 = UncertainValue(Frechet, 1, 2)
o8 = UncertainValue(BetaPrime, 1, 2)
o9 = UncertainValue(BetaBinomial, 10, 3, 2)
o10 = UncertainValue(Binomial, 10, 0.3)
o11 = UncertainValue(rand(100), rand(100))
o12 = UncertainValue(2)
o13 = UncertainValue(2.3)
o14 = UncertainValue([2, 3, 4], [0.3, 0.4, 0.3])
o15 = UncertainValue([rand() for i = 1:100])


uvals1 = [o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, o14, o1, o2, o3, o15, o4, o5, 
    o6, o7, o8, o9, o11, o12, o13, o14, o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, 
    o14, o1, o2, o3, o4, o5, o6, o7, o8, o9, o11, o12, o13, o14]

uvals2 = [uvals1[i] for i in [rand(1:length(uvals1)) for i = 1:length(uvals1)]]

idxs = UncertainIndexDataset([UncertainValue(Normal, i, 0.8) for i = 1:length(uvals1)])

UVD = UncertainValueDataset(uvals1)
UD = UncertainDataset(uvals2)
UIDX = UncertainIndexDataset(idxs)
UV = UncertainValueDataset(uvals1)

# Resampling interface should work for all subtypes of AbstractUncertainValueDataset,
# both with and without sampling constraints.
# We need to check UncertainDataset, UncertainIndexDataset, and UncertainValueDataset.

n = 3

#resample_elwise(uvd::AbstractUncertainValueDataset, n::Int)
@test length(resample_elwise(UIDX, n)) == length(UIDX)
@test length(resample_elwise(UIDX, n)[1]) == n
@test length(resample_elwise(UD, n)) == length(UD)
@test length(resample_elwise(UD, n)[1]) == n
@test length(resample_elwise(UVD, n)) == length(UVD)
@test length(resample_elwise(UVD, n)[1]) == n

@test length(resample_elwise(UVD)[1]) == 1
@test length(resample_elwise(UVD)) == length(UVD)

n = 5
@test length(resample_elwise(UD, [TruncateQuantiles(0.1, 0.9) for i = 1:length(UD)], n)) == length(UD)
@test length(resample_elwise(UD, [TruncateQuantiles(0.1, 0.9) for i = 1:length(UD)], n)[1]) == n
@test length(resample_elwise(UVD, [TruncateQuantiles(0.1, 0.9) for i = 1:length(UVD)], n)) == length(UD)
@test length(resample_elwise(UVD, [TruncateQuantiles(0.1, 0.9) for i = 1:length(UVD)], n)[1]) == n
@test length(resample_elwise(UIDX, [TruncateQuantiles(0.1, 0.9) for i = 1:length(UIDX)], n)) == length(UD)
@test length(resample_elwise(UIDX, [TruncateQuantiles(0.1, 0.9) for i = 1:length(UIDX)], n)[1]) == n

# resample_elwise(uvd::AbstractUncertainValueDataset, constraint::SamplingConstraint, n::Int)
@test length(resample_elwise(UIDX, TruncateQuantiles(0.1, 0.9), n)) == length(UIDX)
@test length(resample_elwise(UIDX, TruncateQuantiles(0.1, 0.9), n)[1]) == n
@test length(resample_elwise(UD, TruncateQuantiles(0.1, 0.9), n)) == length(UD)
@test length(resample_elwise(UD, TruncateQuantiles(0.1, 0.9), n)[1]) == n
@test length(resample_elwise(UVD, TruncateQuantiles(0.1, 0.9), n)) == length(UVD)
@test length(resample_elwise(UVD, TruncateQuantiles(0.1, 0.9), n)[1]) == n