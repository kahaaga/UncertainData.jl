
function Base.truncate(uv::TheoreticalFittedUncertainScalar,
    constraint::TruncateStd; n_draws::Int = 10000)
    m = mean(uv.distribution.distribution)
    s = std(uv.distribution.distribution)
    lower_bound = m - s
    upper_bound = m + s

    Truncated(uv.distribution, lower_bound, upper_bound)
end
