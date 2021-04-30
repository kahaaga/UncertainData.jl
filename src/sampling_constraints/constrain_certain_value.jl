import ..UncertainValues: CertainScalar


constrain(v::CertainScalar) = v
constrain(v::CertainScalar, s::SamplingConstraint) = v
constrain(v::CertainScalar, s::TruncateLowerQuantile) = v
constrain(v::CertainScalar, s::TruncateUpperQuantile) = v
constrain(v::CertainScalar, s::TruncateQuantiles) = v
constrain(v::CertainScalar, s::TruncateStd) = v


export constrain