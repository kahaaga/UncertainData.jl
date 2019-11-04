
import Interpolations.AbstractExtrapolation

abstract type AbstractInterpolationScheme end 

struct InterpolationScheme1D <: AbstractInterpolationScheme
    xgrid::InterpolationGrid
    interpolation_method::AbstractInterpolation
end


export AbstractInterpolationScheme,
    InterpolationScheme1D,
    InterpolationGrid
