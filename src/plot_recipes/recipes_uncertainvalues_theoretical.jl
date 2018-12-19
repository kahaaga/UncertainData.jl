import ..UncertainValues.TheoreticalDistributionScalarValue
import ..UncertainValues.UncertainScalarBinomialDistributed
import ..UncertainValues.UncertainScalarBetaBinomialDistributed

import Distributions.pdf

function get_density(uv::TheoreticalDistributionScalarValue)
	some_sample = resample(uv, 10000)
	xmin = minimum(some_sample) * 0.95
	xmax = maximum(some_sample) * 1.05

	xvals = xmin:0.01:xmax
	density = pdf.(uv.distribution, xvals)

	xvals, density ./ sum(density)
end

function get_density(uv::UncertainScalarBinomialDistributed)
	some_sample = resample(uv, 10000)
	xmin = minimum(some_sample)
	xmax = maximum(some_sample)

	xvals = xmin:1:xmax
	density = pdf.(uv.distribution, xvals)

	xvals, density ./ sum(density)
end

function get_density(uv::UncertainScalarBetaBinomialDistributed)
	some_sample = resample(uv, 10000)
	xmin = minimum(some_sample)
	xmax = maximum(some_sample)

	xvals = xmin:1:xmax
	density = pdf.(uv.distribution, xvals)

	xvals, density ./ sum(density)
end


@recipe function plot_theoretical(uv::TheoreticalDistributionScalarValue,
		density = true, n_samples = 1000)

	if density
		@series begin
			get_density(uv)
		end
	else
		@series begin
			label --> ""
			resample(uv, n_samples)
		end
	end
end
#
#
#
# @recipe function plot_theoretical_fitted(uv::UncertainScalarTheoreticalFit,
# 		density = true, n_samples = 1000)
# 	if density
# 		@series begin
# 			@show "here"
#
# 			get_density(uv)
# 		end
# 	else
# 		@series begin
# 			label --> ""
# 			resample(uv, n_samples)
# 		end
# 	end
# end
