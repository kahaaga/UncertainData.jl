import Interpolations: 
        LinearInterpolation,
        Line

"""
Linearly interpolates two vectors `x` and `y` on a linear grid consisting of `nsteps`.
"""
function linear_interpolation(x, y, inpt_grid_x; 
        extrapolation_bc = NaN, 
        sort = true)
    # Knots must be sorted in ascending order.
    if sort 
        sort_inds = sortperm(x)
        # Interpolation object
        itp = LinearInterpolation(x[sort_inds], y[sort_inds], 
                extrapolation_bc = extrapolation_bc)
    else 
        itp = LinearInterpolation(x, y,
        extrapolation_bc = extrapolation_bc)
    end
        
    # Evaluate the interpolation object at the x-axis grid we provide. These will 
    # be our interpolated y-axis values
    itp(inpt_grid_x)
end

export linear_interpolation