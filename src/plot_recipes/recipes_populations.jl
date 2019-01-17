import ..UncertainValues: UncertainScalarPopulation

using RecipesBase


#@recipe f(::Type{UncertainScalarPopulation{T}}, x::UncertainScalarPopulation{T}) where {T} =
#    rand(x, 10000)


@recipe function f(p::UncertainScalarPopulation{T}) where T
    @series begin 
        rand(p, 10000)
    end
end

@recipe function f(populations::Vector{UncertainScalarPopulation{T}}) where {T}
    
    for p in populations
        @series begin 
            p
        end
    end
end