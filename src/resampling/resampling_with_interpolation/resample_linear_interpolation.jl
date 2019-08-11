import ..InterpolationAndGrids:
    linear_interpolation,
    InterpolationGrid

import ..UncertainDatasets:
    UncertainIndexValueDataset,
    AbstractUncertainValueDataset

import ..SamplingConstraints:
    TruncateQuantiles

""" 
    resample(udata::UncertainIndexValueDataset, 
        grid::InterpolationGrid;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

Draw a realization of `udata`, then interpolate the data values to `grid`. 

To avoid very large spans of interpolation, the uncertain indices are truncated to some 
large quantile range. Values are not truncated. 
"""
function resample(udata::UncertainIndexValueDataset, 
        grid::InterpolationGrid;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain data so that all furnishing distributions for the indices have finite 
    # supports.
    constrained_udata = UncertainIndexValueDataset(
        constrain(udata.indices, trunc),
        udata.values
        )
    
    # Resample the dataset 
    inds, vals = resample(constrained_udata)
    
    # Interpolate to the provided grid
    intp = linear_interpolation(inds, vals, extrapolation_bc = grid.extrapolation_bc)

    # Return grid indices and the interpolated points.
    range(grid), intp(grid.min:grid.step:grid.max)
end

"""
    resample(udata::UncertainIndexValueDataset, 
        sequential_constraint::SequentialSamplingConstraint,
        grid::InterpolationGrid;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

Draw a realization of `udata`, enforcing a `sequential_constraint` on the indices. Then,
interpolate the values of the realization to the provided grid of indices (`grid`). 

To avoid very large spans of interpolation, the uncertain indices are truncated to some 
large quantile range. Values are not truncated.  
"""
function resample(udata::UncertainIndexValueDataset, 
        sequential_constraint::SequentialSamplingConstraint,
        grid::InterpolationGrid;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain data so that all furnishing distributions for the indices have finite 
    # supports.
    constrained_udata = UncertainIndexValueDataset(
        constrain(udata.indices, trunc),
        udata.values
        )

    # Resample the dataset with the sequential constraint.
    inds, vals = resample(constrained_udata, sequential_constraint)

    # Interpolate to the desired grid.
    intp = linear_interpolation(inds, vals, extrapolation_bc = grid.extrapolation_bc)

    # Return grid indices and the interpolated points.
    range(grid), intp(grid.min:grid.step:grid.max)

end




function resample(udata::UncertainIndexValueDataset, 
        sequential_constraint::SequentialSamplingConstraint,
        grid::InterpolationGrid, 
        n::Int;
        trunc::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain data so that all furnishing distributions for the indices have finite 
    # supports.
    constrained_udata = UncertainIndexValueDataset(
        constrain(udata.indices, trunc),
        udata.values
        )


    # Interpolate
    grid = range(grid)
    resampled_vals = zeros(Float64, length(grid), n)

    for i = 1:n
        # Resample using the sequential constraint, then interpolate 
        # the realization to the provided grid.
        inds, vals = resample(constrained_udata, sequential_constraint)
        
        intp = linear_interpolation(inds, vals,
            extrapolation_bc = grid.extrapolation_bc)

        # Each interpolated realization is a column in `resampled_vals`
        resampled_vals[:, i] = intp(grid.min:grid.step:grid.max)
    end

    # Return grid indices and the interpolated points. The interpolated 
    # points now live in a matrix where each column is a realization.
    grid, resampled_vals
end

export resample