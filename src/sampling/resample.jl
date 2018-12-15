resample(fd::FittedDistribution) = UncertainValues.resample(fd)
resample(uv::AbstractUncertainValue) = UncertainValues.resample(uv)
resample(uv::AbstractUncertainValue, n::Int) =
    UncertainValues.resample(uv, n)

resample(uv::UncertainScalarEmpiricallyDistributed) =
    UncertainValues.resample(uv)
resample(uv::UncertainScalarEmpiricallyDistributed, n::Int) =
    UncertainValues.resample(uv, n)

resample(uv::AbstractUncertainDataset) = UncertainDatasets.resample(uv)
resample(uv::AbstractUncertainDataset, n::Int) = UncertainDatasets.resample(uv, n)

export resample
