using IntervalArithmetic
include("utils.jl")
import ..AbstractUncertainIndexValueDataset

export 
sequence_exists,
sequence_exists!

""" 
    sequence_exists(x, c::SequentialSamplingConstraint) 

Does a point-by-point sequence through the uncertain dataset `x` exist that satisfies the criteria `c`?

If `x` is an `UncertainIndexValueDataset`, then check for a sequence through the indices only.

Before the check is performed, the distributions in `x` are truncated to the quantiles provided 
by `c` to ensure they have finite supports.

## Example

```julia
# Create a set of time indices 
# We construct this is such a way that we *know* an increasing sequence exists. 
t = [UncertainValue(Normal, i, 2) for i in 1:N];
sequence_exists(t, StrictlyIncreasing(StartToEnd()))
```
""" 
function sequence_exists end

# If data has uncertainties both in indices and values, check only for indices.
sequence_exists(x::AbstractUncertainIndexValueDataset, c) = sequence_exists(x.indices, c)

function sequence_exists(x, c::SequentialSamplingConstraint)
    lqs, uqs = get_quantiles(x, c)
    
    return sequence_exists(lqs, uqs, c), lqs, uqs
end

function sequence_exists!(lqs, uqs, x::AbstractUncertainValueDataset, c)
    get_quantiles!(lqs, uqs, x, c)
    
    return sequence_exists(lqs, uqs, c)
end

sequence_exists(x::AbstractUncertainIndexValueDataset, c::StrictlyIncreasing{StartToEnd}) = 
    sequence_exists(x.indices, c)

###########################
# Concrete implementations 
###########################
"""
    sequence_exists(udata::AbstractUncertainValueDataset, c::StrictlyDecreasing{StartToEnd}) 

Does a strictly decreasing sequence through the dataset exist? I.e,  check that a strictly 
decreasing sequence can be found after first 
constraining each distribution to the provided quantile range (this 
is necessary because some distributions may have infinite support).
"""
function sequence_exists(lqs, uqs, c::StrictlyIncreasing{StartToEnd})
    L = length(lqs)
    if any(lqs .> uqs) # ties are allowed, because we have `CertainValue`s
        error("Not all `lqs[i]` are lower than uqs[i]. Quantile calculations are not meaningful.")
        return false
    end
    
    for i = 1:L-1
        if lqs[i] >= minimum(uqs[i+1:end])
            return false
        end
    end
    return true
end

function sequence_exists(lqs, uqs, c::StrictlyDecreasing{StartToEnd})
    L = length(lqs)
    if any(lqs .> uqs) # ties are allowed, because we have `CertainValue`s
        error("Not all `lqs[i]` are lower than uqs[i]. Quantile calculations are not meaningful.")
        return false
    end
    
    for i = 1:L-1
        if uqs[i] < maximum(lqs[i+1:end])
            return false
        end
    end
    return true
end