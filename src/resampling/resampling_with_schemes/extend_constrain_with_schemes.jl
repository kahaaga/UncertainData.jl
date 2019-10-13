import ..SamplingConstraints: constrain 
import ..UncertainDatasets: 
    UncertainIndexValueDataset,
    UncertainIndexDataset,
    ConstrainedUncertainIndexDataset,
    ConstrainedUncertainValueDataset,
    AbstractUncertainValueDataset,
    AbstractUncertainIndexValueDataset

function constrain(x::UncertainIndexDataset, 
        resampling::ConstrainedValueResampling{1})

    ConstrainedUncertainIndexDataset(constrain(x.indices, resampling.constraints[1]))
end


function constrain(x::AbstractUncertainIndexValueDataset, 
        resampling_inds::ConstrainedValueResampling{N1},
        resampling_vals::ConstrainedValueResampling{N2}) where {N1, N2}

    inds = constrain(x.indices, resampling_inds)
    vals = constrain(x.values, resampling_vals)

    UncertainIndexValueDataset(inds, vals)
end

function constrain(x::AbstractUncertainIndexValueDataset, resampling::ConstrainedIndexValueResampling{2, 1})

    inds = constrain(x.indices, resampling[1, 1])
    vals = constrain(x.values, resampling[1, 2])

    UncertainIndexValueDataset(inds, vals)
end

function constrain(x::AbstractUncertainIndexValueDataset, 
        constraints_inds::CONSTRAINT_TYPES,
        constraints_vals::CONSTRAINT_TYPES)

    inds = constrain(x.indices, constraints_inds)
    vals = constrain(x.values, constraints_vals)

    UncertainIndexValueDataset(inds, vals)
end

export constrain