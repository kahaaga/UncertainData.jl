import Base: merge

"""
    merge(uvals::Vector{<:AbstractUncertainValue}, n = 1000)

Merge uncertain values into one combined kernel density estimate by resampling `n` times 
each uncertain value in `udata`, then pooling these draws together, and finally computing a 
kernel density estimate to the ensemble of resampled values.
"""
function merge(uvals::Vector{<:AbstractUncertainValue}, n = 1000)
    N = length(uvals)
    draws = zeros(Float64, N*n)
    for (i, uval) in enumerate(uvals)
        draws[(i-1)*n+1:i*n] = resample(uval, n)
    end
    
    return UncertainValue(draws)
end

export merge