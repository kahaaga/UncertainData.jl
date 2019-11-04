include("interpolation_cubicspline.jl")
include("interpolation_linear.jl")
include("../grids/schemes.jl")

"""
    Interpolation(x, y, gridargs...; method::Symbol = :linear, kwargs...)

Create an interpolation scheme from a set of `x` values and `y` values (to be interpolated). 
`method` sets the interpolation type, and `extrapolation_bc` sets the extrapolation 
boundary condition (either a valid `BoundaryCondition` or `NaN`).
"""
function create_interp_scheme(x, y, grid::InterpolationGrid; method::Symbol = :linear, 
        extrapolation_bc::Union{BoundaryCondition, Float64} = Flat())    
    if method == :linear 
        intp = InterpolationScheme1D(grid, linear_interpolation(x, y; 
            extrapolation_bc = extrapolation_bc))
    end

    return intp
end

"""
    interpolate_nans(grid, x, intp::Linear, extr::BoundaryCondition)

Interpolate `x` (which potentially has `NaN` values) linearly over the 
provided `grid`.

If there are `NaN`s at the edges of `x`, then the `extrapolation_bc` 
boundary condition is applied (see `Interpolations.BoundaryCondition`
documentation for more details). The boundary condition defaults to `NaN`,
which leaves the `NaN` values at the edges of `x` non-interpolated.
Other boundary conditions, like `Flat(gt)` or `Line(gt)`, with 
`gt = OnCell()` or `gt = OnGrid()` will also work.
"""
function interpolate_nans(grid, x, intp::Linear, 
        extrapolation_bc::Union{Interpolations.BoundaryCondition, Real} = NaN)
    idxs_nonnans = findall(.!(isnan.(x)))
    
    ext = LinearInterpolation(grid[idxs_nonnans], x[idxs_nonnans], extrapolation_bc = extrapolation_bc)
    ext(grid)
end

export create_interp_scheme, interpolate_nans