import ..UncertainValues:
    AbstractScalarPopulation


import Base.rand
import StatsBase.sample
    
function resample(p::AbstractScalarPopulation)
    sample([float.(resample(v)) for v in p.values], p.probs)
end
    
function resample(p::AbstractScalarPopulation, n::Int)
    [sample([float.(resample(v)) for v in p.values], p.probs) for i = 1:n]
end

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