import ..UncertainValues.AbstractUncertainValue
import ..UncertainValues.AbstractUncertainScalarKDE

"""
Fallback constraints. This is necessary when sampling constraints are not compatible. For example,
the `TruncatedStd` constraint is not implemented for `UncertainScalarKDE`, so we need a fallback.

The default is to fall back to `NoConstraint()``.
"""
function fallback(s::SamplingConstraint, v::AbstractUncertainValue)
    NoConstraint()
end

"""
    fallback(uv::UncertainScalarKDE, constraint::TruncateStd)

Fallback constraint for a `TruncateStd` constraint applied to an
`UncertainScalarKDE` instance.
"""
function fallback(uv::AbstractUncertainScalarKDE, constraint::TruncateStd)
    @warn "TruncateStd constraint is incompatible with UncertainScalarKDE. Falling back to TruncateQuantiles(0.33, 0.67)."
    TruncateQuantiles(0.33, 0.67)
end

export fallback
