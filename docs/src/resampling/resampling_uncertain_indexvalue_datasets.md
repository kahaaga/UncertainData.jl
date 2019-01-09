Resampling `UncertainIndexValueDataset`s is done in the same manner as for uncertain 
values and `UncertainDatasets`.

```julia 
using UncertainData, Plots 
gr()
r1 = [UncertainValue(Normal, rand(), rand()) for i = 1:10]
r2 = UncertainValue(rand(10000))
r3 = UncertainValue(Uniform, rand(10000))
r4 = UncertainValue(Normal, -0.1, 0.5)
r5 = UncertainValue(Gamma, 0.4, 0.8)

u_values = [r1; r2; r3; r4; r5]
u_timeindices = [UncertainValue(Normal, i, rand(Uniform(0, 1))) for i = 1:length(u_values)]
uindices = UncertainDataset(u_timeindices);
udata = UncertainDataset(u_values);
```

By default, the plot recipe shows the median and 33rd to 67th percentile range error bars. 
Let's use the default plot recipe, and add some line plots with resampled realizations 
of the dataset. 

```julia 
p = plot(x) 

for i = 1:100
    s = resample(x, TruncateQuantiles(0.33, 0.67), TruncateQuantiles(0.33, 0.67))
    scatter!(p, s[1], s[2], label = "", lw = 0.3, lα = 0.1, lc = :black,
            mc = :black, ms = 0.5, mα = 0.4)
    plot!(p, s[1], s[2], label = "", lw = 0.3, lα = 0.1, lc = :black,
            mc = :black, ms = 0.5, mα = 0.4)
end
p
```

![](resample_uncertainindexvalue_dataset_default_withlines.svg)

This would of course also work with any other sampling constraint that is valid for your 
dataset.