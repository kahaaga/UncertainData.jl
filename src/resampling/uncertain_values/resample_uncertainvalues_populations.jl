import ..UncertainValues:
    AbstractScalarPopulation

import Base.rand
import StatsBase.sample
    
function resample(p::AbstractScalarPopulation)
    rand(p)
end
    
function resample(p::AbstractScalarPopulation, n::Int)
    rand(p, n)
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
            rand(constrain(p, constraint))
        end
        
        function resample(p::AbstractScalarPopulation, constraint::$(constraint), n::Int)
            rand(constrain(p, constraint), n)
        end
    end
    eval(funcs)
end