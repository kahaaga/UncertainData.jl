import ..UncertainValues: CertainValue

Base.truncate(v::CertainValue) = v
Base.truncate(v::CertainValue, s::SamplingConstraint) = v

constrain(v::CertainValue) = v
constrain(v::CertainValue, s::SamplingConstraint) = v


export constrain