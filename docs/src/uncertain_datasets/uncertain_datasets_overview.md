# [Types of uncertain value collections](@id uncertain_value_collection_types)

If dealing with several uncertain values, it may be useful to represent them
as an uncertain dataset. This way, one may trivially, for example, compute
statistics for a dataset consisting of samples with different types of
uncertainties.

## Uncertain dataset types

You can collect your uncertain values in the following collections:

- The [UncertainValueDataset](uncertain_value_dataset.md) type is 
    just a wrapper for a vector of uncertain values.
- The [UncertainIndexDataset](uncertain_index_dataset.md) type 
    behaves just as [UncertainValueDataset](uncertain_value_dataset.md), but has certain resampling methods such as [sequential resampling](../resampling/sequential/resampling_uncertaindatasets_sequential) associated with them.
- The [UncertainIndexValueDataset](uncertain_indexvalue_dataset.md) 
    type allows you to be explicit that you're working with datasets where both the 
    [indices](uncertain_index_dataset.md) and the 
    [data values](uncertain_value_dataset.md) are uncertain. 
    This may be useful when you, for example, want to draw realizations of your 
    dataset while simultaneously enforcing 
    [sequential resampling](../resampling/sequential/resampling_uncertaindatasets_sequential.md) 
    models. One example is resampling while ensuring the draws have 
    [strictly increasing](../resampling/sequential/resampling_indexvalue_sequential.md) 
    age models.

There's also a generic uncertain dataset type for when you don't care about distinguishing 
between indices and data values:

- [UncertainDataset](uncertain_dataset.md) contains uncertain indices.

## Vectors of uncertain values

- Vectors of uncertain values, i.e. `Vector{<:AbstractUncertainvalue}`, will work 
    seamlessly for many applications, but not for all mathematical operations and statistical 
    algorithms. For that, rather use one of the uncertain dataset types above

## Collection types

Throughout the documentation you may encounter the following type union:

```@docs
UVAL_COLLECTION_TYPES
```
