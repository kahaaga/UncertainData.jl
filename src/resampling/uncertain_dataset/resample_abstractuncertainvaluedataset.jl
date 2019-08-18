

"""
    resample_elwise(uvd::AbstractUncertainValueDataset, n::Int)

Resample each element in `uvals` `n` times. The i-th entry in the returned 
vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`.
"""
function resample_elwise(uvd::AbstractUncertainValueDataset, n::Int)
    [resample(uvd[i], n) for i = 1:length(uvd)]
end

"""
    resample_elwise(uvd::UncertainIndexDataset, constraint::SamplingConstraint, n::Int)

Resample each element in `uvals` `n` times. The i-th entry in the returned 
vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`, drawn 
after first truncating the support of `uvals[i]` according to the provided `constraint`.
"""
function resample_elwise(uvd::AbstractUncertainValueDataset, 
        constraint::SamplingConstraint, n::Int)
    
    [resample(uvd[i], constraint, n) for i = 1:length(uvd)]
end