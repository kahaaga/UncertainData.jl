struct UncertainScalarValue{T1<:Number, T2<:Number, T3<:Number,
        S<:ValueSupport} <: AbstractUncertainValue
    distribution::Distribution{Univariate, S}
    value::T1
    lower::T2
    upper::T3
end

dimension(usv::UncertainScalarValue) = 1

export UncertainScalarValue
