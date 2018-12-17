
using Documenter
using DocumenterMarkdown
using UncertainData
using Distributions
using KernelDensity

PAGES = [
    "Home" => "index.md",
    "Uncertain values" => [
        "Overview" => "uncertainvalues_overview.md",
        "Kernel density estimates (KDE)" => "uncertainvalues_kde.md",
        "Fitted distributions" => "uncertainvalues_fitted.md",
        "Theoretical distributions" => "uncertainvalues_theoreticaldistributions.md"
    ],
    "Uncertain statistics" => [
        "Overview" => "ensemble_statistics.md",
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
    "Resampling" => "resampling.md",
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
        deps   = Deps.pip("mkdocs==1.0.4", "mkdocs-material==3.1.0",
        "python-markdown-math", "pygments", "pymdown-extensions"),
        repo   = "github.com/kahaaga/UncertainData.jl.git",
        target = "site",
        make = () -> run(`mkdocs build`)
    )
end
