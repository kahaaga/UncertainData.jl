import ..UncertainValues.AbstractUncertainScalarKDE

"""
    resample(uv::UncertainScalarKDE)

Resample an uncertain value whose distribution is approximated using a
kernel density estimate once.
"""
resample(uv::AbstractUncertainScalarKDE) = rand(uv)

"""
    resample(uv::AbstractUncertainScalarKDE)

Resample an uncertain value whose distribution is approximated using a
kernel density estimate `n` times.
"""
resample(uv::AbstractUncertainScalarKDE, n::Int) = rand(uv, n)
