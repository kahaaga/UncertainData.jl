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

function resample(p::AbstractScalarPopulation, constraint::SamplingConstraint) 
    rand(constrain(p, constraint))
end
        
function resample(p::AbstractScalarPopulation, constraint::SamplingConstraint, n::Int)
    rand(constrain(p, constraint), n)
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
        function resample(p::AbstractScalarPopulation{T, PW}, constraint::$(constraint)) where {T, PW}
            rand(constrain(p, constraint))
        end
        
        function resample(p::AbstractScalarPopulation{T, PW}, constraint::$(constraint), n::Int) where {T, PW}
            rand(constrain(p, constraint), n)
        end
    end
    eval(funcs)
end
