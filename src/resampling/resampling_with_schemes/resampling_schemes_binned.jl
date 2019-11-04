
"""
    resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedMeanWeightedResampling)

Transform index-irregularly spaced uncertain data onto a regular index-grid and 
take the mean of the values in each bin. Resamples the data points in `x` 
according to `resampling.weights`.

Distributions in each index bin are obtained by resampling all index values in `x` 
`resampling.n` times, in proportions obeying `resampling.weights` and mapping those 
index draws to the bins. Simultaneously, the values in `x` are resampled and placed 
in the corresponding bins. Finally, the mean in each bin is calculated. In total, 
`length(x)*resampling.n` draws are distributed among the bins to form the final mean 
estimate.

Returns a vector of mean values, one for each bin.

Assumes that the points in `x` are independent.

## Example

```julia
vars = (1, 2)
npts, tstep = 100, 10
d_xind = Uniform(2.5, 15.5)
d_yind = Uniform(2.5, 15.5)
d_xval = Uniform(0.01, 0.2)
d_yval = Uniform(0.01, 0.2)

X, Y = example_uncertain_indexvalue_datasets(ar1_unidir(c_xy = 0.5), npts, vars, tstep = tstep,
d_xind = d_xind, d_yind = d_yind,
d_xval = d_xval, d_yval = d_yval);

n_draws = 10000 # draws per uncertain value
time_grid = 0:50:1000
wts = Weights(rand(length(X))) # some random weights

# Resample both X and Y so that they are both at the same time indices, 
# and take the mean of each bin.
resampled_dataset = resample(X, BinnedMeanWeightedResampling(time_grid, wts, n_draws))
resampled_dataset = resample(Y, BinnedMeanWeightedResampling(time_grid, wts, n_draws))
```
"""
function resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedMeanWeightedResampling)
    
    # Represent entire dataset as a weighted population and sample from that 
    pop_inds = UncertainValue(x.indices.indices, resampling.weights)
    pop_vals = UncertainValue(x.values.values, resampling.weights)

    # Pre-allocate an array representing each bin, and an array keeping track
    # of the values falling in that bin.
    n_bins = length(resampling.left_bin_edges) - 1
    bin_sums = fill(0.0, n_bins)
    bin_sums_n_entries = fill(0.0, n_bins)

    # Pre-allocate some arrays into which we resample the values of the 
    # index and value populations.
    idxs = fill(NaN, resampling.n)
    vals = fill(NaN, resampling.n)

    # Used to compute the index of the bin into which a draw belongs
    mini = minimum(resampling.left_bin_edges)
    s = step(resampling.left_bin_edges)

    for (j, (pop_idx, pop_val)) in enumerate(zip(pop_inds, pop_vals))

        # Sample the j-th idx-value pair `resampling.n` times and 
        # accumulate the values in the correct bin sum. Also keep
        # track of how many values there are in each bin.
        resample!(idxs, pop_idx) 
        resample!(vals, pop_val)
        
        @inbounds for i = 1:resampling.n
            arr_idx = ceil(Int, (idxs[i] - mini) / s)
            
            # Because the indices of `x` are uncertain values 
            # with potentially infinite support, we need to check
            # that the value falls inside the grid
            if 0 < arr_idx <= n_bins
                bin_sums[arr_idx] += vals[i]
                bin_sums_n_entries[arr_idx] += 1.0
            end
        end
    end

    # Return bin averages (entries with 0s are represented as NaNs)
    bin_avgs = bin_sums ./ bin_sums_n_entries
    bin_avgs[isapprox.(bin_avgs, 0.0)] .= NaN
    return bin_avgs
end

"""
    resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedMeanResampling)

Transform index-irregularly spaced uncertain data onto a regular index-grid and 
take the mean of the values in each bin. 

Distributions in each index bin are obtained by resampling all index values in `x` 
`resampling.n` times, and mapping those index draws to the bins. Simultaneously, the 
values in `x` are resampled and placed in the corresponding bins. Finally, the mean 
in each bin is calculated. In total, `length(x)*resampling.n` draws are distributed 
among the bins to form the final mean estimate.

Returns a vector of mean values, one for each bin.

Assumes that the points in `x` are independent.

## Example

```julia
vars = (1, 2)
npts, tstep = 100, 10
d_xind = Uniform(2.5, 15.5)
d_yind = Uniform(2.5, 15.5)
d_xval = Uniform(0.01, 0.2)
d_yval = Uniform(0.01, 0.2)

X, Y = example_uncertain_indexvalue_datasets(ar1_unidir(c_xy = 0.5), npts, vars, tstep = tstep,
    d_xind = d_xind, d_yind = d_yind,
    d_xval = d_xval, d_yval = d_yval);

n_draws = 10000 # draws per uncertain value
time_grid = 0:50:1000

# Resample both X and Y so that they are both at the same time indices, 
# and take the mean of each bin.
resampled_dataset = resample(X, BinnedMeanResampling(time_grid, n_draws))
resampled_dataset = resample(Y, BinnedMeanResampling(time_grid, n_draws))
```
"""
function resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedMeanResampling)
     
    # Constrain 
    # Represent entire dataset as an equally-weighted population and sample from that 
    pop_inds = UncertainValue(x.indices.indices, [1 for x in x.indices])
    pop_vals = UncertainValue(x.values.values, [1 for x in x.values])
    
    # Pre-allocate an array representing each bin, and an array keeping track
    # of the values falling in that bin.
    n_bins = length(resampling.left_bin_edges) - 1
    bin_sums = fill(0.0, n_bins)
    bin_sums_n_entries = fill(0.0, n_bins)

    # Pre-allocate some arrays into which we resample the values of the 
    # index and value populations.
    idxs = fill(NaN, resampling.n)
    vals = fill(NaN, resampling.n)
    
    # Used to compute the index of the bin into which a draw belongs
    mini = minimum(resampling.left_bin_edges)
    s = step(resampling.left_bin_edges)
    
    for (j, (pop_idx, pop_val)) in enumerate(zip(pop_inds, pop_vals))
    
        # Sample the j-th idx-value pair `resampling.n` times and 
        # accumulate the values in the correct bin sum. Also keep
        # track of how many values there are in each bin.
        resample!(idxs, pop_idx) 
        resample!(vals, pop_val)
        
        @inbounds for i = 1:resampling.n
            arr_idx = ceil(Int, (idxs[i] - mini) / s)
            
            # Because the indices of `x` are uncertain values 
            # with potentially infinite support, we need to check
            # that the value falls inside the grid
            if 0 < arr_idx <= n_bins
                bin_sums[arr_idx] += vals[i]
                bin_sums_n_entries[arr_idx] += 1.0
            end
        end
    end
    
    # Return bin averages (entries with 0s are represented as NaNs)
    bin_avgs = bin_sums ./ bin_sums_n_entries
    bin_avgs[isapprox.(bin_avgs, 0.0)] .= NaN
    return bin_avgs
end

"""
    resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedResampling;
        nan_threshold = 0.0)

Transform index-irregularly spaced uncertain data onto a regular index-grid.
Distributions in each index bin are obtained by resampling all index values 
in `x` `resampling.n` times, and mapping those index draws to the bins. 
Simultaneously, the values in `x` are resampled and placed in the corresponding
bins. In total, `length(x)*resampling.n` draws are distributed among the bins to form 
the final KDEs.

Returns an `UncertainIndexValueDataset`. The distribution of values in the `i`-th bin 
is approximated by a kernel density estimate (KDE) over the draws falling in the 
`i`-th bin.

Assumes that the points in `x` are independent.

## Example

```julia
vars = (1, 2)
npts, tstep = 100, 10
d_xind = Uniform(2.5, 15.5)
d_yind = Uniform(2.5, 15.5)
d_xval = Uniform(0.01, 0.2)
d_yval = Uniform(0.01, 0.2)

X, Y = example_uncertain_indexvalue_datasets(ar1_unidir(c_xy = 0.5), npts, vars, tstep = tstep,
    d_xind = d_xind, d_yind = d_yind,
    d_xval = d_xval, d_yval = d_yval);

n_draws = 10000 # draws per uncertain value
time_grid = 0:50:1000
resampling = BinnedResampling(time_grid, n_draws)

# Resample both X and Y so that they are both at the same time indices.
resampled_dataset = resample(X, resampling)
resampled_dataset = resample(Y, resampling)
```
"""
function resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedResampling;
        nan_threshold = 0.0)

    # Pre-allocate some arrays into which we resample the values of the 
    # index and value populations.
    idxs = fill(NaN, resampling.n)
    vals = fill(NaN, resampling.n)
    
    perminds = zeros(Int, resampling.n)
    sorted_idxs = fill(NaN, resampling.n)
    sorted_vals = fill(NaN, resampling.n)
    
    
    bin_edges = resampling.left_bin_edges
    n_bins = length(bin_edges) - 1
    
    # Used to compute the index of the bin into which a draw belongs
    mini = minimum(resampling.left_bin_edges)
    s = step(resampling.left_bin_edges)
        
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
    
    # Estimate distributions in each bin by kernel density estimation
    estimated_value_dists = Vector{AbstractUncertainValue}(undef, n_bins)
    
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

"""
    resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedWeightedResampling;
        nan_threshold = 0.0)

Transform index-irregularly spaced uncertain data onto a regular index-grid.
Distributions in each index bin are obtained by resampling all index values 
in `x` `resampling.n` times, sampled according to probabilities `resampling.weights`,
and mapping those index draws to the bins. Simultaneously, the values in `x` are 
resampled and placed in the corresponding bins. In total, `length(x)*resampling.n` draws 
are distributed among the bins to form the final KDEs. 

Returns an `UncertainIndexValueDataset`. The distribution of values in the `i`-th bin 
is approximated by a kernel density estimate (KDE) over the draws falling in the 
`i`-th bin.

Assumes that the points in `x` are independent.

## Example

```julia
vars = (1, 2)
npts, tstep = 100, 10
d_xind = Uniform(2.5, 15.5)
d_yind = Uniform(2.5, 15.5)
d_xval = Uniform(0.01, 0.2)
d_yval = Uniform(0.01, 0.2)

X, Y = example_uncertain_indexvalue_datasets(ar1_unidir(c_xy = 0.5), npts, vars, tstep = tstep,
    d_xind = d_xind, d_yind = d_yind,
    d_xval = d_xval, d_yval = d_yval);

left_bin_edges = 0:50:1000
n_draws = 10000
wts = Weights(rand(length(X)))
resampling = BinnedWeightedResampling(left_bin_edges, wts, 10)
resampled_dataset = resample(X, resampling)
```
"""
function resample(x::AbstractUncertainIndexValueDataset, resampling::BinnedWeightedResampling;
        nan_threshold = 0.0)

    pop_inds = UncertainValue(x.indices.indices, resampling.weights)
    pop_vals = UncertainValue(x.values.values, resampling.weights)

    # Pre-allocate some arrays into which we resample the values of the 
    # index and value populations.
    idxs = fill(NaN, resampling.n)
    vals = fill(NaN, resampling.n)

    perminds = zeros(Int, resampling.n)
    sorted_idxs = fill(NaN, resampling.n)
    sorted_vals = fill(NaN, resampling.n)


    bin_edges = resampling.left_bin_edges
    n_bins = length(bin_edges) - 1

    # Used to compute the index of the bin into which a draw belongs
    mini = minimum(resampling.left_bin_edges)
    s = step(resampling.left_bin_edges)
        
    # Empty vectors that will contain draws.
    binvecs = [Vector{Float64}(undef, 0) for i = 1:n_bins] 
    #[sizehint!(bv, resampling.n*n_bins) for bv in binvecs]

    @inbounds for (j, (idx, val)) in enumerate(zip(pop_inds, pop_vals))
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

    # Estimate distributions in each bin by kernel density estimation
    estimated_value_dists = Vector{AbstractUncertainValue}(undef, n_bins)

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