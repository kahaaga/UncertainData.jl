
##############
# Constructors
##############

# Create some uncertain data of different types
o1 = UncertainValue(Normal, 0, 0.5)
o2 = UncertainValue(Normal, 2, 0.3)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))
o5 = UncertainValue(rand(400))
o7 = CertainValue(2)
o8 = UncertainValue([2, 3, 4], [4, 5, 2])
o9 = UncertainValue([2, 4, 5, 2], rand(4))

uvals = [o1, o2, o3, o4, o5, o7, o8, o9]
UV = UncertainValueDataset(uvals)
UI = UncertainIndexDataset(uvals)
CUV = constrain(UV, TruncateQuantiles(0.1, 0.9))
CUI = constrain(UV, TruncateQuantiles(0.1, 0.9))

# Vectors
@test UncertainIndexValueDataset(uvals, uvals) isa UncertainIndexValueDataset

# Non-constrained datasets
@test UncertainIndexValueDataset(uvals, UV) isa UncertainIndexValueDataset
@test UncertainIndexValueDataset(UI, uvals) isa UncertainIndexValueDataset
@test UncertainIndexValueDataset(UI, UV) isa UncertainIndexValueDataset

# Constrained datasets
@test UncertainIndexValueDataset(uvals, CUV) isa UncertainIndexValueDataset
@test UncertainIndexValueDataset(CUI, uvals) isa UncertainIndexValueDataset
@test UncertainIndexValueDataset(CUI, CUV) isa UncertainIndexValueDataset

UIV = UncertainIndexValueDataset(UI, UV)

###########
# Iteration
###########
@test length(UIV) == 3
@test length([x for x in UIV]) == 3
@test UIV[1] isa Tuple{<:AbstractUncertainValue, <:AbstractUncertainValue}

###########
# Indexing
###########
@test UIV[1] isa Tuple{<:AbstractUncertainValue, <:AbstractUncertainValue}
@test UIV[end] isa Tuple{<:AbstractUncertainValue, <:AbstractUncertainValue}
@test UIV[1:end] isa AbstractVector
@test UIV[[1, 2]] isa AbstractVector
@test UIV[:] isa AbstractVector

@test index(UIV, 1) isa AbstractUncertainValue
@test index(UIV, 1:2) isa AbstractVector{<:AbstractUncertainValue}
