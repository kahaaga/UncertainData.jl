import ..UncertainValues.CertainValue

Base.truncate(v::CertainValue) = v
function Base.truncate(v::CertainValue, constraint::TruncateMaximum)
    if v.value > constraint.max
        msg = "Truncating $v with $constraint failed\n"
        msg2 = "Need value < constraint.max, got $v < $(constraint.max)"
        throw(ArgumentError(msg * msg2))
    else 
        return v
    end
end

function Base.truncate(v::CertainValue, constraint::TruncateMinimum)
    if v.value < constraint.min
        msg = "Truncating $v with $constraint failed\n"
        msg2 = "Need value > constraint.min, got $v > $(constraint.min)"
        throw(ArgumentError(msg * msg2))
    else 
        return v
    end
end

function Base.truncate(v::CertainValue, constraint::TruncateRange)
    if v.value < constraint.min
        msg = "Truncating $v with $constraint failed\n"
        msg2 = "Need value > constraint.min, got $v > $(constraint.min)"
        throw(ArgumentError(msg * msg2))
    elseif v.value > constraint.max
        msg = "Truncating $v with $constraint failed\n"
        msg2 = "Need value < constraint.max, got $v < $(constraint.max)"
        throw(ArgumentError(msg * msg2))
    else 
        return v
    end
end

truncate(v::CertainValue, s::TruncateLowerQuantile) = v
truncate(v::CertainValue, s::TruncateUpperQuantile) = v
truncate(v::CertainValue, s::TruncateQuantiles) = v
truncate(v::CertainValue, s::TruncateStd) = v
