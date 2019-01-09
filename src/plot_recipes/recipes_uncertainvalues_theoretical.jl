import ..UncertainValues.TheoreticalDistributionScalarValue
import ..UncertainValues.UncertainScalarBinomialDistributed
import ..UncertainValues.UncertainScalarBetaBinomialDistributed
import ..UncertainValues: AbstractUncertainValue

import Distributions.pdf

import ..SamplingConstraints: 
    SamplingConstraint,
	constrain
	

function get_density(uv::AbstractUncertainValue)
	some_sample = resample(uv, 10000)
	xmin = minimum(some_sample) * 0.97
	xmax = maximum(some_sample) * 1.03
	step = (xmax-xmin)/300
	xvals = xmin:step:xmax+step
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


@recipe function plot_theoretical(uv::TheoreticalDistributionScalarValue, 
	constraint::SamplingConstraint, density = true, n_samples = 1000)
	cuv = constrain(uv, constraint)

	if density
		@series begin
			get_density(cuv)
		end
	else
		@series begin
			label --> ""
			resample(cuv, n_samples)
		end
	end
end
