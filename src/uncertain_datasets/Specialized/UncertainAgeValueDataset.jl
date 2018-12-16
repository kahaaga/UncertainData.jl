

struct UncertainAgeValueDataset <: UncertainIndexValueDataset
    indices::Vector{AbstractUncertainValue}
    values::Vector{AbstractUncertainValue}
end

export UncertainAgeValueDataset
