using Distributions

include("assigndist_normal.jl")
include("assigndist_uniform.jl")

"""
    assign_dist(μ, lower, upper, distribution::T; nσ = 1,
        trunc_lower = -Inf, trunc_upper = Inf,
        tolerance = 1e-2) where {T <: Distribution} -> Distribution

Construct a `distribution` based on the location parameter `μ` and
the `lower` and `upper` uncertainty bounds.


#### Currently allowed distributions:
- **`Normal`**. A normal distribution with location `μ` and scale
    `σ = (upper - μ)/nσ = (μ - lower)/nσ`. Truncated at `trunc_lower` and
    `trunc_upper`.
- **`Uniform`**. A uniform distribution on `[lower, upper]`.

## Arguments
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.
- **`μ`**: The value.
- **`lower`**: The lower uncertainty bound.
- **`upper`**: The upper uncertainty bound.

## Keyword arguments
- **`nσ`**: If `distribution <: Distributions.Normal`, then how many standard deviations
    away from `μ` does `lower` and `upper` (i.e. both, because they are the same distance
    away from `μ`) represent?
- **`tolerance`**: A threshold determining how symmetric the uncertainties must be in order
    to allow the construction of  Normal distribution (`upper - lower > threshold` is
    required).
- **`trunc_lower`**: Lower truncation bound. Defaults to `-Inf`.
- **`trunc_upper`**: Upper truncation bound. Defaults to `Inf`.
"""
function assign_dist end
@generated function assign_dist(μ, lower, upper, distribution; kwargs...)
    if distribution == Type{Normal}
        :(assigndist_normal(μ, lower, upper; kwargs...))
    elseif distribution == Type{Uniform}
        :(assigndist_uniform(lower, upper))
    else
        :(throw(DomainError($distribution, "$distribution is not a valid Distribution. Currently implemented distributions are Normal and Uniform.")))
    end
end

function assign_dist(lower, upper, distribution)
    if distribution == Uniform
        assigndist_uniform(lower, upper)
    end
end


export
assign_dist,
assigndist_normal
