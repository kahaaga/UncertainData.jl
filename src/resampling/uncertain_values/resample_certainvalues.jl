import ..SamplingConstraints: SamplingConstraint
import ..UncertainValues: CertainValue

resample(v::CertainValue) = v.value 
resample(v::CertainValue, n::Int) = [v.value for i = 1:n]

resample(v::CertainValue, s::SamplingConstraint) = v.value 
resample(v::CertainValue, s::SamplingConstraint, n::Int) = [v.value for i = 1:n]

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
        resample(x::CertainValue, constraint::$(constraint)) = x.value
        resample(x::CertainValue, constraint::$(constraint), n::Int) = [x.value for i = 1:n]
    end
    eval(funcs)
end