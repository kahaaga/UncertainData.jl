using Test, UncertainData

@testset "StrictlyDecreasing" begin 
        
    # Create some uncertain data with decreasing magnitude and zero overlap between values, 
    # so we're guaranteed that a strictly decreasing sequence through the dataset exists.
    N = 10
    t = [i <= N/2 ? CertainValue(float(i)) : UncertainValue(Normal, i, 1) for i = N:-1:1]
    iv = UncertainIndexValueDataset(t, t)

    test_cs = [
        NoConstraint(), 
        TruncateLowerQuantile(0.2), 
        TruncateUpperQuantile(0.2),
        TruncateQuantiles(0.2, 0.8),
        TruncateMaximum(50),
        TruncateMinimum(-50),
        TruncateRange(-50, 50),
        TruncateStd(1)
    ]
    test_seqs = [
        StrictlyIncreasing(StartToEnd())
    ]

    @testset "$(test_seqs[i])" for i in 1:length(test_seqs)
        @test resample(t, StrictlyIncreasing()) isa Vector{Float64}

        iv_draw = resample(iv, StrictlyIncreasing())
        @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}

        @testset "$(test_cs[i])" for i in 1:length(test_cs)
            c = test_cs[i] # sequential + single constraint
            cs = [sample(test_cs, 1) for k = 1:N] # sequential + multiple constraints
            @test resample(t, StrictlyIncreasing(), c) isa Vector{Float64}
            @test resample(t, StrictlyIncreasing(), cs) isa Vector{Float64}

            # Single extra constraint
            iv_draw = resample(iv, StrictlyIncreasing(), c)
            @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}
            @test all(diff(iv_draw[1]) .< 0)

            iv_draw = resample(iv, StrictlyIncreasing(), c, c)
            @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}
            @test all(diff(iv_draw[1]) .< 0)

            # Multiple extra constraints
            iv_draw = resample(iv, StrictlyIncreasing(), cs)
            @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}
            @test all(diff(iv_draw[1]) .< 0)

            iv_draw = resample(iv, StrictlyIncreasing(), cs, cs)
            @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}
            @test all(diff(iv_draw[1]) .< 0)

            iv_draw = resample(iv, StrictlyIncreasing(), c, cs)
            @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}
            @test all(diff(iv_draw[1]) .< 0)

            iv_draw = resample(iv, StrictlyIncreasing(), cs, c)
            @test iv_draw isa Tuple{Vector{Float64}, Vector{Float64}}
            @test all(diff(iv_draw[1]) .> 0)
        end
    end
end