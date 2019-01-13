# mean, median, std etc.. functions don't work on Distribution.Truncated instances,
# so we'll define them using a resampling approach 

import Distributions.Truncated 
import StatsBase:
    mean,
    median,
    middle,
    std,
    mode,
    quantile

mean(d::Truncated; n::Int = 10000) = mean(rand(d, n))
median(d::Truncated; n::Int = 10000) = median(rand(d, n))
middle(d::Truncated; n::Int = 10000) = median(rand(d, n))
std(d::Truncated; n::Int = 10000) = std(rand(d, n))
mode(d::Truncated; n::Int = 10000) = mode(rand(d, n))
quantile(d::Truncated, q; n::Int = 10000) = quantile(rand(d, n), q)