---
title: 'UncertainData.jl: a Julia package for working with measurements and datasets with uncertainties.'
tags:
  - Julia
  - uncertainty
  - measurements
authors:
  - name: Kristian Agasøster Haaga
    orcid: 0000-0001-6880-8725
    affiliation: "1, 2, 3"
affiliations:
  - name: Department of Earth Science, University of Bergen, Bergen, Norway
    index: 1 
  - name: Jebsen Centre for Deep Sea Research, Bergen, Norway
    index: 2
  - name: Bjerknes Centre for Climate Research, Bergen, Norway
    index: 3
date: 05 August 2019
bibliography: paper.bib
---

# Summary

``UncertainData.jl`` provides an interface to represent data with associated uncertainties 
for the Julia programming language [@Bezanson:2017]. Unlike 
``Measurements.jl`` [@Giordano:2016], which deals with exact error propagation of normally 
distributed values, ``UncertainData.jl`` uses a resampling approach to deal with 
uncertainties in calculations. This allows working with and combining any type of uncertain 
value for which a resampling method can be defined. Examples of currently supported 
uncertain values are: theoretical distributions, e.g., those supported by 
[Distributions.jl](https://github.com/JuliaStats/Distributions.jl) [@Besan:2019, @Lin:2019]; 
values whose states are represented by a finite set of values with weighted probabilities; 
values represented by empirical distributions; and more.

The package simplifies resampling from uncertain datasets whose data points potentially 
have different kinds of uncertainties, both in data values and potential index values 
(e.g., time or space). The user may resample using a set of pre-defined constraints, 
truncating the supports of the distributions furnishing the uncertain datasets, combined
with interpolation on pre-defined grids. Methods for sequential resampling of ordered 
datasets that have indices with uncertainties are also provided.

Using Julia's multiple dispatch, ``UncertainData.jl`` extends most elementary mathematical 
operations, hypothesis tests from 
[HypothesisTests.jl](https://github.com/JuliaStats/HypothesisTests.jl), and 
various methods from the [StatsBase.jl](https://github.com/JuliaStats/StatsBase.jl) package 
for uncertain values and uncertain datasets. 
Additional statistical algorithms in other packages are trivially adapted to handle 
uncertain values and datasets from ``UncertainData.jl`` by using multiple dispatch and 
the provided resampling framework.

``UncertainData.jl``  was originally designed to form the backbone of the uncertainty 
handling in the [CausalityTools.jl](https://github.com/kahaaga/CausalityTools.jl) package, 
with the aim of quantifying the sensitivity of statistical time series causality detection 
algorithms - a work that is in progress. Recently, the package has also been used in 
paleoclimate research [@Vasskog:2019].

# References
