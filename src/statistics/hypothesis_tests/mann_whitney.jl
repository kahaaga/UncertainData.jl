# The original license on the Mann-Whitney tests from HypothesisTests.jl
# is as follows (the filename is wrong, though). We're including it here
# because we're mostly copying the documentation of the functions.
#
# Wilcoxon.jl
# Wilcoxon rank sum (Mann-Whitney U) tests
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

import HypothesisTests.MannWhitneyUTest


"""
    MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue,
        n::Int = 1000) -> MannWhitneyUTest

Let `s1` and `s2` be samples of `n` realisations from the distributions
furnishing the uncertain values `d1` and `d2`.

Perform a Mann-Whitney U test of the null hypothesis that the probability that
an observation drawn from the same population as `s1` is greater than an
observation drawn from the same population as `s2` is equal to the probability
that an observation drawn from the same population as `s2` is greater than an
observation drawn from the same population as `s1` against the alternative
hypothesis that these probabilities are not equal.

The Mann-Whitney U test is sometimes known as the Wilcoxon rank-sum test.
When there are no tied ranks and ≤50 samples, or tied ranks and ≤10 samples,
`MannWhitneyUTest` performs an exact Mann-Whitney U test. In all other cases,
`MannWhitneyUTest` performs an approximate Mann-Whitney U test.
"""
function MannWhitneyUTest(d1::AbstractUncertainValue, d2::AbstractUncertainValue,
        n::Int = 1000)

    x = resample(d1, n)
    y = resample(d2, n)
    MannWhitneyUTest(x, y)
end


"""
    MannWhitneyUTest(d1::UncertainDataset, d2::UncertainDataset,
        n::Int = 1000) -> MannWhitneyUTest

Let ``s_{1_{i}}`` be a sample of `n` realisations of the distribution
furnishing the uncertain value `d1[i]`, where ``i \\in [1, 2, \\ldots, N]``
and ``N`` is the number of uncertain values in `d1`.  Next, gather the
samples for all ``s_{1_{i}}`` in a pooled sample ``S_1``.  Do the same
for the second uncertain dataset `d2`, yielding the pooled sample  ``S_2``.

Perform a Mann-Whitney U test of the null hypothesis that the probability that
an observation drawn from the same population as ``S_1`` is greater than an
observation drawn from the same population as ``S_2`` is equal to the probability
that an observation drawn from the same population as ``S_2`` is greater than an
observation drawn from the same population as ``S_1`` against the alternative
hypothesis that these probabilities are not equal.

The Mann-Whitney U test is sometimes known as the Wilcoxon rank-sum test.
When there are no tied ranks and ≤50 samples, or tied ranks and ≤10 samples,
`MannWhitneyUTest` performs an exact Mann-Whitney U test. In all other cases,
`MannWhitneyUTest` performs an approximate Mann-Whitney U test.
"""
function MannWhitneyUTestPooled(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000)

    x = vcat(resample(d1, n)...,)
    y = vcat(resample(d2, n)...,)

    MannWhitneyUTest(x, y)
end

"""
    MannWhitneyUTest(d1::UncertainDataset, d2::UncertainDataset,
        n::Int = 1000) -> Vector{MannWhitneyUTest}

Assume `d1` and `d2` consist of the same number of uncertain values.
Let ``s_{1_{i}}`` be a sample of `n` realisations of the distribution
furnishing the uncertain value `d1[i]`, where ``i \\in [1, 2, \\ldots, N]``
and ``N`` is the number of uncertain values in `d1`. Let ``s_{2_{i}}`` be
the corresponding sample for `d2[i]`. This function


Perform an element-wise Mann-Whitney U test of the null hypothesis that the
probability that an observation drawn from the same population as ``s_{1_{i}}``
is greater than an observation drawn from the same population as ``s_{2_{i}}``
is equal to the probability that an observation drawn from the same population
as ``s_{2_{i}}`` is greater than an observation drawn from the same population
as ``s_{1_{i}}`` against the alternative hypothesis that these probabilities
are not equal.

The Mann-Whitney U test is sometimes known as the Wilcoxon rank-sum test.
When there are no tied ranks and ≤50 samples, or tied ranks and ≤10 samples,
`MannWhitneyUTest` performs an exact Mann-Whitney U test. In all other cases,
`MannWhitneyUTest` performs an approximate Mann-Whitney U test.
"""
function MannWhitneyUTestElementWise(d1::UncertainDataset,
        d2::UncertainDataset,
        n::Int = 1000)

    N = length(d1)
    [MannWhitneyUTest(resample(d1[i], n), resample(d2[i], n)) for i = 1:N]
end


export
MannWhitneyUTest,
MannWhitneyUTestPooled,
MannWhitneyUTestElementWise
