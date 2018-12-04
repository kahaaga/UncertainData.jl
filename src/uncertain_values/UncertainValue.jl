include("UncertainEmpiricalScalarValue.jl")
include("UncertainScalarValue.jl")

"""
    UncertainValue(value, lower, upper, distribution; kwargs...)

Construct an uncertain observation. This converts the scalar values for the
observation and its uncertainties into a probability distribution of choice.

## Arguments
- **`μ`**: The value.
- **`lower`**: The lower uncertainty bound.
- **`upper`**: The upper uncertainty bound.
- **`distribution`**: A valid univariate distribution from `Distributions.jl`.

## Keyword arguments
- **`nσ`**: If `distribution <: Distributions.Normal`, then how many standard
    deviations away from `μ` does `lower` and `upper` (i.e. both, because
    they are the same distance away from `μ`) represent?
- **`tolerance`**: A threshold determining how symmetric the uncertainties
    must be in order to allow the construction of  Normal distribution
    (`upper - lower > threshold` is required).
- **`trunc_lower`**: Lower truncation bound for distributions with infinite
    support. Defaults to `-Inf`.
- **`trunc_upper`**: Upper truncation bound for distributions with infinite
    support. Defaults to `Inf`.
"""
function UncertainValue(value::T1, lower::T2, upper::T3, distribution;
            kwargs...) where {T1 <: Number, T2 <: Number, T3 <: Number}
    new_d = assign_dist(value, lower, upper, distribution; kwargs...)
    UncertainScalarValue(new_d, value, lower, upper)
end

"""
    UncertainValue(empiricaldata::AbstractVector{T}, dist) where {T <: Number}

Construct a probabilitistic representation of an uncertain value from
a vector of empirical data describing its distribution.

## Arguments
- **`empiricaldata`**: A vector of data for which to fit a distribution
    of type `dist`.
- **`dist`**: A valid univariate distribution from `Distributions.jl`.

"""
function UncertainValue(empiricaldata::AbstractVector{T}, dist) where {T<:Number}
    UncertainEmpiricalValue(empiricaldata, dist)
end

function UncertainValue(lower::T1, upper::T2, dist) where {T1<:Number, T2 <: Number}
    if dist == Uniform
        UncertainScalarValue(assign_dist(lower, upper, dist),
                            (lower+upper)/2, lower, upper)
    else
        throw(DomainError("$dist cannot be constructed using only lower and upper bounds. Uniform, for example, may be a better choice."))
    end
end


##############################
# Macro constructors
##############################
# macro uncertainvalue(μ, lower, upper, d,
#         nσ = 2, trunc_lower = -Inf, trunc_upper = Inf, tolerance = 1e-3)
#     return :(UncertainValue($μ, $lower, $upper, $d,
#                 nσ = $nσ,
#                 trunc_lower = $trunc_lower,
#                 trunc_upper = $trunc_upper,
#                 tolerance = $tolerance))
# end
#
#macro uncertainvalue(empiricaldata, dist)
#    return :(UncertainValue($empiricaldata, $dist))
#end

"""
A macro for the construction of uncertain values. Calls
    [`UncertainValue`](@ref) with the provided arguments.

- **`@uncertainvalue(μ, lower, upper, dist, kwargs...)`**:
    Fit a distribution of type `dist` to `μ` and `lower`/`upper` uncertainty
    bounds.
- **`@uncertainvalue(empiricaldata, dist)`**:
    Fit a distribution of type `dist` to a vector of empirical data.
"""
#:(@uncertainvalue)


export
UncertainValue
#uncertainvalue,
#@uncertainvalue
