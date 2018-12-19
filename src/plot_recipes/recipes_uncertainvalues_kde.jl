import ..UncertainValues.AbstractUncertainScalarKDE

@recipe function plot_uncertainvalueKDE(uv::AbstractUncertainScalarKDE)
    @series begin
        seriestype := :path
        fα --> 0.5
        fc --> :green
        xlabel --> "Value"
        ylabel --> "Density"
        label --> ""
        uv.distribution.x, uv.distribution.density ./ sum(uv.distribution.density)
    end
end
