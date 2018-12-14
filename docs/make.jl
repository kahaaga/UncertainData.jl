
using Documenter
using DocumenterMarkdown
using UncertainData

PAGES = [
    "index.md"
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
