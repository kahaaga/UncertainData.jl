using HypothesisTests, UncertainData, Distributions

# Single uncertain values
uval1 = UncertainValue(Normal, 0, 0.2)
uval2 = UncertainValue(Beta, 1, 2)

xs = [UncertainValue(Normal, 0, rand()) for i = 1:10]
ys = [UncertainValue(Gamma, rand(Uniform(2, 3)), rand(Uniform(4, 5))) for i = 1:10]

x = UncertainDataset(xs)
y = UncertainDataset(ys)

#######################
# On uncertain values
######################
@test pvalue(MannWhitneyUTest(uval1, uval2)) isa Float64
@test pvalue(MannWhitneyUTest(uval1, uval2, 10)) isa Float64

@test pvalue(OneSampleTTest(uval1)) isa Float64
@test pvalue(OneSampleTTest(uval1, μ0 = 0.0)) isa Float64
@test pvalue(OneSampleTTest(uval1, uval2)) isa Float64
@test pvalue(OneSampleTTest(uval1, uval2, μ0 = 0.0)) isa Float64

@test pvalue(OneSampleTTest(uval1, 10)) isa Float64
@test pvalue(OneSampleTTest(uval1, 10)) isa Float64
@test pvalue(OneSampleTTest(uval1, uval2, 10)) isa Float64
@test pvalue(OneSampleTTest(uval1, uval2, 10, μ0 = 0.0)) isa Float64

@test pvalue(EqualVarianceTTest(uval1, uval2)) isa Float64
@test pvalue(EqualVarianceTTest(uval1, uval2, 10)) isa Float64
@test pvalue(EqualVarianceTTest(uval1, uval2, μ0 = 0.0)) isa Float64
@test pvalue(EqualVarianceTTest(uval1, uval2, 10, μ0 = 0.0)) isa Float64

@test pvalue(UnequalVarianceTTest(uval1, uval2)) isa Float64
@test pvalue(UnequalVarianceTTest(uval1, uval2, 10)) isa Float64
@test pvalue(UnequalVarianceTTest(uval1, uval2, μ0 = 0.0)) isa Float64
@test pvalue(UnequalVarianceTTest(uval1, uval2, 10, μ0 = 0.0)) isa Float64

@test pvalue(ApproximateTwoSampleKSTest(uval1, uval2)) isa Float64
@test pvalue(ApproximateTwoSampleKSTest(uval1, uval2, 10)) isa Float64

@test pvalue(ExactOneSampleKSTest(uval1, Normal())) isa Float64
@test pvalue(OneSampleADTest(uval1, Normal())) isa Float64


#######################
# On uncertain datasets
######################
@test pvalue(MannWhitneyUTestPooled(x, y)) isa Float64
@test pvalue(MannWhitneyUTestPooled(x, y, 10)) isa Float64
@test pvalue.(MannWhitneyUTestElementWise(x, y)) isa Vector{Float64}
@test pvalue.(MannWhitneyUTestElementWise(x, y, 10)) isa Vector{Float64}

@test pvalue(OneSampleTTestPooled(x)) isa Float64
@test pvalue(OneSampleTTestPooled(x, y)) isa Float64
@test pvalue(OneSampleTTestPooled(x, y, 10)) isa Float64
@test pvalue.(OneSampleTTestElementWise(x, y)) isa Vector{Float64}
@test pvalue.(OneSampleTTestElementWise(x, y, 10)) isa Vector{Float64}
@test pvalue(OneSampleTTestPooled(x, μ0 = 0.0)) isa Float64
@test pvalue(OneSampleTTestPooled(x, y, μ0 = 0.0)) isa Float64
@test pvalue(OneSampleTTestPooled(x, y, 10, μ0 = 0.0)) isa Float64
@test pvalue.(OneSampleTTestElementWise(x, y, μ0 = 0.0)) isa Vector{Float64}
@test pvalue.(OneSampleTTestElementWise(x, y, 10, μ0 = 0.0)) isa Vector{Float64}

@test pvalue(EqualVarianceTTestPooled(x, y)) isa Float64
@test pvalue(EqualVarianceTTestPooled(x, y, 10)) isa Float64
@test pvalue.(EqualVarianceTTestElementWise(x, y)) isa Vector{Float64}
@test pvalue.(EqualVarianceTTestElementWise(x, y, 10)) isa Vector{Float64}

@test pvalue(UnequalVarianceTTestPooled(x, y)) isa Float64
@test pvalue(UnequalVarianceTTestPooled(x, y, 10)) isa Float64
@test pvalue.(UnequalVarianceTTestElementWise(x, y)) isa Vector{Float64}
@test pvalue.(UnequalVarianceTTestElementWise(x, y, 10)) isa Vector{Float64}

@test pvalue(ApproximateTwoSampleKSTestPooled(x, y)) isa Float64
@test pvalue.(ApproximateTwoSampleKSTestElementWise(x, y)) isa Vector{Float64}

@test pvalue(ExactOneSampleKSTestPooled(x, Normal())) isa Float64
@test pvalue.(ExactOneSampleKSTestElementWise(x, Normal())) isa Vector{Float64}

@test pvalue(OneSampleADTestPooled(x, Normal())) isa Float64
@test pvalue.(OneSampleADTestElementWise(x, Normal())) isa Vector{Float64}

@test pvalue(JarqueBeraTestPooled(x)) isa Float64
@test pvalue.(JarqueBeraTestElementWise(x)) isa Vector{Float64}
