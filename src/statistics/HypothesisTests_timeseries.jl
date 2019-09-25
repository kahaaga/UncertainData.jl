import HypothesisTests.LjungBoxTest
import HypothesisTests.BoxPierceTest

#
#
# """
#     LjungBoxTest(d::UncertainDataset; n::Int = 10000,
#         lag::Int = 1, dof::Int = 0) -> LjungBoxTest
#
# Compute the Ljung-Box `Q` statistic to test the null hypothesis of
# independence in a data series represented by the uncertain dataset `d`.
#
# `lag` specifies the number of lags used in the construction of `Q`. When
# testing the residuals of an estimated model, `dof` has to be set to the number
# of estimated parameters. E.g., when testing the residuals of an ARIMA(p,0,q)
# model, set `dof=p+q`.
# """
# function LjungBoxTest(d::UncertainDataset; lag::Int = 1, dof::Int = 0)
#     LjungBoxTest(resample(d, 1)[1], lag, dof)
# end
#
# """
#     LjungBoxTest(d::UncertainDataset, n_tests::Int = 100; lag::Int = 1, dof::Int = 0) -> LjungBoxTest
#
# Compute the Ljung-Box `Q` statistic to test the null hypothesis of
# independence in a data series represented by the uncertain dataset `d`
# by performing the test on `n` independent draws of the dataset.
#
# `lag` specifies the number of lags used in the construction of `Q`. When
# testing the residuals of an estimated model, `dof` has to be set to the number
# of estimated parameters. E.g., when testing the residuals of an ARIMA(p,0,q)
# model, set `dof=p+q`.
# """
# function LjungBoxTest(d::UncertainDataset, n_tests::Int = 100; lag::Int = 1, dof::Int = 0)
#     [LjungBoxTest(resample(d)[1], lag, dof) for i = 1:n_tests]
# end
#
# """
#     BoxPierceTest(d::UncertainDataset;
#         lag::Int = 1, dof::Int = 0) -> Vector{BoxPierceTest}
#
# Compute the Box-Pierce `Q` statistic to test the null hypothesis of
# independence in a data series represented by the uncertain dataset `d`.
#
# `lag` specifies the number of lags used in the construction of `Q`. When
# testing the residuals of an estimated model, `dof` has to be set to the number
# of estimated parameters. E.g., when testing the residuals of an ARIMA(p,0,q)
# model, set `dof=p+q`.
# """
# function BoxPierceTest(d::UncertainDataset; lag::Int = 1, dof::Int = 0)
#     BoxPierceTest(resample(d, 1)[1], lag, dof)
# end
#
#
# """
#     BoxPierceTest(d::UncertainDataset, n_tests::Int = 100;
#         lag::Int = 1, dof::Int = 0) -> BoxPierceTest
#
# Compute the BoxPierceTest `Q` statistic to test the null hypothesis of
# independence in a data series represented by the uncertain dataset `d`
# by performing the test on `n` independent draws of the dataset.
#
# `lag` specifies the number of lags used in the construction of `Q`. When
# testing the residuals of an estimated model, `dof` has to be set to the number
# of estimated parameters. E.g., when testing the residuals of an ARIMA(p,0,q)
# model, set `dof=p+q`.
# """
# function BoxPierceTest(d::UncertainDataset, n_tests::Int = 100;
#         lag::Int = 1, dof::Int = 0)
#     [BoxPierceTest(resample(d, 1)[1], lag, dof) for i = 1:n_tests]
# end
#
#
# export
# LjungBoxTest,
# BoxPierceTest
