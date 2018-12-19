In addition to providing ensemble computation of basic statistic measures, this package also wraps various hypothesis tests from `HypothesisTests.jl`. This allows us to perform hypothesis testing on ensemble realisations of the data.

## Implemented hypothesis tests

The following hypothesis tests are implemented for uncertain data types.

- [One sample t-test](one_sample_t_test.md).
- [Equal variance t-test](equal_variance_t_test.md).
- [Unequal variance t-test](unequal_variance_t_test.md).
- [Exact Kolmogorov-Smirnov test](exact_kolmogorov_smirnov_test.md).
- [Approximate two-sample Kolmogorov-Smirnov test](approximate_twosample_kolmogorov_smirnov_test.md).
- [One-sample Anderson–Darling test](anderson_darling_test.md).
- [Jarque-Bera test](jarque_bera_test.md).


## Terminology

**Pooled statistics** are computed by sampling all uncertain values comprising the dataset n times, pooling the values together and treating them as one variable, then computing the statistic.

**Element-wise statistics** are computed by sampling each uncertain value n times, keeping the data generated from each uncertain value separate. The statistics are the computed separately for each sample.
