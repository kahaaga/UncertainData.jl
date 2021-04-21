import ..SamplingConstraints: 
    StartToEnd,
    StrictlyDecreasing,
    sequence_exists,
    constrain,
    TruncateMaximum,
    TruncateRange, 
    TruncateQuantiles

import IntervalArithmetic: 
    interval

function _draw!(s, x, c::StrictlyDecreasing{<:StartToEnd}, mins, maxs)
    L = length(x)
    
    # TODO: add slight margin?
    for i = 1:L
        if i == 1
            lo = maximum(mins[2:end])
            truncated_distribution = truncate(x[i], TruncateMinimum(lo))
            s[1] = resample(truncated_distribution)
        end
        
        if 1 < i < L
            hi = min(s[i - 1], maxs[i])
            lo = max(mins[i], maximum(mins[i+1:end]))
            
            lo <= hi || error("Truncation range invalid for point $i. Got lo < hi ($lo < $hi), which should be impossible.")
            
            truncated_distribution = truncate(x[i], TruncateRange(lo, hi))
            s[i] = resample(truncated_distribution)
        end
        
        if i == L
            hi = min(s[i - 1], maxs[i])
            truncated_distribution = truncate(x[i], TruncateMaximum(hi))
            s[end] = resample(truncated_distribution)

        end
    end
    
    return s
end

"""
    _draw(x, c::StrictlyDecreasing{StartToEnd}, mins, maxs)

Sample `x` in a strictly decreasing manner, given pre-computed minimum and maximum 
values for each distribution in `c`.

Implicitly assumes a strictly decreasing sequence exists, but does not check that condition.
"""
function _draw(x, c::StrictlyDecreasing{<:StartToEnd}, mins, maxs)    
    L = length(x)
    samples = zeros(Float64, L) # a vector to hold the element-wise samples
    
    _draw!(samples, x, c, mins, maxs)
end
