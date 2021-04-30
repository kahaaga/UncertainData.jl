
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
struct TruncateQuantiles{T1<:Real, T2<:Real} <: ValueSamplingConstraint
    lower_quantile::T1
    upper_quantile::T2

    function TruncateQuantiles(lower_quantile::T1, upper_quantile::T2) where {T1, T2}
        err_msg = "Need 0 <= lower_quantile < upper_quantile <= 1"
        
        if !(lower_quantile < upper_quantile && 0.0 <= lower_quantile < upper_quantile <= 1.0)
            throw(DomainError(err_msg * " (got lo = $lower_quantile, hi = $upper_quantile)"))
        else
            new{T1, T2}(lower_quantile, upper_quantile)
        end
    end
end

"""
    TruncateStd(nσ::Number)

A constraint indicating that the distribution furnishing an uncertain value
should be truncated at the mean ± `nσ` (`n` standard deviations).

## Notes 

- Beware when you apply the `TruncateStd` constraint to a (usually a numeric)
    population with a small value range. With `nσ` small, you might end up with 
    a population mean *between* the actual values, so that the range 
    `[mean(pop) - nσ*std(pop), mean(pop) + nσ*std(pop)]` returns `nothing`.
"""
struct TruncateStd{T<:Number} <: ValueSamplingConstraint
    nσ::T
    
    function TruncateStd(nσ::T) where T
        
        if nσ <= 0
            err_str = "TruncateStd must be initialised with nσ strictly positive"
            throw(DomainError(err_str *  " (got nσ = $nσ)"))
        else
            new{T}(nσ)
        end
    end
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
struct TruncateRange{T1, T2} <: ValueSamplingConstraint
    min::T1
    max::T2
    
    function TruncateRange(min::T1, max::T2) where {T1, T2}
        if min <= max # <= ties are allowed, because we may encounter CertainScalar instances
            return new{T1, T2}(min, max)
        else
            err_msg = "Cannot create TruncateRange instance. Need min < max"
            throw(DomainError(err_msg * " (got min = $min, max = $max)"))
        end
    end
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

abstract type SequentialSamplingConstraint{OA} end

# Add the ordered sampling scheme to the seqential sampling constraints,
# because that's all they affect. Defaults to `StartToEnd`.
#(::Type{SSC})(args...; kwargs...) where SSC<:SequentialSamplingConstraint = SSC(StartToEnd(), args...; kwargs...)


""" 
    StrictlyIncreasing(algorithm::OrderedSamplingAlgorithm; 
        n::Int = 50000, lq = 0.05, uq = 0.95)

Sampling scheme indicating element-wise sampling such that the resulting values 
are strictly increasing in magnitude. 

Increasing sequential sampling is only guaranteed when distributions have finite support.
Therefore, distributions are element-wise truncated to the lower and upper quantiles 
`lq` and `uq`. For each distribution, this is done by drawing `n` values from it, then 
finding the quantiles for that sample, and finally truncating the distribution to the empirical
quantile range.

`algorithm` is an instance of some `OrderedSamplingAlgorithm` (e.g. `StartToEnd`).
`n` is the number of samples to draw when computing quantiles. 

Typically used when there are known, physical constraints on the measurements.
For example, geochemical measurements of sediments at different depths of a sediment core 
are taken at physically separate depths in the core. Thus, the order of the indices cannot
be flipped, and must be strictly decreasing/increasing.

See also: [`StartToEnd`](@ref)
"""
struct StrictlyIncreasing{OA <: OrderedSamplingAlgorithm} <: SequentialSamplingConstraint{OA}
    ordered_sampling_algorithm::OA
    n::Int # number of samples to draw from samples
    lq::Float64 # lower quantile
    uq::Float64 # upper quantile
    
    function StrictlyIncreasing(algorithm::OA = StartToEnd(); n::Int = 10000, lq = 0.05, uq = 0.95) where OA
        if lq >= uq
            throw(ArgumentError("Need lq < uq. Got lq=$(lq) > uq=$(uq)."))
        end
        new{OA}(algorithm, n, lq, uq)
    end
end

""" 
    StrictlyIncreasing(algorithm::OrderedSamplingAlgorithm; n::Int = 50000)

Sampling scheme indicating element-wise sampling such that the resulting values 
are strictly decreasing in magnitude. 

Decreasing sequential sampling is only guaranteed when distributions have finite support.
Therefore, distributions are element-wise truncated to the lower and upper quantiles 
`lq` and `uq`. For each distribution, this is done by drawing `n` values from it, then 
finding the quantiles for that sample, and finally truncating the distribution to the empirical
quantile range.

`algorithm` is an instance of some `OrderedSamplingAlgorithm` (e.g. `StartToEnd`).
`n` is the number of samples to draw when computing quantiles. 

Typically used when there are known, physical constraints on the measurements.
For example, geochemical measurements of sediments at different depths of a sediment core 
are taken at physically separate depths in the core. Thus, the order of the indices cannot
be flipped, and must be strictly decreasing/increasing.

See also: [`StartToEnd`](@ref)
"""
struct StrictlyDecreasing{OA <: OrderedSamplingAlgorithm} <: SequentialSamplingConstraint{OA}
    ordered_sampling_algorithm::OA
    n::Int # number of samples to draw from samples
    lq::Float64 # lower quantile
    uq::Float64 # upper quantile
    
    function StrictlyDecreasing(algorithm::OA = StartToEnd(); n::Int = 10000, lq = 0.05, uq = 0.95) where OA
        if lq >= uq
            throw(ArgumentError("Need lq < uq. Got lq=$(lq) > uq=$(uq)."))
        end
        new{OA}(algorithm, n, lq, uq)
    end
end



export 
IndexSamplingConstraint,
SequentialSamplingConstraint,
StrictlyIncreasing,
StrictlyDecreasing
