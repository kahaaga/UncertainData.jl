using Reexport 

@reexport module InterpolationAndGrids
    using Interpolations
    
    include("grids/RectangularGrid.jl")
    include("grids/schemes.jl")
    include("methods/interpolation.jl")
end