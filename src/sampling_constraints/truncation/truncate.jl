import ..UncertainValues.TheoreticalDistributionScalarValue

import ..UncertainValues.AbstractUncertainOneParameterScalarValue
import ..UncertainValues.AbstractUncertainTwoParameterScalarValue
import ..UncertainValues.AbstractUncertainThreeParameterScalarValue

import ..UncertainValues.ConstrainedUncertainScalarValueOneParameter
import ..UncertainValues.ConstrainedUncertainScalarValueTwoParameter
import ..UncertainValues.ConstrainedUncertainScalarValueThreeParameter
import ..UncertainValues.TruncatedUncertainScalarKDE
import ..UncertainValues.AbstractUncertainScalarKDE

import ..UncertainValues.TheoreticalFittedUncertainScalar
import ..UncertainValues.ConstrainedUncertainScalarTheoreticalFit
import ..UncertainValues.FittedDistribution

import ..UncertainValues.getquantileindex

import Distributions.ValueSupport
import Distributions.Univariate
import Distributions.Distribution
import Distributions.support
import Distributions.Truncated
import Distributions: mean, std

import KernelDensity.UnivariateKDE

import StatsBase: quantile, Weights, mean, std

import Base.truncate

include("stats_on_truncated_distributions.jl")

include("truncate_kde.jl")
include("truncate_theoreticalscalar.jl")
include("truncate_theoretical_fitted.jl")
