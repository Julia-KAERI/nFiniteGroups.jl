struct CBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group
    function CBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == N
        mat = zeros(Int64, N, N) 
        for i in 1:N
            mat[:, i] = char2row(s[i], N)
        end
        return new{N}(sym, mat, inv, CBaseGroup{N})
    end
end

struct CBaseGroup{N} <: PointGroup where N

    elements::LittleDict{Symbol, CBaseGroupElement{N}}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}   
    function CBaseGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => CBaseGroupElement(N, :E, "ab", :E),
                :C21 => CBaseGroupElement(N, :C21, "bc", :C21),
            )
            
        elseif N == 3
            els = LittleDict(
                :E => CBaseGroupElement(N, :E, "abc", :E),
                :C31 => CBaseGroupElement(N, :C31, "bca", :C32),
                :C32 => CBaseGroupElement(N, :C32, "cab", :C31),
            )
            
        elseif N == 4
            els = LittleDict(
                :E => CBaseGroupElement(N, :E, "abcd", :E),
                :C41 => CBaseGroupElement(N, :C41, "bcda", :C43),
                :C21 => CBaseGroupElement(N, :C21, "cdab", :C21),
                :C43 => CBaseGroupElement(N, :C43, "dabc", :C41),                
            )
            
        elseif N == 6
            els = LittleDict(
                :E => CBaseGroupElement(N, :E,     "abcdef", :E),
                :C61 => CBaseGroupElement(N, :C61, "bcdefa", :C65),
                :C31 => CBaseGroupElement(N, :C31, "cdefab", :C32),
                :C21 => CBaseGroupElement(N, :C21, "defabc", :C21),
                :C32 => CBaseGroupElement(N, :C32, "efabcd", :C31),
                :C65 => CBaseGroupElement(N, :C65, "fabcde", :C61),
            )            
        end

        tb = multiplication_table(els)
        return new{N}(els, "C$N", N, tb)
    end

end

CBaseGroup(N::Integer) = CBaseGroup{N}()



