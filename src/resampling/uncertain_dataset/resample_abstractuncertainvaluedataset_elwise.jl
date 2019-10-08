
import ..UncertainDatasets:
    UVAL_COLLECTION_TYPES

import ..SamplingConstraints: 
    SamplingConstraint

import ..UVAL_COLLECTION_TYPES

"""
    resample_elwise(uvd::UVAL_COLLECTION_TYPES)

Resample each element in `uvals` once. The i-th entry in the returned 
vector is a `1`-element vector containing one unique draw of `uvals[i]`.
"""
function resample_elwise(uvd::UVAL_COLLECTION_TYPES)
    [resample(uvd[i], 1) for i = 1:length(uvd)]
end

"""
    resample_elwise(uvd::UVAL_COLLECTION_TYPES, n::Int)

Resample each element in `uvals` `n` times. The i-th entry in the returned 
vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`.
"""
function resample_elwise(uvd::UVAL_COLLECTION_TYPES, n::Int)
    [resample(uvd[i], n) for i = 1:length(uvd)]
end

"""
    resample_elwise(uvd::UVAL_COLLECTION_TYPES, 
        constraint::Union{SamplingConstraint, Vector{SamplingConstraint}},
        n::Int)

Resample each element in `uvals` `n` times. The i-th entry in the returned 
vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`, drawn 
after first truncating the support of `uvals[i]` according to the provided `constraint`(s).
"""
resample_elwise(uvd::UVAL_COLLECTION_TYPES, 
    constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
    n::Int)


function resample_elwise(uvd::UVAL_COLLECTION_TYPES, 
        constraint::SamplingConstraint, n::Int)
    
    [resample(uvd[i], constraint, n) for i = 1:length(uvd)]
end


function resample_elwise(uvd::UVAL_COLLECTION_TYPES, 
        constraint::Vector{<:SamplingConstraint}, 
        n::Int)
    
    Lc, Luv = length(constraint), length(uvd)
    
    if Lc != Luv
        error("""The number of constraints must match the number of uncertain values in the dataset. Got $Lc constraint but needed $Luv.""")
    end
    
    [resample(uvd[i], constraint[i], n) for i = 1:length(uvd)]
end