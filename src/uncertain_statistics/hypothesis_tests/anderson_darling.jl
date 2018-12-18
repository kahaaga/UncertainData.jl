import HypothesisTests.OneSampleADTest

"""
    OneSampleADTest(uv::UncertainValue, d::UnivariateDistribution,
        n::Int = 1000) -> OneSampleADTest

Perform a one-sample Anderson–Darling test of the null hypothesis that
a draw of `n` realisations of the uncertain value `uv` comes from the
distribution `d` against the alternative hypothesis that the sample is not
drawn from `d`.
"""
function OneSampleADTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)
    x = resample(uv, n)
    OneSampleADTest(x, d)
end

"""
    OneSampleADTestPooled(ud::UncertainDataset, d::UnivariateDistribution,
        n::Int = 1000)) -> OneSampleADTest

First, draw `n` realisations of each uncertain value in `ud` and pool them
together. Then perform a one-sample Anderson–Darling test of the null
hypothesis that the pooled values comes from the distribution `d` against the
alternative hypothesis that the sample is not drawn from `d`.
"""
function OneSampleADTestPooled(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
    x = vcat(resample(ud, n)...,)
    OneSampleADTest(x, d)
end

"""
    OneSampleADTestElementWise(ud::UncertainDataset, d::UnivariateDistribution,
        n::Int = 1000)) -> Vector{OneSampleADTest}
First, draw `n` realisations of each uncertain value in `ud`, keeping one
pool of values for each uncertain value.
Then, perform an element-wise (pool-wise) one-sample Anderson–Darling test of
the null hypothesis that each value pool comes from the distribution `d`
against the alternative hypothesis that the sample is not drawn from `d`.
"""
function OneSampleADTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
    [OneSampleADTest(resample(ud[i], n), d) for i = 1:length(ud)]
end


export
OneSampleADTest,
OneSampleADTestPooled,
OneSampleADTestElementWise
