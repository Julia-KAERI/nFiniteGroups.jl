struct SBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    
    function SBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == N
        mat = zeros(Int64, N, N) 
        for i in 1:N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, SBaseGroup{N})
    end

end

struct SBaseGroup{N} <: AbstractCBaseGroup{N} 
    elements::LittleDict{Symbol, SBaseGroupElement{N}}
    sym::Symbol
    order::Integer   
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  

    function SBaseGroup{N}() where N
        
        if N==2
            els = LittleDict(
                :E => SBaseGroupElement(N, :E, "ab", :E),
                :i => SBaseGroupElement(N, :i, "ba", :i),
            )
            
        elseif N == 4
            els = LittleDict(
                :E => SBaseGroupElement(N, :E, "abcd", :E),
                :S41 => SBaseGroupElement(N, :S41, "bcda", :S43),
                :C2 => SBaseGroupElement(N, :C2, "cdab", :C2),
                :S43 => SBaseGroupElement(N, :S43, "dabc", :S41),
            )
            
        elseif N == 6
            els = LittleDict(
                :E => SBaseGroupElement(N, :E, "abcdef", :E),
                :S61 => SBaseGroupElement(N, :S61, "efdabc", :S65),
                :C31 => SBaseGroupElement(N, :C31, "bcaefd", :C32),
                :S63 => SBaseGroupElement(N, :S63, "fdebca", :S63),
                :C32 => SBaseGroupElement(N, :C32, "cabfde", :C31),
                :S65 => SBaseGroupElement(N, :S65, "defcab", :S61),
            )
            
        end
        tb = multiplication_table(els)
        return new{N}(els, Symbol("S$(N)"), N, tb)
    end
end

SBaseGroup(N) = SBaseGroup{N}()
