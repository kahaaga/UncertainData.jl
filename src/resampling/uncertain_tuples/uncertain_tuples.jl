function resample(uvals::NTuple{N, Union{Real, AbstractUncertainValue}}) where N 
    Tuple(convert(AbstractFloat, resample(uval)) for uval in uvals)
end

function resample(uvals::NTuple{N, Union{Real, AbstractUncertainValue}}, n::Int) where N
    [resample(uvals) for i = 1:n]
end

function resample_elwise(uvals::NTuple{N, Union{Real, AbstractUncertainValue}}) where N
    [resample(uval) for uval in uvals]
end

function resample_elwise(uvals::NTuple{N, Union{Real, AbstractUncertainValue}}, n::Int) where N
    [[resample(uval) for i = 1:n] for uval in uvals]
end