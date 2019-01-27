include("AbstractInterpolationGrid.jl")

import Interpolations: 
    BoundaryCondition,
    Flat

import ..UncertainDatasets:
    AbstractUncertainValueDataset,
    UncertainIndexValueDataset

import ..SamplingConstraints:
    TruncateQuantiles,
    constrain

##############################################################################
# Rectangular grid composite types
##############################################################################
""" 
    RegularGrid

## Fields 
- **min**: The minimum value of the grid.
- **max**: The maximum value of the grid. 
- **step**: The interval size. 
- **extrapolation_bc**: The extrapolation condition. Can also be NaN.
""" 
struct RegularGrid{BC <: BoundaryCondition} <: InterpolationGrid
    min::Number
    max::Number
    step::Number
    extrapolation_bc::Union{BC, Float64}
end

##############################################################################
# Rectangular grid constructors for different types of uncertain datasets
##############################################################################

function RegularGrid(x::AbstractUncertainValueDataset, n_steps::Int;
    extrapolation_bc = Flat(), round_digits::Int = 7,
    trunc_finite::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain to some large quantile to avoid taking the minima and 
    # maximuma of distributions with infinite supports 
    constrained_indices = constrain(x, TruncateQuantiles(0.0001, 0.9999))

    min_x = floor(minimum(constrained_indices), digits = round_digits)
    max_x = ceil(maximum(constrained_indices), digits = round_digits)

    RegularGrid(min_x, max_x, (max_x - min_x)/n_steps, extrapolation_bc)
end

function RegularGrid(x::UncertainIndexValueDataset, n_steps::Int;
    extrapolation_bc = Flat(), round_digits::Int = 7,
    trunc_finite::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain to some large quantile to avoid taking the minima and 
    # maximuma of distributions with infinite supports 
    constrained_indices = constrain(x.indices, TruncateQuantiles(0.0001, 0.9999))

    min_x = floor(minimum(constrained_indices), digits = round_digits)
    max_x = ceil(maximum(constrained_indices), digits = round_digits)

    RegularGrid(min_x, max_x, (max_x - min_x)/n_steps, extrapolation_bc)
end

function RegularGrid(x::AbstractUncertainValueDataset, step::Float64;
    extrapolation_bc = Flat(),
    round_digits = 7,
    trunc_finite::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain to some large quantile to avoid taking the minima and 
    # maximuma of distributions with infinite supports 
    constrained_data = constrain(x, trunc_finite)

    min_x = floor(minimum(constrained_data), digits = round_digits)
    max_x = ceil(maximum(constrained_data), digits = round_digits)

    RegularGrid(min_x, max_x, step, extrapolation_bc)
end

function RegularGrid(x::UncertainIndexValueDataset, step::Float64;
    extrapolation_bc = Flat(), round_digits::Int = 7,
    trunc_finite::TruncateQuantiles = TruncateQuantiles(0.001, 0.999))

    # Constrain to some large quantile to avoid taking the minima and 
    # maximuma of distributions with infinite supports 
    constrained_indices = constrain(x.indices, TruncateQuantiles(0.0001, 0.9999))

    min_x = floor(minimum(constrained_indices), digits = round_digits)
    max_x = ceil(maximum(constrained_indices), digits = round_digits)

    RegularGrid(min_x, max_x, step, extrapolation_bc)
end

RegularGrid(xmin, xmax, step; extrapolation_bc = Flat()) = 
    RegularGrid(xmin, xmax, step, extrapolation_bc)

function RegularGrid(xvals::AbstractRange, extrapolation_bc = Flat())
    RegularGrid(minimum(xvals), maximum(xvals), step(xvals), extrapolation_bc)
end

function RegularGrid(xvals::Vector{T}, extrapolation_bc = Flat()) where {T}
    RegularGrid(minimum(xvals), maximum(xvals), xvals[2] - xvals[1], extrapolation_bc)
end

export RegularGrid


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

Base.range(g::IrregularGrid) = g.gridvals
