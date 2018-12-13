"""
    assigndist_beta(α, β)

Assign parameters to a Beta distribution with parameters `α` and `β`.
"""
function assigndist_beta(α, β)
    Beta(α, β)
end

function assigndist_beta(α, β; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(Beta(α, β), trunc_lower, trunc_upper)
end

export assigndist_beta
