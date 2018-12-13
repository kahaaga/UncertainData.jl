"""
    assigndist_normal(μ, lower, upper; nσ = 1,
        trunc_lower = -Inf, trunc_upper = Inf,
        tolerance = 1e-2μ)

Assign parameters to a Normal distribution based on location
parameter `μ`, together with `lower` and `upper` uncertainty
bounds. `nσ` indicates how many standard deviations away
from `μ` `lower`/`upper` are (they must be equidistant
from `μ`). `trunc_lower` and `trunc_upper` truncated the
distribution if specified (defaults to `-Inf` and `Inf`).
"""
function assigndist_normal(μ, lower, upper; nσ = 1,
        trunc_lower = -Inf, trunc_upper = Inf,
        tolerance = 1e-7)

    dist_from_μ_upper = upper - μ
    dist_from_μ_lower = μ - lower

    if abs((upper - μ) - (μ - lower)) > tolerance
        throw(DomainError("(μ - lower, upper - μ) = ($dist_from_μ_lower, $dist_from_μ_upper): lower and upper bounds are not equidistant-ish from μ. Cannot create normal distribution."))
    end
    σ_estim = dist_from_μ_upper/nσ
    Truncated(Normal(μ, σ_estim), trunc_lower, trunc_upper)
end

function assigndist_normal(μ, σ; nσ = 1, trunc_lower = -Inf, trunc_upper = Inf,
        tolerance = 1e-7)

    σ_estim = σ/nσ
    Truncated(Normal(μ, σ_estim), trunc_lower, trunc_upper)
end

export assigndist_normal
