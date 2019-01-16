operators = [:(+), :(-), :(*), :(/)]

for operator in operators
    f = Meta.parse("Base.:$(operator)")
    elementwise_operator = Meta.parse(".$(operator)")

    funcs = quote 
        """ 
            $($f)(a::CertainValue, b::AbstractUncertainValue; n::Int = 30000)
        
        Compute `a $($operator) b`. Treats the certain value as a scalar and performs the 
        operation element-wise on a default of `n = 30000` realizations of `b`.

        To tune the number of draws to `n`, use the `$($operator)(a, b, n::Int)` syntax.
        """
        function $(f)(a::CertainValue, b::AbstractUncertainValue; n::Int = 30000)
            $(elementwise_operator)(a.value, b, n)
        end

        """ 
            $($f)(a::AbstractUncertainValue, b::CertainValue; n::Int = 30000)
                
        Compute `a $($operator) b`. Treats the certain value as a scalar and performs the 
        operation element-wise on a default of `n = 30000` realizations of `a`.
        
        To tune the number of draws to `n`, use the `$($operator)(a, b, n::Int)` syntax.
        """
        function $(f)(a::AbstractUncertainValue, b::CertainValue; n::Int = 30000)
            $(elementwise_operator)(a, b.value, n)
        end

        """ 
        $($f)(a::AbstractUncertainValue, b::CertainValue; n::Int)
    
        Compute `a $($operator) b`. Treats the certain value as a scalar and performs the 
        operation element-wise on `n` realizations of `a`.

        This function is called with the `$($operator)(a, b, n::Int)` syntax.
            """
        function $(f)(a::AbstractUncertainValue, b::CertainValue, n::Int)
            $(elementwise_operator)(a, b.value, n)
        end

        """ 
            $($f)(a::CertainValue, b::AbstractUncertainValue, n::Int)
        
        Compute `a $($operator) b`. Treats the certain value as a scalar and performs the 
        operation element-wise on `n` realizations of `b`.
    
        This function is called with the `$($operator)(a, b, n::Int)` syntax.
        """
        function $(f)(a::CertainValue, b::AbstractUncertainValue, n::Int)
            $(elementwise_operator)(a.value, b, n)
        end
    end

    eval(funcs)
end
