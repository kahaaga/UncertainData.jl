o1 = UncertainValue(0, -5, 5, Normal)
o2 = UncertainValue(2, 0, 4, Normal)
o3 = UncertainValue(0, 4, Uniform)
o4 = UncertainEmpiricalValue(rand(100), Uniform)


#####################
# UncertainDataset
####################

# Iteration
D = UncertainDataset([o1, o2, o3])
@test length(D) == 3
@test length([x for x in D]) == 3

# Indexing
@test D[1] isa AbstractUncertainValue
@test D[end] isa AbstractUncertainValue
@test D[1:end] isa AbstractVector{AbstractUncertainValue}
@test D[[1, 2]] isa AbstractVector{AbstractUncertainValue}
@test D[:] isa AbstractVector{AbstractUncertainValue}

########################
# UncertainValueDataset
########################

# Construction
UV = UncertainValueDataset(D)
@test UV isa UncertainValueDataset

# Iteration
@test length(UV) == 3
@test length([x for x in UV]) == 3

# Indexing
@test UV[1] isa AbstractUncertainValue
@test UV[end] isa AbstractUncertainValue
@test UV[1:end] isa AbstractVector{AbstractUncertainValue}
@test UV[[1, 2]] isa AbstractVector{AbstractUncertainValue}
@test UV[:] isa AbstractVector{AbstractUncertainValue}

#############################
# UncertainIndexValueDataset
#############################
UIV = UncertainIndexValueDataset(D, D)
@test UIV isa UncertainIndexValueDataset

# Iteration
@test length(UIV) == 3
@test length([x for x in UIV]) == 3
@test UIV[1] isa Tuple{AbstractUncertainValue, AbstractUncertainValue}


# Indexing
@test UIV[1] isa Tuple{AbstractUncertainValue, AbstractUncertainValue}
@test UIV[end] isa Tuple{AbstractUncertainValue, AbstractUncertainValue}
@test UIV[1:end] isa AbstractVector
@test UIV[[1, 2]] isa AbstractVector
@test UIV[:] isa AbstractVector

@test index(UIV, 1) isa AbstractUncertainValue
@test index(UIV, 1:2) isa AbstractVector{AbstractUncertainValue}
