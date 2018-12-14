import HypothesisTests.MannWhitneyUTest

import HypothesisTests.OneSampleTTest

import HypothesisTests.EqualVarianceTTest
import HypothesisTests.UnequalVarianceTTest

import HypothesisTests.ExactOneSampleKSTest
import HypothesisTests.ApproximateTwoSampleKSTest

import HypothesisTests.OneSampleADTest

import HypothesisTests.JarqueBeraTest


function MannWhitneyUTest(d1::AbstractUncertainValue,
        d2::AbstractUncertainValue,
        n::Int = 1000)

    x = resample(d1, n)
    y = resample(d2, n)
    MannWhitneyUTest(x, y)
end

function MannWhitneyUTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000)

    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)

    MannWhitneyUTest(x, y)
end

function MannWhitneyUTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000)

    N = length(d1)
    [MannWhitneyUTest(resample(d1[i], n), resample(d2[i], n)) for i = 1:N]
end

function EqualVarianceTTest(d1::AbstractUncertainValue,
        d2::AbstractUncertainValue,
        n::Int = 1000;
        μ0::Real = 0)

    x = resample(d1, n)
    y = resample(d2, n)
    EqualVarianceTTest(x, y, μ0)
end

function EqualVarianceTTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)

    EqualVarianceTTest(x, y, μ0)
end

function EqualVarianceTTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    N = length(d1)
    [EqualVarianceTTest(resample(d1[i], n), resample(d2[i], n), μ0) for i = 1:N]
end

function UnequalVarianceTTest(d1::AbstractUncertainValue,
        d2::AbstractUncertainValue,
        n::Int = 1000;
        μ0::Real = 0)

    x = resample(d1, n)
    y = resample(d2, n)
    UnequalVarianceTTest(x, y, μ0)
end

function UnequalVarianceTTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)

    UnequalVarianceTTest(x, y, μ0)
end

function UnequalVarianceTTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    N = length(d1)
    [UnequalVarianceTTest(resample(d1[i], n), resample(d2[i], n), μ0) for i = 1:N]
end


"""
    OneSampleTTest(d::AbstractUncertainValue, n::Int = 1000;
        μ0::Real = 0) -> OneSampleTTest

Perform a one sample t-test of the null hypothesis that the uncertain value has
a distribution with mean `μ0` against the alternative hypothesis that its distribution
does not have mean `μ0`. `n` indicates the number of draws during resampling.
"""
function OneSampleTTest(d::AbstractUncertainValue, n::Int = 1000; μ0::Real = 0)
    x = resample(d, n)
    OneSampleTTest(x, μ0)
end

"""
    OneSampleTTest(d1::AbstractUncertainValue,
                    d2::AbstractUncertainValue,
                    n::Int = 1000; μ0::Real=0) -> OneSampleTTest

Perform a paired sample t-test of the null hypothesis that the differences
between pairs of uncertain values in `d1` and `d2` come from a distribution
with mean `μ0` against the alternative hypothesis that the distribution does
not have mean `μ0`.
"""
function OneSampleTTest(d1::AbstractUncertainValue,
                        d2::AbstractUncertainValue,
                        n::Int = 1000; μ0::Real = 0)
    x = resample(d1, n)
    y = resample(d2, n)
    OneSampleTTest(x, y, μ0)
end

"""
    OneSampleTTestPooled(d::UncertainDataset, n::Int = 1000;
        μ0::Real=0) -> OneSampleTTest

First, sample `n` draws of each uncertain value in `d1`, then pooling the draws
together. Then, perform a one sample t-test of the null hypothesis that the
uncertain values have a pooled distribution with mean `μ0` against the
alternative hypothesis that its pooled distribution
does not have mean `μ0`. `n` indicates the number of draws during resampling.
"""
function OneSampleTTestPooled(d::UncertainDataset, n::Int = 1000; μ0::Real = 0)
    x = vcat([resample(uncertainval, n) for uncertainval in d]...,)
    OneSampleTTest(x, μ0)
end

"""
    OneSampleTTestElementWise(d::UncertainDataset, n::Int = 1000;
        μ0::Real = 0) -> Vector{OneSampleTTest}

First, sample `n` draws of each uncertain value in `d`, then pooling the draws
together. Then, perform a one sample t-test of the null hypothesis that the
uncertain values have a pooled distribution with mean `μ0` against the
alternative hypothesis that its pooled distribution
does not have mean `μ0`. `n` indicates the number of draws during resampling.
"""
function OneSampleTTestElementWise(d::UncertainDataset, n::Int = 1000; μ0::Real = 0)
    [OneSampleTTest(resample(uncertainval, n), μ0) for uncertainval in d]
end

"""
    OneSampleTTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000; μ0::Real = 0) -> OneSampleTTest

First, sample `n` draws of each uncertain value, pooling the draws from
the elements of `d1` and the draws from the elements of `d2` separately.
Then, perform a paired sample t-test of the null hypothesis that the differences
between pairs of uncertain values in `d1` and `d2` come from a distribution
with mean `μ0` against the alternative hypothesis that the distribution does
not have mean `μ0`.
"""
function OneSampleTTestPooled(d1::UncertainDataset,
                                d2::UncertainDataset,
                                n::Int = 1000; μ0::Real = 0)
    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)
    OneSampleTTest(x, y, μ0)
end

"""
    OneSampleTTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000; μ0::Real = 0) -> Vector{OneSampleTTest}

Perform a one sample t-test of the null hypothesis that the uncertain value has
a distribution with mean `μ0` against the alternative hypothesis that its
distribution does not have mean `μ0` for uncertain value in `d`.

`n` indicates the number of draws during resampling.
"""
function OneSampleTTestElementWise(d1::UncertainDataset,
                                    d2::UncertainDataset,
                                    n::Int = 1000; μ0::Real = 0)
    N = length(d1)
    [OneSampleTTest(resample(d1[i], n), resample(d2[i], n), μ0) for i in 1:N]
end

"""
    ExactOneSampleKSTest(uv::UncertainValue,
        d::UnivariateDistribution) -> ExactOneSampleKSTest

Perform a one-sample exact Kolmogorov–Smirnov test of the null hypothesis that
a draw of `n` realisations of the uncertain value `uv` comes from the
distribution `d` against the alternative hypothesis that the sample is not
drawn from `d`.
"""
function ExactOneSampleKSTest(uv::AbstractUncertainValue, d::UnivariateDistribution, n::Int = 1000)
    x = resample(uv, n)
    ExactOneSampleKSTest(x, d)
end

"""
    ExactOneSampleKSTestPooled(ud::UncertainDataset,
        d::UnivariateDistribution) -> ExactOneSampleKSTest

First, draw `n` realisations of each uncertain value in `ud` and pool them
together. Then perform a one-sample exact Kolmogorov–Smirnov test of the null
hypothesis that the pooled values comes from the distribution `d` against the
alternative hypothesis that the sample is not drawn from `d`.
"""
function ExactOneSampleKSTestPooled(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
    x = vcat(resample(ud, n)...,)
    ExactOneSampleKSTest(x, d)
end

"""
    ExactOneSampleKSTestElementWise(ud::UncertainDataset,
        d::UnivariateDistribution) -> Vector{ExactOneSampleKSTest}

First, draw `n` realisations of each uncertain value in `ud`, keeping one
pool of values for each uncertain value.

Then, perform an element-wise (pool-wise) one-sample exact Kolmogorov–Smirnov
test of the null hypothesis that each value pool comes from the distribution `d`
against the alternative hypothesis that the sample is not drawn from `d`.
"""
function ExactOneSampleKSTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
    [ExactOneSampleKSTest(resample(ud[i], n), d) for i = 1:length(ud)]
end

"""
    ApproximateTwoSampleKSTest(d1::AbstractUncertainValue,
        d2::AbstractUncertainValue, n::Int = 1000) -> ApproximateTwoSampleKSTest

Perform an asymptotic two-sample Kolmogorov–Smirnov-test of the null hypothesis
that the distribution furnishing the uncertain value `d1` represent the same
distribution as the distribution furnishing the uncertain value `d2`
against the alternative hypothesis that the furnishing distributions are
different.
"""
function ApproximateTwoSampleKSTest(d1::AbstractUncertainValue,
                                    d2::AbstractUncertainValue,
                                    n::Int = 1000)
    x = resample(d1, n)
    y = resample(d2, n)
    ApproximateTwoSampleKSTest(x, y)
end

"""
    ApproximateTwoSampleKSTestPooled(d1::UncertainDataset,
        d2::UncertainDataset, n::Int = 1000) -> ApproximateTwoSampleKSTest

First, draw `n` realisations of each uncertain value in `d1`, then separately
draw `n` realisations of each uncertain value in `d2`. Then, pool all
realisations for `d1` together and all realisations of `d2` together.

On the pooled realisations, perform an asymptotic two-sample
Kolmogorov–Smirnov-test of the null hypothesis that the distribution furnishing
the `d1` value pool represents the same distribution as the distribution
furnishing the `d2` value pool, against the alternative hypothesis that the
furnishing distributions are different.
"""
function ApproximateTwoSampleKSTestPooled(d1::UncertainDataset,
                                        d2::UncertainDataset,
                                        n::Int = 1000)
    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)
    ApproximateTwoSampleKSTest(x, y)
end

"""
    ApproximateTwoSampleKSTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset, n::Int = 1000) -> Vector{ApproximateTwoSampleKSTest}

Assuming `d1` and `d2` contain the same number of uncertain observations,
draw `n` realisations of each uncertain value in `d1`, then separately and
separately draw `n` realisations of each uncertain value in `d2`.

Then, perform an asymptotic two-sample Kolmogorov–Smirnov-test of
the null hypothesis that the uncertain values in `d1` and `d2` come from
the same distribution against the alternative hypothesis that the (element-wise)
values in  `d1` and `d2` come from different distributions.

The test is performed pairwise, i.e. ApproximateTwoSampleKSTest(d1[i], d2[i])
with `n` draws for the ``i``-ith pair of uncertain values.
"""
function ApproximateTwoSampleKSTestElementWise(d1::UncertainDataset,
                                                d2::UncertainDataset,
                                                n::Int = 1000)
    N = length(d1)

    [ApproximateTwoSampleKSTest(resample(d1[i], n), resample(d2[i], n)) for i = 1:N]
end


"""
    OneSampleADTest(uv::UncertainValue, d::UnivariateDistribution) -> OneSampleADTest

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
    OneSampleADTestPooled(ud::UncertainDataset, d::UnivariateDistribution) -> OneSampleADTest

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
    OneSampleADTestElementWise(ud::UncertainDataset, d::UnivariateDistribution) -> Vector{OneSampleADTest}

First, draw `n` realisations of each uncertain value in `ud`, keeping one
pool of values for each uncertain value.

Then, perform an element-wise (pool-wise) one-sample Anderson–Darling test of
the null hypothesis that each value pool comes from the distribution `d`
against the alternative hypothesis that the sample is not drawn from `d`.
"""
function OneSampleADTestElementWise(ud::UncertainDataset, d::UnivariateDistribution, n::Int = 1000)
    [OneSampleADTest(resample(ud[i], n), d) for i = 1:length(ud)]
end


"""
    JarqueBeraTest(d::AbstractUncertainValue, n::Int = 1000) -> JarqueBeraTest

Compute the Jarque-Bera statistic to test the null hypothesis that an uncertain
value is normally distributed.
"""
function JarqueBeraTest(d::AbstractUncertainValue, n::Int = 1000)
    x = resample(d, n)
    JarqueBeraTest(x)
end

"""
    JarqueBeraTestPooled(ud::UncertainDataset, n::Int = 1000) -> JarqueBeraTest

First, draw `n` realisations of each uncertain value in `ud` and pool them
together. Then, compute the Jarque-Bera statistic to test the null hypothesis
that the values of the pool are normally distributed.
"""
function JarqueBeraTestPooled(ud::UncertainDataset, n::Int = 1000)
    x = vcat(resample(ud, n)...,)
    JarqueBeraTest(x)
end

"""
    OneSampleADTestElementWise(ud::UncertainDataset,
        n::Int = 1000) -> Vector{JarqueBeraTest}

First, draw `n` realisations of each uncertain value in `ud`, keeping one
pool of values for each uncertain value.

Then, compute the Jarque-Bera statistic to test the null hypothesis that each
value pool is normally distributed.
"""
function JarqueBeraTestElementWise(ud::UncertainDataset, n::Int = 1000)
    [JarqueBeraTest(resample(ud[i], n)) for i = 1:length(ud)]
end



export
EqualVarianceTTest,
EqualVarianceTTestPooled,
EqualVarianceTTestElementWise,

UnequalVarianceTTest,
UnequalVarianceTTestPooled,
UnequalVarianceTTestElementWise,

MannWhitneyUTest,
MannWhitneyUTestPooled,
MannWhitneyUTestElementWise,

OneSampleTTest,
OneSampleTTestPooled,
OneSampleTTestElementWise,

ExactOneSampleKSTest,
ExactOneSampleKSTestPooled,
ExactOneSampleKSTestElementWise,

ApproximateTwoSampleKSTest,
ApproximateTwoSampleKSTestPooled,
ApproximateTwoSampleKSTestElementWise,

OneSampleADTest,
OneSampleADTestPooled,
OneSampleADTestElementWise,

JarqueBeraTest,
JarqueBeraTestPooled,
JarqueBeraTestElementWise
