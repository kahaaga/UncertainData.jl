o1 = UncertainValue(Normal, 0, 0.5)
o2 = UncertainValue(Normal, 2, 0.3)
o3 = UncertainValue(Uniform, 0, 4)
o4 = UncertainValue(Uniform, rand(100))


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
@test D[1:end] isa AbstractVector{<:AbstractUncertainValue}
@test D[[1, 2]] isa AbstractVector{<:AbstractUncertainValue}
@test D[:] isa AbstractVector{<:AbstractUncertainValue}

########################
# UncertainIndexDataset
########################

# Construction
UV = UncertainIndexDataset(D.values)
@test UV isa UncertainIndexDataset

# Iteration
@test length(UV) == 3
@test length([x for x in UV]) == 3

# Indexing
@test UV[1] isa AbstractUncertainValue
@test UV[end] isa AbstractUncertainValue
@test UV[1:end] isa AbstractVector{<:AbstractUncertainValue}
@test UV[[1, 2]] isa AbstractVector{<:AbstractUncertainValue}
@test UV[:] isa AbstractVector{<:AbstractUncertainValue}


########################
# UncertainValueDataset
########################

# Construction
UV = UncertainValueDataset(D.values)
@test UV isa UncertainValueDataset

# Iteration
@test length(UV) == 3
@test length([x for x in UV]) == 3

# Indexing
@test UV[1] isa AbstractUncertainValue
@test UV[end] isa AbstractUncertainValue
@test UV[1:end] isa AbstractVector{<:AbstractUncertainValue}
@test UV[[1, 2]] isa AbstractVector{<:AbstractUncertainValue}
@test UV[:] isa AbstractVector{<:AbstractUncertainValue}

#############################
# UncertainIndexValueDataset
#############################
UIV = UncertainIndexValueDataset(D, D)
UIV_from_vec = UncertainIndexValueDataset([o1, o2, o3], [o1, o2, o3])
@test UIV isa UncertainIndexValueDataset
@test UIV_from_vec isa UncertainIndexValueDataset

# Iteration
@test length(UIV) == 3
@test length([x for x in UIV]) == 3
@test UIV[1] isa Tuple{<:AbstractUncertainValue, <:AbstractUncertainValue}


# Indexing
@test UIV[1] isa Tuple{<:AbstractUncertainValue, <:AbstractUncertainValue}
@test UIV[end] isa Tuple{<:AbstractUncertainValue, <:AbstractUncertainValue}
@test UIV[1:end] isa AbstractVector
@test UIV[[1, 2]] isa AbstractVector
@test UIV[:] isa AbstractVector

@test index(UIV, 1) isa AbstractUncertainValue
@test index(UIV, 1:2) isa AbstractVector{<:AbstractUncertainValue}
