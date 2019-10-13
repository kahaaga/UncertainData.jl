import ..UncertainDatasets: AbstractUncertainIndexValueDataset

function resample(x::AbstractUncertainIndexValueDataset, 
        resampling::SequentialResampling{S}) where {S}
    resample(x, resampling.sequential_constraint)
end

function resample(x::AbstractUncertainIndexValueDataset, 
        resampling::SequentialInterpolatedResampling{S, G}) where {S, G}
    resample(x, resampling.sequential_constraint, resampling.grid)
end
