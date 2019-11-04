using Interpolations 

x  = [NaN, NaN, 2.0, 1.0, 2.0, NaN, 2.5, 2.3, NaN, 5.6, 8.7, NaN]
g = 1:length(x)

intp = interpolate_nans(g, x, Linear(), NaN)

@test isnan(intp[1])
@test isnan(intp[end])
@test any(isnan.(intp[3:end-1])) == false

intp = interpolate_nans(g, x, Linear(), Flat(OnGrid()))

@test intp[1] == intp[3]
@test intp[end] == intp[end-1]
@test any(isnan.(intp[3:end-1])) == false


x1 = interpolate_nans(1:20, x, Linear(), NaN)
x2 = fill_nans(x, Linear())

all(x1[.!(isnan.(x1))] .≈ x2[.!(isnan.(x2))])