# Test that input validation works where possible

@test TruncateStd(1) isa TruncateStd{<:Int}
@test TruncateStd(1.0) isa TruncateStd{<:Real}
@test_throws DomainError TruncateStd(0) isa TruncateStd{<:Int}
@test_throws DomainError TruncateStd(0.0) isa TruncateStd{<:Real}
@test_throws DomainError TruncateStd(-1) isa TruncateStd{<:Int}
@test_throws DomainError TruncateStd(-1.2) isa TruncateStd{<:Real}

@test TruncateQuantiles(0.1, 0.9) isa TruncateQuantiles{<:Real, <:Real}
@test TruncateQuantiles(0.0, 1.0) isa TruncateQuantiles{<:Real, <:Real}
@test_throws DomainError TruncateQuantiles(-0.1, 0.9)
@test_throws DomainError TruncateQuantiles(0.2, 1.9)
@test_throws DomainError TruncateQuantiles(0.3, 0.1)

@test TruncateRange(-10, 10) isa TruncateRange{<:Int, <:Int}
@test TruncateRange(-10.0, 10) isa TruncateRange{<:Real, <:Int}
@test_throws DomainError TruncateRange(5, 3)