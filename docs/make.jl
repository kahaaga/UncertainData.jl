
using Documenter
using DocumenterMarkdown
using UncertainData
using Distributions
using KernelDensity

PAGES = [
    "index.md",
    "Uncertain values" => [
        "uncertainvalues_overview.md",
        "uncertainvalues_kde.md",
        "uncertainvalues_fitted.md",
        "uncertainvalues_theoreticaldistributions.md"
    ],
    "Uncertain statistics" => [
        "ensemble_statistics.md",
        "Hypothesis tests" => [
			"hypothesistests/hypothesis_tests_overview.md",
            "hypothesistests/one_sample_t_test.md",
            "hypothesistests/equal_variance_t_test.md",
            "hypothesistests/unequal_variance_t_test.md",
            "hypothesistests/exact_kolmogorov_smirnov_test.md",
            "hypothesistests/approximate_twosample_kolmogorov_smirnov_test.md",
            "hypothesistests/jarque_bera_test.md",
            "hypothesistests/mann_whitney_u_test.md",
            "hypothesistests/anderson_darling_test.md"
        ],
    ],
    "Resampling" => [
		"resampling/resampling_available_constraints.md",
		"resampling/resampling_uncertain_values.md"
	],
    "implementing_algorithms_for_uncertaindata.md"
]

makedocs(
    modules = [UncertainData],
    sitename = "UncertainData.jl documentation",
    format = Markdown(),
    pages = PAGES
)

if !Sys.iswindows()
    deploydocs(
        deps   = Deps.pip("mkdocs==0.17.5", "mkdocs-material==2.9.4",
        "python-markdown-math", "pygments", "pymdown-extensions"),
        repo   = "github.com/kahaaga/UncertainData.jl.git",
        target = "site",
        make = () -> run(`mkdocs build`)
    )
end
