import KernelDensity: UnivariateKDE, default_bandwidth, kde
import Distributions: Distribution

"""
    bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{UncertainScalarKDE}) -> UncertainIndexValueDataset
    bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{UncertainScalarPopulation}) -> UncertainIndexValueDataset

Resample every element of `x` a number of times. After resampling, distribute the 
values according to their indices, into the `N` bins given by the `N-1`-element 
grid defined by `binning.left_bin_edges`. In total, `length(x)*binning.n` draws 
are distributed among the bins. The precise number of times `x[i]` is resampled is 
given by `binning.weights[i]` (probability weights are always normalised to 1).
    
## Returns 

Returns an `UncertainIndexValueDataset`. Indices are assumed to be uniformly distributed within each 
bin, and are represented as `CertainScalar`s at the bin centers. Values of the dataset have different 
representations depending on what `binning` is:

- If `binning isa BinnedWeightedResampling{UncertainScalarKDE}`, then values in each bin are 
    represented by a kernel density estimate to the distribution of the resampled values whose 
    resampled indices fall in that bin.
- If `binning isa BinnedWeightedResampling{UncertainScalarPopulation}`, then values in each bin are 
    represented by equiprobable populations consisting of the resampled values whose resampled 
    indices fall in the bins.
"""
function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling); end

"""
    bin(x::AbstractUncertainIndexValueDataset, 
        binning::BinnedWeightedResampling{RawValues}) -> Tuple(Vector, Vector{Vector})

Resample every element of `x` a number of times. After resampling, distribute the 
values according to their indices, into the `N` bins given by the `N-1`-element 
grid defined by `binning.left_bin_edges`. In total, `length(x)*binning.n` draws 
are distributed among the bins. The precise number of times `x[i]` is resampled is 
given by the `binning.weights[i]` (probability weights are always normalised to 1).

## Returns 

Return a tuple containing the `N` different bin centers and a `N`-length vector of 
resampled values whose resampled indices fall in the `N` different bins.

## Example 

```julia
using Plots, UncertainData
# Some example data with unevenly spaced time indices
function ar1(n::Int, x0 = 0.5, p = 0.3)
    vals = zeros(n)
    [vals[i] = vals[i - 1]*p + rand()*0.5 for i = 2:n]
    return vals
end

npts = 50
time, vals = sort(rand(1:1000, npts)), ar1(npts)

# Add uncertainties to indices and values, and represent as 
# UncertainIndexValueDataset 
utime = [UncertainValue(Normal, t, 5) for t in time]
uvals = [UncertainValue(Normal, v, 0.03) for v in vals]

udata = UncertainIndexValueDataset(utime, uvals)

# Bin data into fall in 25 time step wide time bins ranging 
# from time indices 100 to 900 and return a vector of raw 
# values for each bin. Do this by resampling each uncertain
# data point on average 10000 times and distributing those 
# draws among the bins. 
time_grid = 100:40:900
n_draws = 5000
# Let odd-indexed values be three times as likely to be 
# sampled compared to even-indexed values.
wts = Weights([i % 2 == 0 ? 1 : 3 for i = 1:length(udata)])
binning = BinnedWeightedResampling(RawValues, time_grid, wts, n_draws)

bin_centers, bin_draws = bin(udata, binning);
```
"""
function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{RawValues};
        nan_threshold = 0.0)
    
    # Determine how many times each element of `x` should be resampled 
    # based on the provided weights. 
    wts = binning.weights ./ sum(binning.weights) 
    
    n_total_draws = binning.n * length(x)
    Ns = ceil.(Int, n_total_draws .* binning.weights)
    
    # Separately convert indices and values to weighted populations
    pop_inds = UncertainValue(x.indices.indices, wts)
    pop_vals = UncertainValue(x.values.values, wts)

    bin_edges = binning.left_bin_edges
    n_bins = length(bin_edges) - 1

    # Used to compute the index of the bin into which a draw belongs
    mini = minimum(binning.left_bin_edges)
    s = step(binning.left_bin_edges)
        
    # Empty vectors that will contain draws.
    binvecs = [Vector{Float64}(undef, 0) for i = 1:n_bins] 
    #[sizehint!(bv, n_total_draws) for bv in binvecs]

    for (i, N) in enumerate(Ns)
        # Pre-allocate some arrays into which we resample the values of the 
        # index and value populations.
        idxs = fill(NaN, N)
        vals = fill(NaN, N)

        perminds = zeros(Int, N)
        sorted_idxs = fill(NaN, N)
        sorted_vals = fill(NaN, N)
        
        # Resample the i-th index and i-th value
        resample!(idxs, pop_inds[i])
        resample!(vals, pop_vals[i])
        
        # Get the vector that sorts the index vector, and use that to 
        # sort the draws.
        sortperm!(perminds, idxs)
        sorted_idxs .= idxs[perminds]
        sorted_vals .= vals[perminds]
        
        # The vectors above are sorted sorted, so this can be done faster
        for i in 1:n_bins
            inbin = findall(bin_edges[i] .<= sorted_idxs .<= bin_edges[i+1])
            if length(inbin) > nan_threshold
                append!(binvecs[i], sorted_vals[inbin])
            end   
        end
    end

    bin_centers = bin_edges[1:end-1] .+ step(bin_edges)/2
    
    return bin_centers, binvecs
end

function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{UncertainScalarKDE};
        nan_threshold = 0.0)

    bin_edges = binning.left_bin_edges
    n = binning.n
    wts = binning.weights
    binning = BinnedWeightedResampling(RawValues, bin_edges, wts, n)
    
    bin_centers, binvecs = bin(x, binning)
    
    
    # Estimate distributions in each bin by kernel density estimation
    n_bins = length(binning.left_bin_edges) - 1
    estimated_value_dists = Vector{Union{CertainScalar, UncertainScalarKDE}}(undef, n_bins)
    
    for i in 1:n_bins
        if length(binvecs[i]) > nan_threshold
            estimated_value_dists[i] = UncertainValue(binvecs[i])
        else 
            estimated_value_dists[i] = UncertainValue(NaN)
        end
    end
    
    new_inds = UncertainIndexDataset(UncertainValue.(bin_edges[1:end-1] .+ step(bin_edges)/2))
    new_vals = UncertainValueDataset(estimated_value_dists)
    
    UncertainIndexValueDataset(new_inds, new_vals)
end

function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedWeightedResampling{UncertainScalarPopulation};
        nan_threshold = 0.0)

    bin_edges = binning.left_bin_edges
    n = binning.n
    wts = binning.weights
    binning = BinnedWeightedResampling(RawValues, bin_edges, wts, n)
    
    bin_centers, binvecs = bin(x, binning)
    
    
    # Estimate distributions in each bin by kernel density estimation
    n_bins = length(binning.left_bin_edges) - 1
    estimated_value_dists = Vector{Union{CertainScalar, UncertainScalarPopulation}}(undef, n_bins)
    
    for i in 1:n_bins
        if length(binvecs[i]) > nan_threshold
            L = length(binvecs[i])
            estimated_value_dists[i] = UncertainValue(binvecs[i], repeat([1 / L], L))
        else 
            estimated_value_dists[i] = UncertainValue(NaN)
        end
    end
    
    new_inds = UncertainIndexDataset(UncertainValue.(bin_edges[1:end-1] .+ step(bin_edges)/2))
    new_vals = UncertainValueDataset(estimated_value_dists)
    
    UncertainIndexValueDataset(new_inds, new_vals)
end



import KernelDensity: UnivariateKDE, default_bandwidth, kde
import Distributions: Distribution