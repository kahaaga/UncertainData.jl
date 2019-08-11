using RecipesBase
import ..Resampling: ResampledDatasetStatistic

@recipe function f(::Type{ResampledDatasetStatistic{T,B}}, 
        x::ResampledDatasetStatistic{T,B}) where {T, B}
    x.estimates
end