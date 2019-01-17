
function resample(uvals::Vector{AbstractUncertainValue}) 
    [resample(uvals[i]) for i = 1:n]
end

function resample(uvals::Vector{AbstractUncertainValue}, n::Int) 
    [resample(uvals[i], n) for i = 1:n]
end