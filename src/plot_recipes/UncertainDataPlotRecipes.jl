using Reexport

@reexport module UncertainDataPlotRecipes
    import ..Resampling.resample
    using RecipesBase

    # Recipes for uncertain values
    include("recipes_certainvalues.jl")
    include("recipes_populations.jl")
    include("recipes_uncertainvalues_theoretical.jl")
    include("recipes_uncertainvalues_kde.jl")
    include("recipes_uncertaindatasets.jl")

    # Uncertainties for values with uncertainties both in index and value
    include("recipes_uncertain_index_and_value.jl")
    include("recipes_uncertainindexvaluedataset.jl")
    include("recipes_vectors_of_uncertainvalues.jl")

    # Recipes for resampled statistics
    #include("recipes_resampledstatistics.jl")
    
end # module

"""
    UncertainDataPlotRecipes

Plot recipes for uncertain values and uncertain datasets.
"""
UncertainDataPlotRecipes