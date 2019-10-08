""" 
    resample(f::Function, x::AbstractUncertainValue, n::Int, args...; kwargs...)

Draw an `n`-element sample from `x` according to its furnishing distribution, then 
call `f(x_draw, args...; kwargs...)` on the length-`n` draws.
"""
function resample(f::Function, x::T, n::Int, args...; kwargs...) where T <: AbstractUncertainValue
    
    draw = resample(x, n)

    f(draw, args...; kwargs...)
end

""" 
    resample(f::Function, 
        x::AbstractUncertainValue, y::AbstractUncertainValue,
        n::Int, args...; kwargs...)

Draw an `n`-element sample from `x` according to its furnishing distribution, and 
draw an `n`-element sample from `y` according to its furnishing distribution. Then,
call `f(x_draw, y_draw, args...; kwargs...)` on the length-`n` draws.
"""
function resample(f::Function, 
        x::T1, y::T2, 
        n::Int, args...; kwargs...) where {T1 <: AbstractUncertainValue, T2 <: AbstractUncertainValue}

    draw_x = float.(resample(x, n))
    draw_y = float.(resample(y, n))

    f(draw_x, draw_y, args...; kwargs...)
end

""" 
    resample(f::Function, x::UVAL_COLLECTION_TYPES, n::Int, args...; kwargs...)

Resample the elements of `x` according to their furnishing uncertain values, yielding
a length-`l` realisation of `x` if `length(x) = l`. The elements of `x` are resampled 
independently, assuming no sequential dependence between the elements. Then, call 
`f(x, args...; kwargs...)` on the length-`l` sample with the given `args` and `kwargs`. 
This process is repeated `n` times, yielding a length-`n` distribution of evaluations 
of `f`.
"""
function resample(f::Function, x::T, n::Int, args...; kwargs...) where {
        T <: UVAL_COLLECTION_TYPES}

    draws = resample(x, n)
    [f(draw, args...; kwargs...) for draw in draws]
end

""" 
    resample(f::Function, x::UVAL_COLLECTION_TYPES, y::UVAL_COLLECTION_TYPES, n::Int, args...; kwargs...)

Resample the elements of `x` according to their furnishing uncertain values, yielding
a length-`l` realisation of `x` if `length(x) = l`. Then, do the same for `y`.
The elements of `x` and `y` are resampled independently, assuming no sequential dependence 
between the elements of neither `x` nor `y`. 

Then, call `f(x_draw, y_draw, args..., kwargs...)` on the length-`l` samples 
`x_draw` and `y_draw`. This process is repeated `n` times, yielding a length-`n` 
distribution of evaluations of `f`.
"""
function resample(f::Function, x::TX, y::TY, n::Int, args...; kwargs...) where {
        TX <: UVAL_COLLECTION_TYPES, 
        TY <: UVAL_COLLECTION_TYPES}

    f_vals = zeros(Float64, n)
    
    for i = 1:n
        draw_x = float.(resample(x))
        draw_y = float.(resample(y))
        f_vals[i] = f(draw_x, draw_y, args...; kwargs...)
    end
    
    return f_vals
end

export resample