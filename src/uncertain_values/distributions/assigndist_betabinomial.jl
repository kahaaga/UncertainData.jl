"""
    assigndist_betabinomial(n, α, β; trunc_lower = -Inf, trunc_upper = Inf)

Assign parameters to a beta binomial distribution with `n` trials and
shape parameters `α` and `β`, optionally truncating the distribution.
"""
function assigndist_betabinomial(n, α, β; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(BetaBinomial(n, α, β), trunc_lower, trunc_upper)
end

export assigndist_betabinomial
