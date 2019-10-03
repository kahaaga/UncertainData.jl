import ..UncertainValues: CertainValue


constrain(v::CertainValue) = v
constrain(v::CertainValue, s::SamplingConstraint) = v
constrain(v::CertainValue, s::TruncateLowerQuantile) = v
constrain(v::CertainValue, s::TruncateUpperQuantile) = v
constrain(v::CertainValue, s::TruncateQuantiles) = v
constrain(v::CertainValue, s::TruncateStd) = v


export constrain