"""
    AbstractBinnedResampling

Resampling schemes where data are binned.
"""
abstract type AbstractBinnedResampling <: AbstractUncertainDataResampling end
    
"""
    AbstractBinnedUncertainValueResampling <: AbstractUncertainDataResampling

Resampling schemes where data are binned and the data in each bin 
are represented as an uncertain value.
"""
abstract type AbstractBinnedUncertainValueResampling <: AbstractBinnedResampling end

"""
    AbstractBinnedSummarisedResampling <: AbstractUncertainDataResampling

Resampling schemes where data are binned and the data in each bin 
are summarised to a single value (e.g. the mean).
"""
abstract type AbstractBinnedSummarisedResampling <: AbstractBinnedResampling end

export 
AbstractBinnedResampling,
AbstractBinnedSummarisedResampling,
AbstractBinnedUncertainValueResampling