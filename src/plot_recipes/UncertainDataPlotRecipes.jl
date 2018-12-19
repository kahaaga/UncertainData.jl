using Reexport

@reexport module UncertainDataPlotRecipes
    import ..Resampling.resample
    using RecipesBase

    include("recipes_uncertainvalues_theoretical.jl")
    include("recipes_uncertainvalues_kde.jl")
end # module
