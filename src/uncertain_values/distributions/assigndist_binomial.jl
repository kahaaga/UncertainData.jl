"""
    assigndist_binomial(n, p; trunc_lower = -Inf, trunc_upper = Inf)

Assign parameters to a binomial distribution with `n` trials and probability `p`
of success in individual trials, optionally truncating the distribution.
"""
function assigndist_binomial(n, p; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(Binomial(n, p), trunc_lower, trunc_upper)
end

export assigndist_binomial
