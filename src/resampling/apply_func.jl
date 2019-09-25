""" 
    resample(f::Function, n::Int, x::AbstractUncertainValue, args...; kwargs...)

Draw an `n`-element sample from `x` according to its furnishing distribution, then 
call `f` on the length-`n` sample with the given `args` and `kwargs`.
"""
function resample(f::Function, x::AbstractUncertainValue, n::Int, args...; kwargs...)
    draw = resample(x, n)
    f(draw, args...; kwargs...)
end

export resample