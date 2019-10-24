
"""
    AbstractBinnedResampling <: AbstractUncertainDataResampling

Resampling schemes where data are binned and the data in each bin 
are represented as an uncertain value.
"""
abstract type AbstractBinnedResampling <: AbstractUncertainDataResampling end

"""
    AbstractBinnedSummarisedResampling <: AbstractUncertainDataResampling

Resampling schemes where data are binned and the data in each bin 
are summarised to a single value (e.g. the mean).
"""
abstract type AbstractBinnedSummarisedResampling <: AbstractUncertainDataResampling end

export 
AbstractBinnedResampling,
AbstractBinnedSummarisedResampling