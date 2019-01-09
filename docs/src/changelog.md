
## UncertainData.jl v0.1.1
- Indexing implemented for `UncertainIndexValueDataset`. 
- Resampling implemented for `UncertainIndexValueDataset`.
- Uncertain values and uncertain datasets now support `minimum` and `maximum`.
- `support(uv::AbstractUncertainValue)` now always returns an interval from [IntervalArithmetic.jl](https://github.com/JuliaIntervals/IntervalArithmetic.jl/)
- `support_overlap` now computes overlaps also for fitted theoretical distributions.
- Added more plotting recipes. 
- All implemented uncertain data types now support resampling. 
- Improved general documentation. Added a reference to [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) and an explanation for the differences between the packages.
- Improved resampling documentation with detailed explanation and plots.


## UncertainData.jl v0.1.0
- Basic functionality in place.