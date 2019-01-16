import ..UncertainValues: CertainValue
using RecipesBase

@recipe f(::Type{CertainValue{T}}, x::CertainValue{T}) where {T} = [x.value]

@recipe function f(certainvals::Vector{CertainValue})
    @series begin 
        [val.value for val in certainvals]
    end
end


@recipe function f(certainvals::Vararg{CertainValue,N}) where {N}
    @series begin 
        [val.value for val in certainvals]
    end
end
