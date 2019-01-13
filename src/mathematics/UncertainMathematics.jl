using Reexport 

@reexport module UncertainMathematics 
    include("uncertainvalues/elementary_operations_uncertainvalues.jl")
    include("uncertainvalues/trig_functions_uncertainvalues.jl")

    include("uncertaindataset/elementary_operations_uncertaindatasets.jl")
    include("uncertainvaluedataset/elementary_operations_uncertainvaluedatasets.jl")
    include("uncertainindexdataset/elementary_operations_uncertainindexdatasets.jl")


end # module 