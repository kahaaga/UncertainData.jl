

@recipe function fmultiple(o1::AbstractUncertainValue,
                            o2::AbstractUncertainValue;
                            mix = false,
                            n_samples = 10000, nbins = 50)
    size --> (300, 400)
    d1 = o1.distribution
    d2 = o1.distribution
    @series begin
        label --> "P1, $d1"
        seriestype := :bar
        fα --> 0.4
        fc --> :green
        fit(Histogram, resample(d1, n_samples), nbins = nbins)
    end
    @series begin
        label --> "P2, $d2"
        seriestype := :bar
        fc --> :blue
        fα --> 0.4
        fit(Histogram, resample(d2, n_samples), nbins = nbins)
    end

    if mix
        M = MixtureModel([d1, d2])

        @series begin
            label --> "MixtureModel with uniform priors"
            seriestype := :bar
            fα --> 0.6
            fc --> :black
            fit(Histogram, rand(M, n_samples), nbins = nbins)
        end
    end
end
