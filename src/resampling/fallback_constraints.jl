import ..UncertainValues.AbstractUncertainValue

"""
Fallback constraints. This is necessary when sampling constraints are not compatible. For example,
the `TruncatedStd` constraint is not implemented for `UncertainScalarKDE`, so we need a fallback.

The default is to fall back to `NoConstraint()``.
"""
function fallback(s::SamplingConstraint, v::AbstractUncertainValue)
    NoConstraint()
end

function fallback(uv::UncertainScalarKDE, constraint::TruncateStd)
    @warn "TruncateStd constraint is incompatible with UncertainScalarKDE. Falling back to TruncateQuantiles(0.25, 0.75)."
    TruncateQuantiles(0.25, 0.75)
end
