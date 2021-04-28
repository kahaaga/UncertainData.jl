import ..UncertainValues: CertainScalar
using RecipesBase

@recipe f(::Type{CertainScalar{T}}, x::CertainScalar{T}) where {T} = [x.value]

@recipe function f(certainvals::Vector{CertainScalar})
    @series begin 
        [val.value for val in certainvals]
    end
end


@recipe function f(certainvals::Vararg{CertainScalar,N}) where {N}
    @series begin 
        [val.value for val in certainvals]
    end
end
