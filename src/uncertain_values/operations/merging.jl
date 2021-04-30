"""
    combine(x::Vector{AbstractUncertainValue}; 
        n = 10000*length(uvals), bw::Union{Nothing, Real} = nothing) → UncertainScalarKDE
    combine(x::Vector{AbstractUncertainValue}, weights::ProbabilityWeights; kwargs...) → UncertainScalarKDE
    combine(x::Vector{AbstractUncertainValue}, weights::AnalyticWeights; kwargs...) → UncertainScalarKDE
    combine(x::Vector{AbstractUncertainValue}, weights::FrequencyWeights; kwargs...) → UncertainScalarKDE

Combine multiple uncertain values `x` into a single uncertain value using kernel 
density estimation (KDE). This is done by resampling each uncertain value in `x`, 
`n` times  each, then pooling these draws together. Finally, an approximation 
to the final distribution is computed over those draws using KDE.

The KDE bandwidth is controlled by `bw`. By default, `bw = nothing`; in this case, 
the bandwidth is determined using the `KernelDensity.default_bandwidth` function.
Tip: For very wide, close-to-normal distributions, the default bandwidth usually 
works well.For very peaked distributions or discrete populations, however, 
a lowering the bandwidth significantly may be a better choice.

If no weights are provided, the sample pool on which KDE is performed is computed 
by resampling each of the `N` uncertain values `n/N` times and pooling these values 
together. If `weights` are provided, then the `weights` control the relative sampling 
importance of the elements of `x`. `Weights`, `ProbabilityWeights` and  `AnalyticWeights` are 
functionally the same, and represent relative sampling probabilities. Either 
may be used depending on whether the weights are assigned subjectively or quantitatively. 
With `FrequencyWeights`, it is possible to control the exact number of draws from each 
uncertain value that goes into the draw pool before performing kernel density estimation.

## Example 

```julia
v1 = UncertainValue(Normal, 1, 0.3)
v2 = UncertainValue(Normal, 0.8, 0.4)
v3 = UncertainValue([rand() for i = 1:3], [0.3, 0.3, 0.4])
v4 = UncertainValue(Normal, 3.7, 0.8)
uvals = [v1, v2, v3, v4];

combine(uvals)
combine(uvals, n = 20000) # adjust number of total draws
```
"""
function combine(uvals::Vector{AbstractUncertainValue}; n = 10000*length(uvals), 
        bw::Union{Nothing, Real} = nothing)
    N = length(uvals)
    draws = zeros(Float64, N*n)

    for (i, uval) in enumerate(uvals)
        draws[(i-1)*n+1:i*n] = resample(uval, n)
    end
    
    return UncertainValue(UnivariateKDE, draws, 
        bandwidth = bw isa Real ? bw : default_bandwidth(draws))
end

"""
    combine(uvals::Vector{AbstractUncertainValue}, weights::ProbabilityWeights; 
        n = 10000*length(uvals), 
        bw::Union{Nothing, Real} = nothing)

Combine multiple uncertain values into a single uncertain value. This is
done by resampling each uncertain value in `uvals` proportionally to the provided 
relative analytic `weights` indicating their relative importance (these are normalised by 
default, so don't need to sum to 1), then pooling these draws together. Finally, a kernel 
density estimate to the final distribution is computed over the `n` total draws.

Providing `ProbabilityWeights` leads to the exact same behaviour as for `AnalyticWeights`, 
but may be more appropriote when, for example, weights have been determined 
quantitatively. 

The KDE bandwidth is controlled by `bw`. By default, `bw = nothing`; in this case, 
the bandwidth is determined using the `KernelDensity.default_bandwidth` function.

!!! tip

    For very wide, close-to-normal distributions, the default bandwidth may work well. 
    If you're combining very peaked distributions or discrete populations, however, 
    you may want to lower the bandwidth significantly.


# Example 

```julia
v1 = UncertainValue(Normal, 1, 0.3)
v2 = UncertainValue(Normal, 0.8, 0.4)
v3 = UncertainValue([rand() for i = 1:3], [0.3, 0.3, 0.4])
v4 = UncertainValue(Normal, 3.7, 0.8)
uvals = [v1, v2, v3, v4];

# Two difference syntax options
combine(uvals, ProbabilityWeights([0.2, 0.1, 0.3, 0.2]))
combine(uvals, pweights([0.2, 0.1, 0.3, 0.2]), n = 20000) # adjust number of total draws
```
"""
function combine(uvals::Vector{AbstractUncertainValue}, weights::ProbabilityWeights; 
        n = 10000*length(uvals), 
        bw::Union{Nothing, Real} = nothing)
    
    length(uvals) == length(weights) ? "Number of values != number of weights" : nothing
    
    # Scale the number of draws of each value according to their relative probability
    L = length(uvals)
    wts = weights ./ weights.sum
    Ns = [ceil(Int, n*wts[i]) for i = 1:L]
                
    N = sum(Ns)
                
    draws = zeros(Float64, N)
    for (i, uval) in enumerate(uvals)
        if i == 1
            draws[1:sum(Ns[1:i])] = resample(uval, Ns[i])
        else 
            draws[sum(Ns[1:(i-1)])+1:sum(Ns[1:i])] = resample(uval, Ns[i])
        end
    end
    
    return UncertainValue(UnivariateKDE, draws, 
        bandwidth = bw isa Real ? bw : default_bandwidth(draws))
end


"""
    combine(uvals::Vector{AbstractUncertainValue}, weights::AnalyticWeights; 
        n = 10000*length(uvals), 
        bw::Union{Nothing, Real} = nothing)

Combine multiple uncertain values into a single uncertain value. This is
done by resampling each uncertain value in `uvals` proportionally to the provided 
relative probability `weights` (these are normalised by default, so don't need 
to sum to 1), then pooling these draws together. Finally, a kernel density 
estimate to the final distribution is computed over the `n` total draws.

Providing `AnalyticWeights` leads to the exact same behaviour as for `ProbabilityWeights`,
but may be more appropriote when relative importance weights are assigned subjectively, 
and not based on quantitative evidence.

The KDE bandwidth is controlled by `bw`. By default, `bw = nothing`; in this case, 
the bandwidth is determined using the `KernelDensity.default_bandwidth` function.

!!! tip

    For very wide, close-to-normal distributions, the default bandwidth may work well. 
    If you're combining very peaked distributions or discrete populations, however, 
    you may want to lower the bandwidth significantly.


# Example 

```julia
v1 = UncertainValue(Normal, 1, 0.3)
v2 = UncertainValue(Normal, 0.8, 0.4)
v3 = UncertainValue([rand() for i = 1:3], [0.3, 0.3, 0.4])
v4 = UncertainValue(Normal, 3.7, 0.8)
uvals = [v1, v2, v3, v4];

# Two difference syntax options
combine(uvals, AnalyticWeights([0.2, 0.1, 0.3, 0.2]))
combine(uvals, aweights([0.2, 0.1, 0.3, 0.2]), n = 20000) # adjust number of total draws
```
"""
function combine(uvals::Vector{AbstractUncertainValue}, weights::AnalyticWeights; 
    n = 10000*length(uvals), 
    bw::Union{Nothing, Real} = nothing)
    
    length(uvals) == length(weights) ? "Number of values != number of weights" : nothing
    
    # Scale the number of draws of each value according to their relative probability
    L = length(uvals)
    wts = weights ./ weights.sum
    Ns = [ceil(Int, n*wts[i]) for i = 1:L]
                
    N = sum(Ns)
                
    draws = zeros(Float64, N)
    for (i, uval) in enumerate(uvals)
        if i == 1
            draws[1:sum(Ns[1:i])] = resample(uval, Ns[i])
        else 
            draws[sum(Ns[1:(i-1)])+1:sum(Ns[1:i])] = resample(uval, Ns[i])
        end
    end
    
    return UncertainValue(UnivariateKDE, draws, 
        bandwidth = bw isa Real ? bw : default_bandwidth(draws))
end

"""
    combine(uvals::Vector{AbstractUncertainValue}, weights::Weights; 
        n = 10000*length(uvals), 
        bw::Union{Nothing, Real} = nothing)

Combine multiple uncertain values into a single uncertain value. This is
done by resampling each uncertain value in `uvals` proportionally to the provided `weights` 
(these are normalised by default, so don't need to sum to 1), then pooling these draws 
together. Finally, a kernel density estimate to the final distribution is computed over 
the `n` total draws.

Providing `Weights` leads to the exact same behaviour as for `ProbabilityWeights` and 
`AnalyticalWeights`.

The KDE bandwidth is controlled by `bw`. By default, `bw = nothing`; in this case, 
the bandwidth is determined using the `KernelDensity.default_bandwidth` function.

!!! tip

    For very wide, close-to-normal distributions, the default bandwidth may work well. 
    If you're combining very peaked distributions or discrete populations, however, 
    you may want to lower the bandwidth significantly.


# Example 

```julia
v1 = UncertainValue(Normal, 1, 0.3)
v2 = UncertainValue(Normal, 0.8, 0.4)
v3 = UncertainValue([rand() for i = 1:3], [0.3, 0.3, 0.4])
v4 = UncertainValue(Normal, 3.7, 0.8)
uvals = [v1, v2, v3, v4];

# Two difference syntax options
combine(uvals, Weights([0.2, 0.1, 0.3, 0.2]))
combine(uvals, weights([0.2, 0.1, 0.3, 0.2]), n = 20000) # adjust number of total draws
```
"""
function combine(uvals::Vector{AbstractUncertainValue}, weights::Weights; 
        n = 10000*length(uvals), 
        bw::Union{Nothing, Real} = nothing)
    
    length(uvals) == length(weights) ? "Number of values != number of weights" : nothing
    
    # Scale the number of draws of each value according to their relative probability
    L = length(uvals)
    wts = weights ./ weights.sum
    Ns = [ceil(Int, n*wts[i]) for i = 1:L]
                
    N = sum(Ns)
                
    draws = zeros(Float64, N)
    for (i, uval) in enumerate(uvals)
        if i == 1
            draws[1:sum(Ns[1:i])] = resample(uval, Ns[i])
        else 
            draws[sum(Ns[1:(i-1)])+1:sum(Ns[1:i])] = resample(uval, Ns[i])
        end
    end
    
    return UncertainValue(UnivariateKDE, draws, 
        bandwidth = bw isa Real ? bw : default_bandwidth(draws))

end

"""
    combine(uvals::Vector{AbstractUncertainValue}, weights::FrequencyWeights;
        bw::Union{Nothing, Real} = nothing)

Combine multiple uncertain values into a single uncertain value. This is
done by resampling each uncertain value in `uvals` according to their relative
frequencies (the absolute number of draws provided by `weights`). Finally, a kernel density 
estimate to the final distribution is computed over the `sum(weights)` total draws.

The KDE bandwidth is controlled by `bw`. By default, `bw = nothing`; in this case, 
the bandwidth is determined using the `KernelDensity.default_bandwidth` function.

!!! tip

    For very wide and close-to-normal distributions, the default bandwidth may work well. 
    If you're combining very peaked distributions or discrete populations, however, 
    you may want to lower the bandwidth significantly.

# Example

```julia
v1 = UncertainValue(Normal, 1, 0.3)
v2 = UncertainValue(Normal, 0.8, 0.4)
v3 = UncertainValue([rand() for i = 1:3], [0.3, 0.3, 0.4])
v4 = UncertainValue(Normal, 3.7, 0.8)
uvals = [v1, v2, v3, v4];

# Two difference syntax options
combine(uvals, FrequencyWeights([100, 500, 343, 7000]))
combine(uvals, pweights([1410, 550, 223, 801]))
```
"""
function combine(uvals::Vector{AbstractUncertainValue}, weights::FrequencyWeights;
        bw::Union{Nothing, Real} = nothing)
    
    length(uvals) == length(weights) ? "Number of values != number of weights" : nothing
    
    # Scale the number of draws of each value according to their relative probability
    Ns = weights
    N = sum(Ns)
                
    draws = zeros(Float64, N)
    for (i, uval) in enumerate(uvals)
        if i == 1
            draws[1:sum(Ns[1:i])] = resample(uval, Ns[i])
        else 
            draws[sum(Ns[1:(i-1)])+1:sum(Ns[1:i])] = resample(uval, Ns[i])
        end
    end
    
    return UncertainValue(UnivariateKDE, draws, 
        bandwidth = bw isa Real ? bw : default_bandwidth(draws))
end

export combine, 
    ProbabilityWeights, pweights, 
    Weights, weights,
    AnalyticWeights, aweights,
    FrequencyWeights, fweights