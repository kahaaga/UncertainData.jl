# Uncertain statistics

## Core statistics

This package implements most of the statistical algorithms in `StatsBase` for uncertain values and uncertain datasets.

The syntax for calling the algorithms is the same as in `StatsBase`, but
the functions here accept an additional positional argument `n`, which controls
how many times the uncertain values are resampled to compute the statistics.
The default number of times to resample is `n = 1000`.

### Statistics of single uncertain values
- `mean(d::AbstractUncertainValue, n::Int = 1000)`. Computes the mean of an uncertain value.
- `median(d::AbstractUncertainValue, n::Int = 1000)`. Computes the median of an uncertain value.
- `middle(d::AbstractUncertainValue, n::Int = 1000)`. Computes the middle of an uncertain value.
- `std(d::AbstractUncertainValue, n::Int = 1000)`. Computes the standard deviation of an uncertain value.
- `var(d::AbstractUncertainValue, n::Int = 1000)`. Computes the variance of an uncertain value.
- `quantile(d::AbstractUncertainValue, p, n::Int = 1000)`. Computes the `p`-th quantile(s) of an uncertain value.


### Statistics on datasets of uncertain values

The following statistics are available for uncertain datasets (collections
of uncertain values).

- `mean(d::UncertainDataset`). Computes the element-wise mean of a dataset of uncertain values.
- `median(d::UncertainDataset`). Computes the element-wise median of a dataset of uncertain values.
- `middle(d::UncertainDataset`). Computes the element-wise middle of a dataset of uncertain values.
- `std(d::UncertainDataset`). Computes the element-wise standard deviation of a dataset of uncertain values.
- `var(d::UncertainDataset`). Computes the element-wise variance of a dataset of uncertain values.
- `quantile(d::UncertainDataset, p, n::Int = 1000)`. Computes the element-wise `p`-th quantile(s) of a dataset of uncertain values.
- `cor(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`. Compute the correlation between two datasets consisting of uncertain values.
- `cov(d1::UncertainDataset, d2::UncertainDataset, n::Int = 1000)`. Compute the correlation between two datasets consisting of uncertain values.
