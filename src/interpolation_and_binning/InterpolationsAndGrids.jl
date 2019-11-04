using Reexport 

@reexport module InterpolationAndGrids
    using Interpolations
    
    include("findall_nan_chunks.jl")
    include("fill_nans.jl")

    include("grids/RectangularGrid.jl")
    include("methods/interpolation.jl")
    include("interpolate_and_bin.jl")
    include("binning.jl")
end