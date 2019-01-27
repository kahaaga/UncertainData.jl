"""
    assigndist_beta(α, β; trunc_lower = -Inf, trunc_upper = Inf)

Assign parameters to a Beta distribution with parameters `α` and `β`, optionally 
truncating the distribution.
""" 
function assigndist_beta(α, β; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(Beta(α, β), trunc_lower, trunc_upper)
end

export assigndist_beta
