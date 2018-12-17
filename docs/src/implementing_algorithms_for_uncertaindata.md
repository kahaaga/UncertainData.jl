## Extending existing algorithms for uncertain data types

Do you already have an algorithm computing some statistic that you want to obtain uncertainty estimates for? Simply use Julia's multiple dispatch and create a version of the algorithm function that accepts the `AbstractUncertainValue` and `AbstractUncertainDataset` types, along with a `SamplingConstraints` specifying how the uncertain values are should be resampled.

A basic function skeleton could be

```julia
# Some algorithm computing a statistic for a scalar-valued vector
function myalgorithm(dataset::Vector{T}; kwargs...) where T
    # some algorithm returning a single-valued statistic
end

# Applying the algorithm to an ensemble of realisations from
# an uncertain dataset, given a sampling constraint.
function myalgorithm(d::UncertainDataset, constraint::C;
        n_ensemble_realisations = 100, kwargs...)
        where {C <: SamplingConstraint}

    ensemble_stats = zeros(n_ensemble_realisations)

    for i in 1:n_ensemble_realisations
        ensemble_stats[i] = myalgorithm(resample(d, constraint); kwargs...)
    end

    return ensemble_stats
end
```
