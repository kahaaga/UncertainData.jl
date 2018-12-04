"""
    assigndist_uniform(μ, lower, upper)

Assign parameters to a uniform distribution
with `lower` and `upper` uncertainty
bounds. 
"""
function assigndist_uniform(lower, upper)
    Uniform(lower, upper)
end

export assigndist_uniform
