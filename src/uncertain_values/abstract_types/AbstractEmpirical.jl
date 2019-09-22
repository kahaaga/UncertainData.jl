
abstract type AbstractEmpiricalValue <: AbstractUncertainValue end

function summarise(ed::AbstractEmpiricalValue)
    _type = typeof(ed)
    disttype = typeof(ed.distribution)

    l = length(ed.values)
    summary = "$_type estimated as a $disttype from $l values"
    return summary
end

Base.show(io::IO, ed::AbstractEmpiricalValue) = println(io, summarise(ed))

@recipe function plot_empiricalval(empval::AbstractEmpiricalValue;
        nbins = 200, n_samples = 10000)
    dist = empval.distribution
    @series begin
        seriestype := :histogram
        fit(Histogram, rand(dist, n_samples), nbins = nbins)
    end
end


export
AbstractEmpiricalValue
