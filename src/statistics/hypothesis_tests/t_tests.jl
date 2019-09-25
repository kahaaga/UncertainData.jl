# The original license on the t-tests from HypothesisTests.jl
# is as follows. We're including it here because we're mostly copying the
# documentation of the functions.
#
# t.jl
# Various forms of t-tests
#
# Copyright (C) 2012   Simon Kornblith
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

import HypothesisTests.OneSampleTTest
import HypothesisTests.EqualVarianceTTest
import HypothesisTests.UnequalVarianceTTest


"""
    EqualVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue,
        n::Int = 1000; μ0::Real = 0) -> EqualVarianceTTest

Consider two samples `s1` and `s2`, each consisting of `n` random draws from the
distributions furnishing `d1` and `d2`, respectively.

This function performs a two-sample t-test of the null hypothesis that `s1` and
`s2` come from distributions with equal means and variances against the
alternative hypothesis that the distributions have different means but equal
variances.
"""
function EqualVarianceTTest(d1::AbstractUncertainValue,
        d2::AbstractUncertainValue,
        n::Int = 1000;
        μ0::Real = 0)

    x = resample(d1, n)
    y = resample(d2, n)
    EqualVarianceTTest(x, y, μ0)
end

"""
    EqualVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset,
        n::Int = 1000; μ0::Real = 0) -> EqualVarianceTTest

Consider two samples `s1[i]` and `s2[i]`, each consisting of `n` random draws
from the distributions furnishing the uncertain values `d1[i]` and `d2[i]`,
respectively. Gather all `s1[i]` in a pooled sample `S1`, and all `s2[i]` in
a pooled sample `S2`.

Perform a two-sample t-test of the null hypothesis that `S1` and `S2` come from
distributions with equal means and variances against the alternative hypothesis
that the distributions have different means but equal variances.
"""
function EqualVarianceTTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)

    EqualVarianceTTest(x, y, μ0)
end


"""
    EqualVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset,
        n::Int = 1000; μ0::Real = 0) -> Vector{EqualVarianceTTest}

Consider two samples `s1[i]` and `s2[i]`, each consisting of `n` random draws
from the distributions furnishing the uncertain values `d1[i]` and `d2[i]`,
respectively. This function performs an elementwise `EqualVarianceTTest`
on the pairs `(s1[i], s2[i])`. Specifically:

Performs an pairwise two-sample t-test of the null hypothesis that `s1[i]` and
`s2[i]` come from distributions with equal means and variances against the
alternative hypothesis that the distributions have different means but equal
variances.
"""
function EqualVarianceTTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    N = length(d1)
    [EqualVarianceTTest(resample(d1[i], n), resample(d2[i], n), μ0) for i = 1:N]
end


"""
    UnequalVarianceTTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue,
        n::Int = 1000; μ0::Real = 0) -> UnequalVarianceTTest

Consider two samples `s1` and `s2`, each consisting of `n` random draws from the
distributions furnishing `d1` and `d2`, respectively.

Perform an unequal variance two-sample t-test of the null hypothesis that `s1`
and `s2` come from distributions with equal means against the alternative
hypothesis that the distributions have different means.
"""
function UnequalVarianceTTest(d1::AbstractUncertainValue,
        d2::AbstractUncertainValue,
        n::Int = 1000;
        μ0::Real = 0)

    x = resample(d1, n)
    y = resample(d2, n)
    UnequalVarianceTTest(x, y, μ0)
end


"""
    UnequalVarianceTTestPooled(d1::UncertainDataset, d2::UncertainDataset,
        n::Int = 1000; μ0::Real = 0) -> UnequalVarianceTTest

Consider two samples `s1[i]` and `s2[i]`, each consisting of `n` random draws
from the distributions furnishing the uncertain values `d1[i]` and `d2[i]`,
respectively. Gather all `s1[i]` in a pooled sample `S1`, and all `s2[i]` in
a pooled sample `S2`.

This function performs an unequal variance two-sample t-test of the null
hypothesis that `S1` and `S2` come from distributions with equal means against
the alternative hypothesis that the distributions have different means.

"""
function UnequalVarianceTTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000;
        μ0::Real = 0)

    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)

    UnequalVarianceTTest(x, y, μ0)
end

"""
    UnequalVarianceTTestElementWise(d1::UncertainDataset, d2::UncertainDataset,
        n::Int = 1000; μ0::Real = 0) -> Vector{UnequalVarianceTTest}


Consider two samples `s1[i]` and `s2[i]`, each consisting of `n` random draws
from the distributions furnishing the uncertain values `d1[i]` and `d2[i]`,
respectively. This function performs an elementwise `EqualVarianceTTest`
on the pairs `(s1[i], s2[i])`. Specifically:

Performs an pairwise unequal variance two-sample t-test of the null hypothesis
that `s1[i]` and `s2[i]` come from distributions with equal means against the
alternative hypothesis that the distributions have different means.

This test is sometimes known as Welch's t-test. It differs from the equal
variance t-test in that it computes the number of degrees of freedom of the
test using the Welch-Satterthwaite equation:

```math
    ν_{χ'} ≈ \\frac{\\left(\\sum_{i=1}^n k_i s_i^2\\right)^2}{\\sum_{i=1}^n
        \\frac{(k_i s_i^2)^2}{ν_i}}
```
"""
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
a distribution with mean `μ0` against the alternative hypothesis that its
distribution does not have mean `μ0`. `n` indicates the number of draws during
resampling.
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
alternative hypothesis that its pooled distribution does not have mean `μ0`.
`n` indicates the number of draws during resampling.
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

First, sample `n` draws of each uncertain value in each dataset, pooling the
draws from the elements of `d1` and the draws from the elements of `d2` separately.
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


export
EqualVarianceTTest,
EqualVarianceTTestPooled,
EqualVarianceTTestElementWise,

UnequalVarianceTTest,
UnequalVarianceTTestPooled,
UnequalVarianceTTestElementWise,

OneSampleTTest,
OneSampleTTestPooled,
OneSampleTTestElementWise
