using DynamicalSystemsBase

function eom_ar1_unidir(x, p, n)
    a₁, b₁, c_xy, σ = (p...,)
    x, y = (x...,)
    ξ₁ = rand(Normal(0, σ))
    ξ₂ = rand(Normal(0, σ))
    
    dx = a₁*x + ξ₁
    dy = b₁*y + c_xy*x + ξ₂
    return SVector{2}(dx, dy)
end

function ar1_unidir(;uᵢ = rand(2), a₁ = 0.90693, b₁ = 0.40693, c_xy = 0.5, σ = 0.40662)
    p = [a₁, b₁, c_xy, σ]
    DiscreteDynamicalSystem(eom_ar1_unidir, uᵢ, p)
end


vars = (1, 2)
npts, tstep = 50, 50
d_xind = Uniform(2.5, 5.5)
d_yind = Uniform(2.5, 5.5)
d_xval = Uniform(0.01, 0.2)
d_yval = Uniform(0.01, 0.2)

X, Y = example_uncertain_indexvalue_datasets(ar1_unidir(c_xy = 0.5), npts, vars, tstep = tstep,
    d_xind = d_xind, d_yind = d_yind,
    d_xval = d_xval, d_yval = d_yval);

time_grid = -20:100:2540
n_draws = 10000 # draws per uncertain value
n_bins = length(time_grid) - 1
wts = rand(length(X))

# Values in each bin represented as RawValues 
b = BinnedWeightedResampling(RawValues, time_grid, wts, n_draws)
bc, vs = bin(Y, b);

@test vs isa Vector{Vector{T}} where T
@test length(vs) == n_bins

# Values in each bin represented as UncertainScalarKDE
b_kde = BinnedWeightedResampling(UncertainScalarKDE, time_grid, wts, n_draws)
Y_binned = bin(Y, b_kde);

@test Y_binned isa AbstractUncertainIndexValueDataset 

# Values in each bin represented as UncertainScalarPopulation
b_pop = BinnedWeightedResampling(UncertainScalarPopulation, time_grid, wts, n_draws)
Y_binned = bin(Y, b_pop);

@test Y_binned isa AbstractUncertainIndexValueDataset 
