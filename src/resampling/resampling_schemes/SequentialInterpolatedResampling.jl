import ..SamplingConstraints: 
    SequentialSamplingConstraint

import ..InterpolationAndGrids:
    InterpolationGrid

"""
    SequentialInterpolatedResampling{SequentialSamplingConstraint, InterpolationGrid}

Indicates that resampling should be done by first resampling sequentially, then 
interpolating the sample to an interpolation grid.

## Fields 

- `sequential_constraint::SequentialSamplingConstraint`. The sequential sampling constraint,
    for example `StrictlyIncreasing()`.
- `grid::InterpolationGrid`. The grid onto which the resampled draw (generated according to
    the sequential constraint) is interpolated, for example `RegularGrid(0, 100, 2.5)`.

## Examples 

For example, `SequentialInterpolatedResampling(StrictlyIncreasing(), RegularGrid(0:2:100))`
indicates a sequential draw that is then interpolated to the grid 0:2:100.

"""
struct SequentialInterpolatedResampling{S, G} <: AbstractUncertainDataResampling where {
    S <: SequentialSamplingConstraint, G <: InterpolationGrid}
    sequential_constraint::S
    grid::G
end

function Base.show(io::IO, resampling::SequentialInterpolatedResampling{S, G}) where {S, G}
    print(io, "SequentialInterpolatedResampling{$S, $(resampling.grid)}")
end

export SequentialInterpolatedResampling