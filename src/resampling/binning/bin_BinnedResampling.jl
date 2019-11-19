import KernelDensity: UnivariateKDE, default_bandwidth, kde
import Distributions: Distribution

"""
    bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{UncertainScalarKDE}) -> UncertainIndexValueDataset
    bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{UncertainScalarPopulation}) -> UncertainIndexValueDataset

Resample every element of `x` the number of times given by `binning.n`. After resampling,
distribute the values according to their indices, into the bins given by `binning.left_bin_edges`.

## Returns 

Returns an `UncertainIndexValueDataset`. Indices are assumed to be uniformly distributed within each 
bin, and are represented as `CertainValue`s at the bin centers. Values of the dataset have different 
representations depending on what `binning` is:

- If `binning isa BinnedResampling{UncertainScalarKDE}`, then values in each bin are represented by a 
    kernel density estimate to the distribution of the resampled values whose resampled indices 
    fall in that bin.
- If `binning isa BinnedResampling{UncertainScalarPopulation}`, then values in each bin are 
    represented by equiprobable populations consisting of the resampled values whose resampled 
    indices fall in the bins.
"""
function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling); end

"""
    bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{RawValues}) -> Tuple(Vector, Vector{Vector})

Resample every element of `x` the number of times given by `binning.n`. After resampling,
distribute the values according to their indices, into the `N` bins given by `binning.left_bin_edges`.

## Returns 

Return a tuple containing the `N` different bin centers and a `N`-length vector of 
resampled values whose resampled indices fall in the `N` different bins.

## Example 

```julia
# Some example data with unevenly spaced time indices
npts = 300
time, vals = sort(rand(1:1000, npts)), rand(npts)

# Add uncertainties to indices and values, and represent as 
# UncertainIndexValueDataset 
utime = [UncertainValue(Normal, t, 10) for t in time]
uvals = [UncertainValue(Normal, v, 0.1) for v in vals]

udata = UncertainIndexValueDataset(utime, uvals)

# Bin data into fall in 25 time step wide time bins ranging 
# from time indices 100 to 900 and return a vector of raw 
# values for each bin. Do this by resampling each uncertain
# data point 10000 times and distributing those draws among 
# the bins.
left_bin_edges = 100:25:900
n_draws = 10000
binning = BinnedResampling(RawValues, left_bin_edges, n_draws)

bin_centers, bin_draws = bin(udata, binning)
```
"""
function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{RawValues};
        nan_threshold = 0.0)
    # Pre-allocate some arrays into which we resample the values of the 
    # index and value populations.
    idxs = fill(NaN, binning.n)
    vals = fill(NaN, binning.n)

    perminds = zeros(Int, binning.n)
    sorted_idxs = fill(NaN, binning.n)
    sorted_vals = fill(NaN, binning.n)

    bin_edges = binning.left_bin_edges
    n_bins = length(bin_edges) - 1

    # Used to compute the index of the bin into which a draw belongs
    mini = minimum(binning.left_bin_edges)
    s = step(binning.left_bin_edges)
        
    # Empty vectors that will contain draws.
    binvecs = [Vector{Float64}(undef, 0) for i = 1:n_bins] 
    #[sizehint!(bv, resampling.n*n_bins) for bv in binvecs]

    @inbounds for (j, (idx, val)) in enumerate(zip(x.indices, x.values))
        # Resample the j-th index and j-th value
        resample!(idxs, idx)
        resample!(vals, val)
        
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

function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{UncertainScalarPopulation};
        nan_threshold = 0)
    
    # Get bin center and a vector for each bin containing the values falling in that bin.
    left_bin_edges = binning.left_bin_edges
    n = binning.n
    n_bins = length(left_bin_edges) - 1

    bin_centers, binvecs = bin(x, BinnedResampling(RawValues, left_bin_edges, n))
    
    # Estimate distributions in each bin by kernel density estimation
    estimated_value_dists = Vector{Union{CertainValue, UncertainScalarPopulation}}(undef, n_bins)
    binvec_lengths = length.(binvecs)
    
    for i in 1:n_bins        
        L = binvec_lengths[i]
        # If bin contains enough values, represent as population. Otherwise, 
        # set to NaN.
        if L > nan_threshold
            probs = Weights(repeat([1/L], L))
            estimated_value_dists[i] = UncertainScalarPopulation(binvecs[i], probs)
        else 
            estimated_value_dists[i] = UncertainValue(NaN)
        end
    end
    
    new_inds = UncertainIndexDataset(bin_centers)
    new_vals = UncertainValueDataset(estimated_value_dists)
    
    UncertainIndexValueDataset(new_inds, new_vals)
end

function bin(x::AbstractUncertainIndexValueDataset, binning::BinnedResampling{UncertainScalarKDE};
        nan_threshold = 0, 
        kernel::Type{D} = Normal, 
        bw_factor = 4,
        npoints::Int = 2048) where {K <: UnivariateKDE, D <: Distribution}
    
    # Get bin center and a vector for each bin containing the values falling in that bin.
    left_bin_edges = binning.left_bin_edges
    n = binning.n
    n_bins = length(left_bin_edges) - 1

    bin_centers, binvecs = bin(x, BinnedResampling(RawValues, left_bin_edges, n))
    
    # Estimate distributions in each bin by kernel density estimation
    estimated_value_dists = Vector{Union{CertainValue, UncertainScalarKDE}}(undef, n_bins)
    binvec_lengths = length.(binvecs)
    
    for i in 1:n_bins        
        L = binvec_lengths[i]
        # If bin contains enough values, represent as KDE estimate. Otherwise, 
        # set to NaN.
        if L > nan_threshold
            bw = default_bandwidth(binvecs[i]) / bw_factor
            # Kernel density estimation
            KDE = kde(binvecs[i], npoints = npoints, kernel = kernel, bandwidth = bw)

            # Get the x value for which the density is estimated.
            xrange = KDE.x

            # Normalise estimated density
            density = KDE.density ./ sum(KDE.density)

            estimated_value_dists[i] = UncertainScalarKDE(KDE, binvecs[i], xrange, Weights(density))
        else 
            estimated_value_dists[i] = UncertainValue(NaN)
        end
    end
    
    new_inds = UncertainIndexDataset(bin_centers)
    new_vals = UncertainValueDataset(estimated_value_dists)
    
    UncertainIndexValueDataset(new_inds, new_vals)
end

export bin