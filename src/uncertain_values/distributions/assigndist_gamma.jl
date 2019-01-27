"""
    assigndist_gamma(α, θ; trunc_lower = -Inf, trunc_upper = Inf)

Assign parameters to a Gamma distribution with parameters `α` and `θ`, optionally 
truncating the distribution.
"""
function assigndist_gamma(α, θ; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(Gamma(α, θ), trunc_lower, trunc_upper)
end

export assigndist_gamma
