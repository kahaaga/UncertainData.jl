struct UncertainVectorValue{T1<:Number, T2<:Number, T3<:Number,
        S<:ValueSupport} <: AbstractUncertainValue
    distribution::Distribution{Multivariate, S}
    value::AbstractVector{T1}
    lower::AbstractVector{T2}
    upper::AbstractVector{T3}
end

dimension(usv::UncertainVectorValue) = length(distribution)

export UncertainVectorValue
