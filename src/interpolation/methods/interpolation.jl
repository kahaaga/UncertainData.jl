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

export create_interp_scheme