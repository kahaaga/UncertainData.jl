import ..SamplingConstraints: SamplingConstraint
import ..UncertainValues: CertainScalar

resample(x::Number) = x

resample(v::CertainScalar) = v.value 
resample(v::CertainScalar, n::Int) = [v.value for i = 1:n]

resample(v::CertainScalar, s::SamplingConstraint) = v.value 
resample(v::CertainScalar, s::SamplingConstraint, n::Int) = [v.value for i = 1:n]

constraints = [
    :(NoConstraint), 
    :(TruncateLowerQuantile), 
    :(TruncateUpperQuantile),
    :(TruncateQuantiles),
    :(TruncateMaximum),
    :(TruncateMinimum),
    :(TruncateRange),
    :(TruncateStd)
]

for constraint in constraints
    funcs = quote 
        resample(x::CertainScalar, constraint::$(constraint)) = x.value
        resample(x::CertainScalar, constraint::$(constraint), n::Int) = [x.value for i = 1:n]
    end
    eval(funcs)
end