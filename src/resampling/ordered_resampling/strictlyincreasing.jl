import ..SamplingConstraints:
    SamplingConstraint,
    SequentialSamplingConstraint,
    OrderedSamplingAlgorithm,
    StartToEnd,
    StrictlyIncreasing,
    sequence_exists,
    TruncateMinimum, 
    TruncateRange,
    TruncateQuantiles,
    constrain


export resample

import IntervalArithmetic:
    interval

function _draw!(s, x, c::StrictlyIncreasing{<:StartToEnd}, mins, maxs)
    L = length(x)
    
    # TODO: add slight margin?
    for i = 1:L
        if i == 1
            hi = minimum(maxs[2:end])
            truncated_distribution = truncate(x[i], TruncateMaximum(hi))
            s[i] = resample(truncated_distribution)
        end
        
        if 1 < i < L
            lo = max(s[i - 1], mins[i])
            hi = min(maxs[i], minimum(maxs[i+1:end]))
            
            lo <= hi || error("Truncation range invalid for point $i. Got lo < hi ($lo < $hi), which should be impossible.")
            
            truncated_distribution = truncate(x[i], TruncateRange(lo, hi))
            s[i] = resample(truncated_distribution)
        end
        
        if i == L
            lo = max(s[i - 1], mins[i])
            truncated_distribution = truncate(x[i], TruncateMinimum(lo))
            s[i] = resample(truncated_distribution)

        end
    end
    
    return s
end

"""
    _draw(x, c::StrictlyIncreasing{StartToEnd}, mins, maxs)

Sample `x` in a strictly increasing manner, given pre-computed minimum and maximum 
values for each distribution in `c`.

Implicitly assumes a strictly increasing sequence exists, but does not check that condition.
"""
function _draw(x, c::StrictlyIncreasing{<:StartToEnd}, mins, maxs)    
    L = length(x)
    samples = zeros(Float64, L) # a vector to hold the element-wise samples
    
    _draw!(samples, x, c, mins, maxs)
end

