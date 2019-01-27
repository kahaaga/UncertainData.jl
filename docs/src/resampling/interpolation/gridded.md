
# Grids

```@docs 
RegularGrid
```

# Syntax

## Uncertain index-value datasets
The following methods are available for the interpolating of a realization of an uncertain index-value dataset: 

### No constraints 
```@docs 
resample(udata::UncertainIndexValueDataset, 
        grid_indices::RegularGrid;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))
```

### Sequential constraints 

```@docs 
resample(udata::UncertainIndexValueDataset, 
        sequential_constraint::SequentialSamplingConstraint,
        grid_indices::RegularGrid;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))
```