# UncertainData.jl

## Goals

1. Provide a systematic and intuitive way of representing uncertain data.
2. Robust computation of ensemble statistics.
3. Speed up analyses involving uncertain data. Observations stored as probability distributions takes up minimal memory and are only realised when necessary for computations.

<!-- 2. Make it easier to translate assumptions about the reliability of observations into a probabilistic framework. -->
<!-- 3. Isolate the assumption part of statistical analyses to the pre-processing stage.
    - Once an `UncertainObservation` or an `UncertainDataset` has been constructed, you no longer have to deal with the uncertainty in your data explicitly. The statistical algorithms you know and love dispatch on the `UncertainDataset` type and returns an `UncertainEstimate`, which completely specifies the uncertainty of your analysis based on the prior information you provided. -->




This package was born to systematically deal with uncertain data,
and to sample uncertain dataset more rigorously. To do so, it uses some machinery `IntervalArithmetic.jl` and `Distributions.jl`,
which makes speaking about probability distributions and their
    overlap (or lack thereof) much easier.
