
import Measurements: Measurement
import ..UncertainValues: UncertainValue
import Distributions: Normal

resample(m::Measurement{T}) where T = resample(UncertainValue(Normal, m.val, m.err))

function resample(m::Measurement{T}, n::Int) where T
    uval = UncertainValue(Normal, m.val, m.err)

    [resample(uval) for i = 1:n]
end