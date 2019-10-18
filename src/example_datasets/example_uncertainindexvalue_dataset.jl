using DynamicalSystemsBase 

"""
    example_uncertain_indexvalue_datasets(system::DynamicalSystems.DiscreteDynamicalSystem, n::Int, vars; Ttr = 1000,
        d_xval = Uniform(0.01, 0.4), d_yval = Uniform(0.01, 0.5),
        d_xind = Uniform(0.5, 1.5), d_yind = Uniform(0.5, 1.5))

Generate a pair of `UncertainIndexValueDataset`s from a discrete dynamical `system`, generated 
by iterating the system `n` time after a transient run of `Ttr` steps, then gathering the 
columns at positions `vars` (should be two column indices) as separate time series. 

Each of the time series, call them `x` and `y`, are then converted to uncertain values. 
Specifically, replace `x[i]` and `y[i]` with `UncertainValue(Normal, x[i], rand(d_xval)`
and `UncertainValue(Normal, y[i], rand(d_xval)`. Because the time series don't have 
explicit time indices associated with them, we'll create some time indices as the range 
`1:tstep:length(x)*tstep`, call them `x_inds` and `y_inds`. The time indices for `x` and `y` 
are also normally distributed, such that `x_inds[i] = UncertainValue(Normal, i, rand(d_xind)`,
and the same for `y_inds`.

Returns a tuple of `UncertainIndexValueDataset` instances, one for `x` and one for `y`.
"""
function example_uncertain_indexvalue_datasets(system::DiscreteDynamicalSystem, n::Int, vars; Ttr = 1000,
        tstep = 3,
        d_xval = Uniform(0.01, 0.4), d_yval = Uniform(0.01, 0.5),
        d_xind = Uniform(0.5, 1.5), d_yind = Uniform(0.5, 1.5))

    orbit = trajectory(system, n - 1, Ttr = 1000);
    x_vals = UncertainValueDataset([UncertainValue(Normal, x, rand(d_xval)) for x in orbit[:, vars[1]]])
    y_vals = UncertainValueDataset([UncertainValue(Normal, y, rand(d_yval)) for y in orbit[:, vars[2]]])

    x_inds = UncertainIndexDataset([UncertainValue(Normal, i, rand(d_xind)) for i = 1:tstep:length(x_vals)*tstep]);
    y_inds = UncertainIndexDataset([UncertainValue(Normal, i, rand(d_yind)) for i = 1:tstep:length(y_vals)*tstep]);

    X = UncertainIndexValueDataset(x_inds, x_vals)
    Y = UncertainIndexValueDataset(y_inds, y_vals);

    return X, Y
end

export example_uncertain_indexvalue_datasets