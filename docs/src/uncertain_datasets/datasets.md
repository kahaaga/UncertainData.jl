# Types of datasets

## `UncertainValueDataset`

`UncertainValueDataset`s is an uncertain dataset type that has no explicit index 
associated with its uncertain values. This type may come with some extra functionality 
that the generic [UncertainDataset](uncertain_dataset.md) type does not support. 

Use this type when you want to be explicit about the values representing data values,
as opposed to [indices](uncertain_index_dataset.md). 

```@docs
UncertainValueDataset
```

## Uncertain index datasets

`UncertainIndexDataset`s is an uncertain dataset type that represents the indices 
corresponding to an [UncertainValueDataset](uncertain_value_dataset.md).

It is meant to be used for the `indices` field in
[UncertainIndexValueDataset](uncertain_indexvalue_dataset.md)s instances.

```@docs
UncertainIndexDataset
```
