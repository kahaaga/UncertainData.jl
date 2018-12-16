
using Documenter
using DocumenterMarkdown
using UncertainData

PAGES = [
    "index.md",
    "uncertainvalue.md", 
    "ensemble_statistics.md",
	"resampling.md",
    "hypothesis_tests.md",
    "implementing_algorithms_for_uncertaindata.md"
]

makedocs(
    modules = [UncertainData],
    sitename = "UncertainData.jl documentation",
    format = Markdown(),
    pages = PAGES
)


#deploydocs(
#    repo = "github.com/kahaaga/CausalityTools.jl.git",
#)
