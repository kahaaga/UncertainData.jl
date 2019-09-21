promote_rule(::Type{UncertainDataset}, ::Type{UncertainValueDataset}) = UncertainValueDataset
promote_rule(::Type{UncertainValueDataset}, ::Type{UncertainDataset}) = UncertainValueDataset

promote_rule(::Type{UncertainDataset}, ::Type{UncertainIndexDataset}) = UncertainValueDataset
promote_rule(::Type{UncertainIndexDataset}, ::Type{UncertainDataset}) = UncertainValueDataset

promote_rule(::Type{UncertainValueDataset}, ::Type{UncertainIndexDataset}) = UncertainValueDataset
promote_rule(::Type{UncertainIndexDataset}, ::Type{UncertainValueDataset}) = UncertainValueDataset


convert(::Type{UncertainValueDataset}, udata::T) where {T <: AbstractUncertainValueDataset} = 
    UncertainValueDataset(udata.values)
convert(::Type{UncertainValueDataset}, udata::UncertainIndexDataset) = 
    UncertainValueDataset(udata.indices)

convert(::Type{UncertainIndexDataset}, udata::T) where {T <: AbstractUncertainValueDataset} = 
    UncertainIndexDataset(udata.values)
convert(::Type{UncertainIndexDataset}, udata::UncertainIndexDataset) = 
    UncertainIndexDataset(udata.indices)


convert(::Type{UncertainDataset}, udata::T) where {T <: AbstractUncertainValueDataset} = 
    UncertainDataset(udata.values)
convert(::Type{UncertainDataset}, udata::UncertainIndexDataset) = 
    UncertainDataset(udata.indices)

# Converting vectors of any input to uncertain datasets 
function convert(::Type{UncertainValueDataset}, uvec::AbstractVector)
    uvals = [UncertainValue(x) for x in uvec]
    UncertainValueDataset(uvals)
end

function convert(::Type{UncertainValueDataset}, 
        uvec::AbstractVector{T}) where {T<:AbstractUncertainValue}
    UncertainValueDataset(uvec)
end

UncertainValueDataset(udata::UncertainDataset) = convert(UncertainValueDataset, udata)
UncertainValueDataset(udata::UncertainIndexDataset) = convert(UncertainValueDataset, udata)
UncertainValueDataset(udata::UncertainValueDataset) = udata

UncertainIndexDataset(udata::UncertainDataset) = convert(UncertainIndexDataset, udata)
UncertainIndexDataset(udata::UncertainIndexDataset) = udata
UncertainIndexDataset(udata::UncertainValueDataset) = convert(UncertainIndexDataset, udata)

UncertainDataset(udata::UncertainDataset) = udata
UncertainDataset(udata::UncertainIndexDataset) = convert(UncertainDataset, udata)
UncertainDataset(udata::UncertainValueDataset) = convert(UncertainDataset, udata)

