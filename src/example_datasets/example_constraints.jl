"""
    example_constraints(X::AbstractUncertainIndexValueDataset, 
        d_xinds = Uniform(0.5, 1.1), d_yinds = Uniform(0.9, 1.7))

Generate a set of random sampling constraints that can be used to constrain 
the indices and values of an uncertain index-value dataset `X`. These are 
generated as follows: 

- `constraints_inds = TruncateStd(rand(d_xinds))`
- `constraints_vals = [TruncateQuantiles(0.5 - rand(d_xvals), 0.5 + rand(d_xvals)) for i = 1:length(X)];`

Returns the tuple (constraints_inds, constraints_vals).
"""
function example_constraints(X::AbstractUncertainIndexValueDataset, 
        d_xinds = Uniform(0.5, 1.1), d_yinds = Uniform(0.9, 1.7))

    # Truncate indices at some fraction time their standard deviation around the man
    constraints_inds = TruncateStd(rand(d_xinds))

    # Truncate values at some percentile range
    constraints_vals = [TruncateQuantiles(0.5 - rand(d_xvals), 0.5 + rand(d_xvals)) for i = 1:length(X)];

    return (constraints_x_inds, constraints_vals)
end

"""
    example_constraints(X::AbstractUncertainIndexValueDataset, 
        Y::AbstractUncertainIndexValueDataset;
        d_xinds = Uniform(0.5, 1.1), d_yinds = Uniform(0.9, 1.7),
        d_xvals = Uniform(0.05, 0.15), d_yvals = Uniform(0.3, 0.4))

Generate a set of random sampling constraints that can be used to constrain 
the indices and values of two uncertain index-value datasets `X` and `Y`. 
The constraints are generated as follows: 

- `constraints_inds_x = TruncateStd(rand(d_xinds))`
- `constraints_inds_x = TruncateStd(rand(d_yinds))`
- `constraints_vals_x = [TruncateQuantiles(0.5 - rand(d_xvals), 0.5 + rand(d_xvals)) for i = 1:length(X)]`
- `constraints_vals_x = [TruncateQuantiles(0.5 - rand(d_yvals), 0.5 + rand(d_yvals)) for i = 1:length(Y)]`

Returns the tuple of tuples `((constraints_inds_x, constraints_vals_x), (constraints_inds_y, constraints_vals_y))`
"""
function example_constraints(X::AbstractUncertainIndexValueDataset, 
        Y::AbstractUncertainIndexValueDataset;
        d_xinds = Uniform(0.5, 1.1), d_yinds = Uniform(0.9, 1.7),
        d_xvals = Uniform(0.05, 0.15), d_yvals = Uniform(0.3, 0.4))

    # Truncate indices at some fraction time their standard deviation around the man
    constraints_x_inds = TruncateStd(rand(d_xinds))
    constraints_y_inds = TruncateStd(rand(d_yinds))

    # Truncate values at some percentile range
    constraints_x_vals = [TruncateQuantiles(0.5 - rand(d_xvals), 0.5 + rand(d_xvals)) for i = 1:length(X)];
    constraints_y_vals = [TruncateQuantiles(0.5 - rand(d_yvals), 0.5 + rand(d_yvals)) for i = 1:length(Y)];
    cs_x = (constraints_x_inds, constraints_x_vals)
    cs_y = (constraints_y_inds, constraints_y_vals)

    cs_x, cs_y
end

export example_constraints