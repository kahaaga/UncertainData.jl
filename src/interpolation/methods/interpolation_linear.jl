import Interpolations: 
        LinearInterpolation,
        Line

"""
    linear_interpolation(x, y; extrapolation_bc = NaN, sort = true)

Create a linear interpolation object from two vectors `x` and `y` (to be interpolated).
"""
function linear_interpolation(x, y; extrapolation_bc = NaN, sort = true)
    # Knots must be sorted in ascending order.
    if sort 
        sort_inds = sortperm(x)
        itp = LinearInterpolation(x[sort_inds], y[sort_inds], extrapolation_bc = extrapolation_bc)
    else 
        itp = LinearInterpolation(x, y, extrapolation_bc = extrapolation_bc)
    end
        
    # Don't evaluate the interpolation object on an x-axis grid we provide, but return 
    # the interpolation object that can be interpolated at a set of x values later 
    # (i.e. itp(inpt_grid_x))
    return itp
end

export linear_interpolation