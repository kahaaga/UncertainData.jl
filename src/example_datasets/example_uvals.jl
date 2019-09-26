using StatsBase

##########################################
# Uncertain theoretical distributions
##########################################
uncertain_theoretical_distributions = [
    UncertainValue(Uniform, -1, 1),
    UncertainValue(Normal, 0, 1),
    UncertainValue(Gamma, 1, 2),
    UncertainValue(Beta, 1, 2),
    UncertainValue(BetaPrime, 4, 5),
    UncertainValue(Frechet, 1, 1),
    UncertainValue(Binomial, 10, 0.3),
    UncertainValue(BetaBinomial, 100, 2, 3)
]

##########################################
# Kernel density estimates
##########################################
n = 10

uncertain_kde_estimates = [
    UncertainValue(rand(100))
]

##########################################
# Fitted theoretical distributions
##########################################
n = 10

uncertain_fitted_distributions = [
    UncertainValue(Uniform, rand(Uniform(-2, 2), n)),
    UncertainValue(Normal, rand(Normal(0, 1), n))
]

########################
# Uncertain populations 
########################
pop1 = UncertainValue(
        [3.0, UncertainValue(Normal, 0, 1), 
        UncertainValue(Gamma, 2, 3), 
        UncertainValue(Uniform, rand(1000))], 
        [0.5, 0.5, 0.5, 0.5]
    )

pop2 = UncertainValue([1, 2, 3], rand(3))
pop3 = UncertainValue([1.0, 2.0, 3.0], Weights(rand(3)))

# Uncertain population consisting of uncertain populations and other stuff
pop4 = UncertainValue([pop1, pop2], [0.1, 0.5])
pop5 = UncertainValue([pop1, pop2, 2, UncertainValue(Normal, -2, 3)], Weights(rand(4)));

uncertain_scalar_populations = [pop1, pop2, pop3, pop4, pop5]


##########################################
# Gather all examples
##########################################
example_uvals = [
    uncertain_scalar_populations; 
    uncertain_theoretical_distributions; 
    uncertain_kde_estimates; 
    uncertain_fitted_distributions
];


example_uidxs = [UncertainValue(Normal, i, rand()*2) for i = 1:length(example_uvals)]


export example_uvals, example_uidxs