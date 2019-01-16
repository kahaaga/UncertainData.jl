import ..SamplingConstraints: 
    SequentialSamplingConstraint, 
    OrderedSamplingAlgorithm
import ..UncertainDatasets:
    AbstractUncertainValueDataset

""" 
    resample(udata::AbstractUncertainValueDataset, 
        sequential_constraint::SequentialSamplingConstraint;
        quantiles = [0.0001, 0.9999])

Resample a dataset by imposing a sequential sampling constraint. 

Before drawing the realization, all furnishing distributions are truncated to the provided 
`quantiles` range. This is to avoid problems in case some distributions have infinite 
support.


""" 
resample(udata::AbstractUncertainValueDataset, 
    sequential_constraint::SequentialSamplingConstraint;
    quantiles = [0.0001, 0.9999])


""" 
    resample(udata::AbstractUncertainValueDataset, 
        constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
        sequential_constraint::SequentialSamplingConstraint;
        quantiles = [0.0001, 0.9999])

Resample a dataset by first imposing regular sampling constraints on the furnishing 
distributions, then applying a sequential sampling constraint. 

Before drawing the realization, all furnishing distributions are truncated to the provided 
`quantiles` range. This is to avoid problems in case some distributions have infinite 
support.
""" 
resample(udata::AbstractUncertainValueDataset, 
    constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}, 
    sequential_constraint::SequentialSamplingConstraint;
    quantiles = [0.0001, 0.9999])