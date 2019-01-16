import ..UncertainStatistics: quantile 

@recipe function f(uval::Tuple{AbstractUncertainValue, AbstractUncertainValue}, 
    quants_index::Vector{Float64} = [0.33, 0.67], 
    quants_values::Vector{Float64} = [0.33, 0.67])

    
    legend --> false

    idx, val = uval[1], uval[2]

    med_idx = median(idx, 10000)
    lower_idx = quantile(idx, minimum(quants_index), 10000)
    upper_idx = quantile(idx, maximum(quants_index), 10000)

    med_val = median(val, 10000)
    lower_val = quantile(val, minimum(quants_values), 10000)
    upper_val = quantile(val, maximum(quants_values), 10000)


    @series begin 
        seriescolor --> :black
        xerr --> ([med_idx - lower_idx], [upper_idx - med_idx])
        yerr --> ([med_val - lower_val], [upper_val - med_val])
        [med_idx], [med_val]
    end    
end


@recipe function f(uvals::Vector{Tuple{AbstractUncertainValue, AbstractUncertainValue}}, 
    quants_index::Vector{Float64} = [0.33, 0.67], 
    quants_values::Vector{Float64} = [0.33, 0.67])

    
    n_vals = length(uvals)

    for i = 1:n_vals
        idx, val = uvals[i]

        med_idx = median(idx, 10000)
        lower_idx = quantile(idx, minimum(quants_index), 10000)
        upper_idx = quantile(idx, maximum(quants_index), 10000)

        med_val = median(val, 10000)
        lower_val = quantile(val, minimum(quants_values), 10000)
        upper_val = quantile(val, maximum(quants_values), 10000)


        @series begin 
            #seriescolor --> :black
            label --> ""
            xerr --> ([med_idx - lower_idx], [upper_idx - med_idx])
            yerr --> ([med_val - lower_val], [upper_val - med_val])
            [med_idx], [med_val]
        end    
    end
end