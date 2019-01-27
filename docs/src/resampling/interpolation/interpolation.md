[Interpolations.jl](https://github.com/JuliaMath/Interpolations.jl) is used for basic 
interpolation. It supports many different types of interpolation when data are evenly 
spaced, and gridded interpolation for unevenly spaced data. 

# Supported interpolations

For now, `UncertainData` implements linear interpolation for uncertain 
dataset realizations. 

# Uncertain index-value datasets

Datasets with uncertain indices (hence, the indices are almost always unevenly spaced),
can only be interpolated using [linear interpolation](gridded.md).


