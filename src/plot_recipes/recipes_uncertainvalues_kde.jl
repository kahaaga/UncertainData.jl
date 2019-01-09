import ..UncertainValues.AbstractUncertainScalarKDE
import ..SamplingConstraints: 
    SamplingConstraint,
    constrain

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


@recipe function plot_uncertainvalueKDE(uv::AbstractUncertainScalarKDE, 
        constraint::SamplingConstraint)
    
    cuv = constrain(uv, constraint)
    @series begin
        seriestype := :path
        fα --> 0.5
        fc --> :green
        xlabel --> "Value"
        ylabel --> "Density"
        label --> ""
        cuv.distribution.x, cuv.distribution.density ./ sum(cuv.distribution.density)
    end
end
