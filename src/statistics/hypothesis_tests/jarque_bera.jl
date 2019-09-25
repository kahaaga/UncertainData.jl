# The original license on the t-tests from HypothesisTests.jl
# is as follows. We're including it here because we're mostly copying the
# documentation of the functions.
#
# jarque_bera.jl
# Jarque-Bera goodness-of-fit test
#
# Copyright (C) 2017   Benjamin Born
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

import HypothesisTests.JarqueBeraTest

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
JarqueBeraTest,
JarqueBeraTestPooled,
JarqueBeraTestElementWise
