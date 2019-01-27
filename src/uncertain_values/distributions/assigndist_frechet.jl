"""
    assigndist_frechet(α, θ; trunc_lower = -Inf, trunc_upper = Inf)

Assign parameters to a Fréchet distribution with parameters `α` and `θ`, optionally 
truncating the distribution.
"""
function assigndist_frechet(α, θ; trunc_lower = -Inf, trunc_upper = Inf)
    Truncated(Frechet(α, θ), trunc_lower, trunc_upper)
end

export assigndist_frechet
