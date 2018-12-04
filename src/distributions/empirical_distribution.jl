using Distributions

abstract type AbstractEmpiricalDistribution end


struct EmpiricalDistribution{S <: ValueSupport} <: AbstractEmpiricalDistribution
    distribution::Distribution{Univariate, S} # S may be continuous or discrete
    values
end

"""
Fit a distribution of type `d` to `values`.
"""
function EmpiricalDistribution(values, d)
    if !(d <: Distribution)
        throw(DomainError("$d is not a valid distribution"))
    end

    EmpiricalDistribution(fit_mle(d, values), values)
end

macro empiricaldist(values, d)
    :(EmpiricalDistribution($values, $d))
end


export
AbstractEmpiricalDistribution,
EmpiricalDistribution,
empiricaldist, @empiricaldist
