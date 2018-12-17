
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
        "Hypothesis tests" => "hypothesis_tests.md"
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


deploydocs(
    repo = "github.com/kahaaga/UncertainData.jl.git",
)
