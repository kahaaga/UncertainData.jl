# The original license on the t-tests from HypothesisTests.jl
# is as follows. We're including it here because we're mostly copying the
# documentation of the functions.
#
# kolmogorov_smirnov.jl
# Kolmogorov–Smirnov
#
# Copyright (C) 2014   Christoph Sawade
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import HypothesisTests.ExactOneSampleKSTest
import HypothesisTests.ApproximateTwoSampleKSTest

"""
    ExactOneSampleKSTest(uv::AbstractUncertainValue,
        d::UnivariateDistribution, n::Int = 1000) -> ExactOneSampleKSTest

Perform a one-sample exact Kolmogorov–Smirnov test of the null hypothesis that
a draw of `n` realisations of the uncertain value `uv` comes from the
distribution `d` against the alternative hypothesis that the sample is not
drawn from `d`.
"""
function ExactOneSampleKSTest(uv::AbstractUncertainValue,
        d::UnivariateDistribution, n::Int = 1000)
    x = resample(uv, n)
    ExactOneSampleKSTest(x, d)
end

"""
    ExactOneSampleKSTestPooled(ud::UncertainDataset,
        d::UnivariateDistribution, n::Int = 1000) -> ExactOneSampleKSTest

First, draw `n` realisations of each uncertain value in `ud` and pool them
together. Then perform a one-sample exact Kolmogorov–Smirnov test of the null
hypothesis that the pooled values comes from the distribution `d` against the
alternative hypothesis that the sample is not drawn from `d`.
"""
function ExactOneSampleKSTestPooled(ud::UncertainDataset,
        d::UnivariateDistribution, n::Int = 1000)
    x = vcat(resample(ud, n)...,)
    ExactOneSampleKSTest(x, d)
end

"""
    ExactOneSampleKSTestElementWise(ud::UncertainDataset,
        d::UnivariateDistribution, n::Int = 1000) -> Vector{ExactOneSampleKSTest}

First, draw `n` realisations of each uncertain value in `ud`, keeping one
pool of values for each uncertain value.

Then, perform an element-wise (pool-wise) one-sample exact Kolmogorov–Smirnov
test of the null hypothesis that each value pool comes from the distribution `d`
against the alternative hypothesis that the sample is not drawn from `d`.
"""
function ExactOneSampleKSTestElementWise(ud::UncertainDataset,
        d::UnivariateDistribution, n::Int = 1000)
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


export
ExactOneSampleKSTest,
ExactOneSampleKSTestPooled,
ExactOneSampleKSTestElementWise,

ApproximateTwoSampleKSTest,
ApproximateTwoSampleKSTestPooled,
ApproximateTwoSampleKSTestElementWise
