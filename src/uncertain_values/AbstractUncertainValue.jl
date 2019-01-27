using Distributions
using StaticArrays
import Printf.@sprintf
import Distributions.RealInterval

abstract type AbstractUncertainValue end

Broadcast.broadcastable(d::AbstractUncertainValue) = Ref(d)

##############################
# Support of an observation
##############################
import Distributions.support

"""
    support(o::AbstractUncertainValue) -> IntervalArithmetic.Interval

Find the support of the uncertain observation.
"""
function support(o::AbstractUncertainValue)
    supp = support(o.distribution)
    lowerbound = supp.lb
    upperbound = supp.ub
    @interval(lowerbound, upperbound)
end

export support

##############################
# Intersection of the supports
##############################
"""
    support_overlap(o1::AbstractUncertainValue, o2::AbstractUncertainValue)

Compute the overlap in the supports of two uncertain observations.
"""
function support_overlap(uval1::AbstractUncertainValue, uval2::AbstractUncertainValue)
    s1 = support(uval1)
    s2 = support(uval2)
    
    if s1 isa RealInterval 
        s1 = interval(s1...)
    end
    
    if s2 isa RealInterval
        s2 = interval(s2...)
    end
    s1 ∩ s2
end

export support_overlap


##################################################################
# Intersection of two UncertainValues as a mixture model
##################################################################
import Base.intersect, Base.∩

"""
    intersect(o1::AbstractUncertainValue, o2::AbstractUncertainValue)

Compute the intersection between two uncertain observations probabilistically.
The intersection is represented as a mixture model of the distributions
furnishing the observations.
"""
function intersect(o1::AbstractUncertainValue, o2::AbstractUncertainValue)
    # Create a mixture model representing the intersection
    if support_overlap(o1, o2) == ∅
        throw(DomainError((o1, o2), "intersect(o1, o2) == ∅. Cannot compute mixture model."))
    end

    MixtureModel([o1.distribution, o2.distribution])
end

export intersect


###################
# Pretty printing
###################

function summarise(o::AbstractUncertainValue)
    dist = o.distribution
    _type = typeof(o)
    "$_type"
end
Base.show(io::IO, q::AbstractUncertainValue) = print(io, summarise(q))



dimension(usv::AbstractUncertainValue) = 1


Base.max(uv::AbstractUncertainValue) = maximum(uv.distribution)
Base.min(uv::AbstractUncertainValue) = minimum(uv.distribution)
Base.minimum(uv::AbstractUncertainValue) = minimum(uv.distribution)
Base.maximum(uv::AbstractUncertainValue) = maximum(uv.distribution)

Base.maximum(uvs::AbstractVector{AbstractUncertainValue}) = 
    maximum([maximum(uv) for uv in uvs])
Base.minimum(uvs::AbstractVector{AbstractUncertainValue}) = 
    minimum([minimum(uv) for uv in uvs])

export
AbstractUncertainValue,
dimension
