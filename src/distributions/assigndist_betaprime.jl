"""
    assigndist_betaprime(α, β)

Assign parameters to a Beta prime distribution with parameters `α` and `β`.
"""
function assigndist_betaprime(α, β)
    BetaPrime(α, β)
end

function assigndist_betaprime(α, β; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(BetaPrime(α, β), trunc_lower, trunc_upper)
end

export assigndist_betaprime
