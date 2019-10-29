using Reexport 

@reexport module InterpolationAndGrids
    using Interpolations
    
    include("findall_nan_chunks.jl")
    include("grids/RectangularGrid.jl")
    include("methods/interpolation.jl")
end