""" 
    OrderedSamplingAlgorithm

An abstract type for ordered sampling algorithms.
""" 
abstract type OrderedSamplingAlgorithm end 

"""
    OrderedSamplingStartToEnd

An ordered sampling algorithm indicating that values should be 
treated consecutively from start to finish of the dataset.
"""
struct StartToEnd <: OrderedSamplingAlgorithm end 

"""
    OrderedSamplingEndToStart

An ordered sampling algorithm indicating that the values should be 
treated consecutively from the end to the start of the dataset.
"""
struct EndToStart <: OrderedSamplingAlgorithm end

"""
    OrderedSamplingMidpointOutwards

An ordered sampling algorithm indicating that the values should be 
divided into two groups, separating the values at some midpoint 
of the dataset. The two groups of values are then treated separately.
"""
struct MidpointOutwards <: OrderedSamplingAlgorithm
    midpoint_idx::Int
end

"""
    OrderedSamplingChuncksForwards

An ordered sampling algorithm indicating that the values should be 
divided into multiple (`n_chunks`) groups. The groups of values 
are then treated separately, treating values from the start to the end of 
each group.
"""
struct ChunksForwards <: OrderedSamplingAlgorithm
    n_chunks::Int
end

"""
    OrderedSamplingChuncksForwards

An ordered sampling algorithm indicating that the values should be 
divided into multiple (`n_chunks`) groups. The groups of values 
are then treated separately, treating values from the end to the start of 
each group.
"""
struct ChunksBackwards <: OrderedSamplingAlgorithm
    n_chunks::Int
end

export 
OrderedSamplingAlgorithm, 
StartToEnd,
EndToStart,
MidpointOutwards,
ChunksForwards,
ChunksBackwards