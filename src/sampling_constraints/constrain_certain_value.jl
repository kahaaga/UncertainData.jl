import ..UncertainValues: CertainValue

truncate(v::CertainValue) = v
truncate(v::CertainValue, s::SamplingConstraint) = v

constrain(v::CertainValue) = v
constrain(v::CertainValue, s::SamplingConstraint) = v


export constrain