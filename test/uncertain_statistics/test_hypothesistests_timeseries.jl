using HypothesisTests, UncertainData, Distributions

ts_vals = [UncertainValue(Normal, rand(Uniform(-10, 10)), rand()) for i = 1:10]
ts = UncertainDataset(xs)
#
# @show size(LjungBoxTest(ts))
# @show size(LjungBoxTest(ts, 10))
# @show size(BoxPierceTest(ts))
# @show size(BoxPiercexTest(ts, 10))
#
# @test pvalue(LjungBoxTest(ts)) isa Float64
# @test pvalue.(LjungBoxTest(ts, 10)) isa Vector{Float64}
#
# @test pvalue(BoxPierceTest(ts)) isa Float64
# @test pvalue.(BoxPierceTest(ts, 10)) isa Vector{Float64}
