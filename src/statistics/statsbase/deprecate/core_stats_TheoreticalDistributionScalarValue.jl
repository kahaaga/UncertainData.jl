
##########################################################################################
# Uncertain values represented by theoretical distributions.
# Base stats can be estimated directly from the distributions, so no need for resampling.
# These methods definitions are just for compatibility with other uncertain values, which 
# may not have analytically determined statistics associated with them.
##########################################################################################
StatsBase.mode(uv::TheoreticalDistributionScalarValue, n::Int) = mode(uv)
Statistics.mean(uv::TheoreticalDistributionScalarValue, n::Int) = mean(uv)
Statistics.median(uv::TheoreticalDistributionScalarValue, n::Int) = median(uv)
Statistics.middle(uv::TheoreticalDistributionScalarValue, n::Int) = middle(uv)
Statistics.quantile(uv::TheoreticalDistributionScalarValue, q, n::Int) = quantile(uv, q)
Statistics.std(uv::TheoreticalDistributionScalarValue, n::Int) = std(uv)
Statistics.var(uv::TheoreticalDistributionScalarValue, n::Int) = var(uv)


StatsBase.mode(uv::UncertainScalarTheoreticalFit, n::Int) = mode(uv)
Statistics.mean(uv::UncertainScalarTheoreticalFit, n::Int) = mean(uv)
Statistics.median(uv::UncertainScalarTheoreticalFit, n::Int) = median(uv)
Statistics.middle(uv::UncertainScalarTheoreticalFit, n::Int) = middle(uv)
Statistics.quantile(uv::UncertainScalarTheoreticalFit, q, n::Int) = quantile(uv, q)
Statistics.std(uv::UncertainScalarTheoreticalFit, n::Int) = std(uv)
Statistics.var(uv::UncertainScalarTheoreticalFit, n::Int) = var(uv)
