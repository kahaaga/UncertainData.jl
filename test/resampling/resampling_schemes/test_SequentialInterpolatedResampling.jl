seq_intp = SequentialInterpolatedResampling(StrictlyIncreasing(), RegularGrid(0, N, 2))
seq_intp2 = SequentialInterpolatedResampling(StrictlyIncreasing(), RegularGrid(1:1:100))

@test seq_intp isa SequentialInterpolatedResampling
@test seq_intp2 isa SequentialInterpolatedResampling