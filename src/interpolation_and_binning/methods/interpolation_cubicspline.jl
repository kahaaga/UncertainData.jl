import Interpolations: 
        CubicSplineInterpolation,
        Line, OnGrid, Throw

"""
Cubic spline interpolation of `x` and `y` on a regular grid `inpt_grid_x`. Returns the 
interpolated `y` values.
"""
function cubicspline_interpolation(x::AbstractRange, y, inpt_grid_x; 
        bc = Line(OnGrid()), 
        extrapolation_bc = NaN, 
        sort = true)

    # Knots must be sorted in ascending order.
    if sort 
        sort_inds = sortperm(x)
        # Interpolation object
        itp = CubicSplineInterpolation(x[sort_inds], y[sort_inds], 
                bc = bc,
                extrapolation_bc = extrapolation_bc)
    else 
        itp = CubicSplineInterpolation(x, y,
                bc = bc,
                extrapolation_bc = extrapolation_bc)
    end
        
    # Evaluate the interpolation object at the x-axis grid we provide. These will 
    # be our interpolated y-axis values
    itp(inpt_grid_x)
end

export cubicspline_interpolation