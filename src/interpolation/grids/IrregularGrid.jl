
""" 
    IrregularGrid

## Fields 
- **gridvals**: The values of the grid.
- **extrapolation_bc**: The extrapolation condition.
""" 
struct IrregularGrid{BC <: BoundaryCondition} <: InterpolationGrid
    gridvals::Vector{Float64}
    extrapolation_bc::Union{BC, Float64}
end

Base.minimum(g::IrregularGrid) = minimum(g.gridvals)
Base.maximum(g::IrregularGrid) = maximum(g.gridvals)
Base.min(g::IrregularGrid) = minimum(g.gridvals)
Base.max(g::IrregularGrid) = maximum(g.gridvals)

Base.range(g::IrregularGrid) = 
    throw(MethodError("step is not defined for irregular grids"))

Base.step(g::IrregularGrid) = 
    throw(MethodError("step is not defined for irregular grids"))


