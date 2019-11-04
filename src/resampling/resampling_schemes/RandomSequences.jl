"""
    RandomSequences(n::Int, sequence_length)

Indicates that resampling should be performed on discrete, 
continuous subsets of a dataset. The lengths of each of the 
`n` subsets is indicated by `sequence_length`, which should 
be an integer (fixed sequence length) or an iterable of 
integers (sequences may have different lengths).
"""
struct RandomSequences <: AbstractUncertainDataResampling
    n::Int
    sequence_length
end

export RandomSequences