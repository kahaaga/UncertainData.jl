import ..UncertainDatasets: 
    AbstractUncertainValueDataset

import ..UncertainStatistics: mean, std, median, quantile


@recipe function f(udata::AbstractUncertainValueDataset, quants::Vector{Float64} = [0.33, 0.67])
    n_points = length(udata)
    
    
    for i = 1:n_points
        med = median(udata[i], 10000)
        lower = quantile(udata[i], minimum(quants), 10000)
        upper = quantile(udata[i], maximum(quants), 10000)

        @series begin 
            seriescolor --> :black
            label --> ""
            yerr --> ([med - lower], [upper - med])
            [i], [med]

        end
    end
    
end