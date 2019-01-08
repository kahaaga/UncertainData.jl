
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
end

"""
    TruncateStd(nσ::Int)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated at `nσ` (`n` standard deviations).
"""
struct TruncateStd <: ValueSamplingConstraint
    nσ::Int
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



#########################################################################
# Sampling constraints for sample indices (time index, age, depth, etc...)
# Often, these need to be sampled to obey some physical criteria (i.e.,
# observations are from physical samples lying above each other, so the order
# of the observations cannot be mixed).
#########################################################################

abstract type IndexSamplingConstraint <: SamplingConstraint end

struct StrictlyIncreasing <: IndexSamplingConstraint end

struct StrictlyDecreasing <: IndexSamplingConstraint end

struct StrictlyIncreasingWherePossible <: IndexSamplingConstraint end

struct StrictlyDecreasingWherePossible<: IndexSamplingConstraint end


struct ConstrainedUncertainValueDataset <: AbstractUncertainValueDataset
    values::UncertainDataset
    constraints::Vector{SamplingConstraint}
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
TruncateStd,

IndexSamplingConstraint,
StrictlyIncreasing,
StrictlyDecreasing