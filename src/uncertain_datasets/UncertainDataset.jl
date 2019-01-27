"""
    UncertainDataset

Generic dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct UncertainDataset <: AbstractUncertainValueDataset
    values::AbstractVector{AbstractUncertainValue}
end

"""
    ConstrainedUncertainDataset

Generic constrained dataset containing uncertain values.

## Fields
- **`values::AbstractVector{AbstractUncertainValue}`**: The uncertain values.
"""
struct ConstrainedUncertainDataset <: AbstractUncertainValueDataset
    values::AbstractVector{AbstractUncertainValue}
end


UncertainDataset(uv::AbstractUncertainValue) = UncertainDataset([uv])
ConstrainedUncertainDataset(uv::AbstractUncertainValue) = ConstrainedUncertainDataset([uv])



##########################
# Sorting
#########################

export
UncertainDataset,
ConstrainedUncertainDataset