
abstract type InterpolationGrid end

Base.minimum(g::InterpolationGrid) = g.min
Base.maximum(g::InterpolationGrid) = g.max
Base.min(g::InterpolationGrid) = g.min
Base.max(g::InterpolationGrid) = g.max
Base.range(g::InterpolationGrid) = g.min:g.step:g.max
Base.step(g::InterpolationGrid) = g.step

export InterpolationGrid

