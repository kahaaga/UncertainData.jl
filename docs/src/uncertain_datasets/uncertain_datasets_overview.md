If dealing with several uncertain values, it may be useful to represent them
as an uncertain dataset. This way, one may trivially, for example, compute
statistics for a dataset consisting of samples with different types of
uncertainties.

## Uncertain index datasets and data value datasets

There are three main types of uncertain datasets: 

- [UncertainIndexDataset](uncertain_index_dataset.md)s contain uncertain indices.
- [UncertainValueDataset](uncertain_value_dataset.md)s contain uncertain data values. 
- [UncertainIndexValueDataset](uncertain_indexvalue_dataset.md)s represent datasets for 
    which both the indices and the data values are uncertain. It uses
    `UncertainIndexDataset`s to represent the indices and `UncertainValueDataset`s
    to represent the data values.


## Generic dataset type
There's also a generic uncertain dataset type for when you don't care about distinguishing 
between indices and data values: 

- [UncertainDataset](uncertain_dataset.md) contains uncertain indices.

