using Reexport 

@reexport module InterpolationAndGrids
    using Interpolations
    include("grids/RectangularGrid.jl")
    include("interpolation_methods/interpolation_linear.jl")
    include("interpolation_methods/interpolation_cubicspline.jl")

end