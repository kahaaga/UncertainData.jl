c1 = ConstrainedValueResampling(TruncateStd(1), TruncateStd(1), TruncateQuantiles(0.1, 0.2))
c2 = ConstrainedValueResampling(100, TruncateStd(1), TruncateStd(1), TruncateQuantiles(0.1, 0.2))

@test c1 isa ConstrainedValueResampling{3}
@test c1.n == 1
@test c2 isa ConstrainedValueResampling{3}
@test c2.n == 100