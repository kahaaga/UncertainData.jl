include("AbstractUncertainDataset.jl")
include("AbstractUncertainValueDataset.jl")


"""
    UncertainDataset

Generic dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainDataset{T <: AbstractUncertainValue} <: AbstractUncertainValueDataset
    values::AbstractVector{T}
end

"""
    ConstrainedUncertainDataset

Generic constrained dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct ConstrainedUncertainDataset{T <: AbstractUncertainValue} <: AbstractUncertainValueDataset
    values::AbstractVector{T}
end


UncertainDataset(uv::AbstractUncertainValue) = UncertainDataset([uv])
ConstrainedUncertainDataset(uv::AbstractUncertainValue) = ConstrainedUncertainDataset([uv])



##########################
# Sorting
#########################

export
UncertainDataset,
ConstrainedUncertainDataset