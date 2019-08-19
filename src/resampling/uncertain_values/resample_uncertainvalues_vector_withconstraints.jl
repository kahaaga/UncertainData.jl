
"""
resample(uvals::Vector{AbstractUncertainValue}, c::SamplingConstrant)

Treat `uvals` as a dataset and resample each value of `uvals` once,
Returns an `length(uvals)`-element vector.
"""
resample(uvals::Vector{AbstractUncertainValue}, c::SamplingConstrant) = resample.(uvals, c)


"""
resample(uvals::Vector{AbstractUncertainValue}, n::Int) 

Treat `uvals` as a dataset and resample it `n` times. 
Returns `n` resampled draws of `uvals`, each being a `length(uvals)`-element vector. 
For each returned vector, the i-th element is a unique draw of `uvals[i]`. 
"""
function resample(uvals::Vector{AbstractUncertainValue}, n::Int) 
[resample.(uvals) for i = 1:n]
end

"""
resample_elwise(uvals::Vector{AbstractUncertainValue}, n::Int) 

Resample each element in `uvals` `n` times. The i-th entry in the returned 
vector is a `n`-element vector consisting of `n` unique draws of `uvals[i]`.
"""
function resample_elwise(uvals::Vector{AbstractUncertainValue}, n::Int) 
    [resample(uvals[i], n) for i = 1:length(uvals)]
end