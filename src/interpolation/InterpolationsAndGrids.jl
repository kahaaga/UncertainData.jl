using Reexport 

@reexport module InterpolationAndGrids
    using Interpolations
    
    include("grids/RectangularGrid.jl")
    include("methods/interpolation.jl")
end