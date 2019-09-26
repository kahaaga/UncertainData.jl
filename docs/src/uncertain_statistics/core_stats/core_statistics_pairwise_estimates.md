# [Pairwise estimates of statistics](@id point_estimate_statistics)

These estimators operate on pairs of uncertain values. They compute the 
statistic in question by drawing independent length-`n` draws of the 
uncertain values, then computing the statistic on those draws.

## Statistics by resampling

```@docs
cov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; corrected::Bool = true)
cor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
countne(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
counteq(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
corkendall(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
corspearman(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
maxad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
meanad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
msd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
psnr(x::AbstractUncertainValue, y::AbstractUncertainValue, maxv, n::Int)
rmsd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; normalize = false)
sqL2dist(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
crosscor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true)
crosscov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true)
gkldiv(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
kldivergence(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)
```
