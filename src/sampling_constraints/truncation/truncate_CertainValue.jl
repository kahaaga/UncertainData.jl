import ..UncertainValues.CertainScalar

Base.truncate(v::CertainScalar) = v
function Base.truncate(v::CertainScalar, constraint::TruncateMaximum)
    if v.value > constraint.max
        msg = "Truncating $v with $constraint failed\n"
        msg2 = "Need value < constraint.max, got $v < $(constraint.max)"
        throw(ArgumentError(msg * msg2))
    else 
        return v
    end
end

function Base.truncate(v::CertainScalar, constraint::TruncateMinimum)
    if v.value < constraint.min
        msg = "Truncating $v with $constraint failed\n"
        msg2 = "Need value > constraint.min, got $v > $(constraint.min)"
        throw(ArgumentError(msg * msg2))
    else 
        return v
    end
end

function Base.truncate(v::CertainScalar, constraint::TruncateRange)
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

truncate(v::CertainScalar, s::TruncateLowerQuantile) = v
truncate(v::CertainScalar, s::TruncateUpperQuantile) = v
truncate(v::CertainScalar, s::TruncateQuantiles) = v
truncate(v::CertainScalar, s::TruncateStd) = v
