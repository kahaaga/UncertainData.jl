import ..UncertainValues:
    AbstractScalarPopulation

resample(p::AbstractScalarPopulation) = rand(p)
resample(p::AbstractScalarPopulation, n::Int) = rand(p, n)

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
        function resample(p::AbstractScalarPopulation, constraint::$(constraint))
            resample(constrain(p, constraint))
        end
        
        function resample(p::AbstractScalarPopulation, constraint::$(constraint), n::Int)
            resample(constrain(p, constraint), n)
        end
    end
    eval(funcs)
end