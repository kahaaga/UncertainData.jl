
import ..UncertainDatasets.AbstractUncertainValueDataset
import ..UncertainDatasets.UncertainDataset
import ..UncertainValues.UncertainScalarKDE


abstract type SamplingConstraint end

"""
    NoConstraint

A (non)constraint indicating that the distribution furnishing an uncertain value
should be sampled its entire support.
"""
struct NoConstraint <: SamplingConstraint end


#########################################################################
# Sampling constraints for regular data (i.e. not age/depth/time index...,
# but the values associated to those indices).
#########################################################################

abstract type ValueSamplingConstraint <: SamplingConstraint end


"""
    TruncateLowerQuantile(lower_quantile::Float64)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated below at some quantile.
"""
struct TruncateLowerQuantile <: ValueSamplingConstraint
    lower_quantile::Float64
end

"""
    TruncateUpperQuantile(upper_quantile::Float64)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated above at some quantile.
"""
struct TruncateUpperQuantile <: ValueSamplingConstraint
    upper_quantile::Float64
end

"""
    TruncateQuantiles(lower_quantile::Float64, upper_quantile::Float64)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated at some quantile quantile
`(lower_quantile, upper_quantile)`.
"""
struct TruncateQuantiles <: ValueSamplingConstraint
    lower_quantile::Float64
    upper_quantile::Float64

    function TruncateQuantiles(lower_quantile, upper_quantile)
        if lower_quantile > upper_quantile
            error("lower quantile > upper quantile ($lower_quantile > $upper_quantile)")
        else
            new(lower_quantile, upper_quantile)
        end
    end
end

"""
    TruncateStd(nσ::Int)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated at `nσ` (`n` standard deviations).
"""
struct TruncateStd{T<:Number} <: ValueSamplingConstraint
    nσ::T
end

"""
    TruncateMinimum(min::Number)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated below at some specified minimum value.
"""
struct TruncateMinimum{T<:Number} <: ValueSamplingConstraint
    min::T
end

"""
    TruncateMaximum(max::Number)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated above at some specified maximum value.
"""
struct TruncateMaximum{T<:Number} <: ValueSamplingConstraint
    max::T
end

"""
    TruncateRange(min::Number, max::Number)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated at some range `[min, max]`.
"""
struct TruncateRange{T} <: ValueSamplingConstraint
    min::T
    max::T
end



export
SamplingConstraint,
NoConstraint,

ValueSamplingConstraint,
TruncateLowerQuantile,
TruncateUpperQuantile,
TruncateQuantiles,
TruncateMinimum,
TruncateMaximum,
TruncateRange,
TruncateStd


#########################################################################
# Sampling constraints for sample indices (time index, age, depth, etc...)
# Often, these need to be sampled to obey some physical criteria (i.e.,
# observations are from physical samples lying above each other, so the order
# of the observations cannot be mixed).
#########################################################################
include("ordered_sequences/ordered_sequence_algorithms.jl")

""" 
    IndexSamplingConstraint

An abstract type for sampling constraints valid only for indices.
""" 
abstract type IndexSamplingConstraint <: SamplingConstraint end


#########################################################################
# Sequential sampling constraints
#########################################################################

abstract type SequentialSamplingConstraint end

# Add the ordered sampling scheme to the seqential sampling constraints,
# because that's all they affect. Defaults to `StartToEnd`.
(::Type{SSC})() where SSC<:SequentialSamplingConstraint = SSC(StartToEnd())


""" 
    StrictlyIncreasing

A sampling constraint indicating element-wise sampling of the uncertain values in a dataset,
such that the values of the draw are strictly increasing in magnitude.

Typically used when there are known, physical constraints on the measurements.
For example, geochemical measurements of sediments at different depths of a sediment core 
are taken at physically separate depths in the core. Thus, the order of the indices cannot
be flipped, and must be strictly decreasing/increasing. 
""" 
struct StrictlyIncreasing{OA<:OrderedSamplingAlgorithm} <: SequentialSamplingConstraint
    ordered_sampling_algorithm::OA
end

""" 
    StrictlyDecreasing

A sampling constraint indicating element-wise sampling of the uncertain values in a dataset,
such that the values of the draw are strictly decreasing in magnitude.
    
Typically used when there are known, physical constraints on the measurements.
For example, geochemical measurements of sediments at different depths of a sediment core 
are taken at physically separate depths in the core. Thus, the order of the indices cannot
be flipped, and must be strictly decreasing/increasing. 
""" 
struct StrictlyDecreasing{OA<:OrderedSamplingAlgorithm} <: SequentialSamplingConstraint 
    ordered_sampling_algorithm::OA
end



export 
IndexSamplingConstraint,
SequentialSamplingConstraint,
StrictlyIncreasing,
StrictlyDecreasing
