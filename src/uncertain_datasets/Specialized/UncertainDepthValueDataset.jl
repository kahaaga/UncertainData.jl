

struct UncertainDepthValueDataset <: UncertainIndexValueDataset
    indices::Vector{AbstractUncertainValue}
    values::Vector{AbstractUncertainValue}
end

export UncertainDepthValueDataset
