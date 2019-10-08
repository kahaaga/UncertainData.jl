"""
    UncertainIndexValueDataset{
        IDXTYP<:AbstractUncertainIndexDataset, 
        VALSTYP<:AbstractUncertainValueDataset}

A generic dataset type consisting of a set of uncertain `indices` (e.g. time,
depth, order, etc...) and a set of uncertain `values`. 

The i-th index is assumed to correspond to the i-th value. For example, if 
`data` is an instance of a `UncertainIndexValueDataset`, then 

- `data.indices[2]` is the index for the value `data.values[2]`
- `data.values[7]` is the value for the index `data.indices[7]`.
- `data[3]` is an index-value tuple `(data.indices[3], data.values[3])`.

## Fields

- **`indices::T where {T <: AbstractUncertainIndexDataset}`**: The uncertain indices,
    represented by some type of uncertain index dataset.
- **`values::T  where {T <: AbstractUncertainValueDataset}`**: The uncertain values,
    represented by some type of uncertain index dataset.

## Example

```julia
# Simulate some data values measured a specific times.
times = 1:100
values = sin.(0.0:0.1:100.0)

# Assume the data were measured by a device with normally distributed
# measurement uncertainties with fluctuating standard deviations
σ_range = (0.1, 0.7)

uncertain_values = [UncertainValue(Normal, val, rand(Uniform(σ_range...))) 
    for val in values]

# Assume the clock used to record the times is uncertain, but with uniformly 
# distributed noise that doesn't change through time.
uncertain_times = [UncertainValue(Uniform, t-0.1, t+0.1) for t in times]

# Pair the time-value data. If vectors are provided to the constructor,
# the first will be interpreted as the indices and the second as the values.
data = UncertainIndexValueDataset(uncertain_times, uncertain_values)

# A safer option is to first convert to UncertainIndexDataset and 
# UncertainValueDataset, so you don't accidentally mix the indices 
# and the values.
uidxs = UncertainIndexDataset(uncertain_times)
uvals = UncertainValueDataset(uncertain_values)

data = UncertainIndexValueDataset(uidxs, uvals)
```
"""
struct UncertainIndexValueDataset{IDXTYP <: AbstractUncertainIndexDataset, VALSTYP <: AbstractUncertainValueDataset} <: AbstractUncertainIndexValueDataset

    """ The indices of the uncertain index-value dataset. """
    indices::IDXTYP

    """ The values of the uncertain index-value dataset. """
    values::VALSTYP

    function UncertainIndexValueDataset(
        indices::UncertainIndexDataset, 
        values::UncertainValueDataset)
    
        IDXTYP = UncertainIndexDataset
        VALSTYP = UncertainValueDataset
        
        new{IDXTYP, VALSTYP}(
            UncertainIndexDataset(indices),
            UncertainValueDataset(values)
        )
    end

    function UncertainIndexValueDataset(
        indices::ConstrainedUncertainIndexDataset, 
        values::UncertainValueDataset)
    
        IDXTYP = ConstrainedUncertainIndexDataset
        VALSTYP = UncertainValueDataset
        
        new{IDXTYP, VALSTYP}(indices, values)
    end

    function UncertainIndexValueDataset(
        indices::UncertainIndexDataset, 
        values::ConstrainedUncertainValueDataset)
    
        IDXTYP = UncertainIndexDataset
        VALSTYP = ConstrainedUncertainValueDataset
        
        new{IDXTYP, VALSTYP}(indices, values)
    end

    function UncertainIndexValueDataset(
        indices::ConstrainedUncertainIndexDataset, 
        values::ConstrainedUncertainValueDataset)
    
        IDXTYP = ConstrainedUncertainIndexDataset
        VALSTYP = ConstrainedUncertainValueDataset
        
        new{IDXTYP, VALSTYP}(indices, values)
    end

    function UncertainIndexValueDataset(
            indices::Vector{<:AbstractUncertainValue}, 
            values::Vector{<:AbstractUncertainValue})
        
        IDXTYP = UncertainIndexDataset
        VALSTYP = UncertainValueDataset
        
        new{IDXTYP, VALSTYP}(
            UncertainIndexDataset(indices),
            UncertainValueDataset(values)
        )
    end

    function UncertainIndexValueDataset(
            indices::DT, 
            values::Vector{<:AbstractUncertainValue}) where {DT <: AbstractUncertainIndexDataset}
        
        IDXTYP = DT
        VALSTYP = UncertainValueDataset
        
        new{IDXTYP, VALSTYP}(indices, UncertainValueDataset(values))
    end

    function UncertainIndexValueDataset(
            indices::Vector{<:AbstractUncertainValue},
            values::DT) where {DT <: AbstractUncertainValueDataset}
        
        IDXTYP = UncertainIndexDataset
        VALSTYP = DT
        
        new{IDXTYP, VALSTYP}(UncertainIndexDataset(indices), values)
    end
end

Base.length(u::UncertainIndexValueDataset) = length(u.values)
Base.size(u::UncertainIndexValueDataset) = length(u.values)

Base.getindex(u::UncertainIndexValueDataset, i) = (u.indices[i], u.values[i])
Base.getindex(u::UncertainIndexValueDataset, i::AbstractVector) =
    [(u.indices[i], u.values[i]) for i in 1:length(u)]

Base.getindex(u::UncertainIndexValueDataset, i::Colon) =
        [(u.indices[i], u.values[i]) for i in 1:length(u)]

Base.firstindex(u::UncertainIndexValueDataset) = 1
Base.lastindex(u::UncertainIndexValueDataset) = length(u.values)

Base.eachindex(u::UncertainIndexValueDataset) = Base.OneTo(length(u))
Base.iterate(u::UncertainIndexValueDataset, state = 1) = iterate((u.indices, u.values), state)


index(u::UncertainIndexValueDataset, i) = u.indices[i]
value(u::UncertainIndexValueDataset, i) = u.values[i]



export
UncertainIndexValueDataset,
index, value
