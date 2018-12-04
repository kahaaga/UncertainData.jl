using RecipesBase
using StatsBase

@recipe function fsingle(o::AbstractUncertainObservation)
    d = o.distribution
    @series begin
        label --> "$d"
        seriestype := :bar
        fα --> 0.5
        fc --> :green
        fit(Histogram, rand(d, 10000), nbins = 50)
    end
end

@recipe function f_multiple(o1::AbstractUncertainObservation,
                            o2::AbstractUncertainObservation;
                            mix = false)
    d1 = o1.distribution
    d2 = o2.distribution
    @series begin
        label --> "P1, $d1"
        seriestype := :bar
        fα --> 0.4
        fc --> :green
        fit(Histogram, rand(d1, 10000), nbins = 50)
    end
    @series begin
        label --> "P2, $d2"
        seriestype := :bar
        fc --> :blue
        fα --> 0.4
        fit(Histogram, rand(d2, 10000), nbins = 50)
    end

    if mix
        M = MixtureModel([d1, d2])

        @series begin
            label --> "MixtureModel with uniform priors"
            seriestype := :bar
            fα --> 0.6
            fc --> :black
            fit(Histogram, rand(M, 10000), nbins = 50)
        end
    end
end

export fsingle, f_multiple
