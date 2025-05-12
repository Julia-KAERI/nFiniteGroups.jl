
abstract type AbstractCGroup{N} <: PointGroup end
abstract type AbstractCGroupElement{N} <: PointGroupElement end

struct CGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group
    function CGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == N
        mat = zeros(Int64, N, N) 
        for i in 1:N
            mat[:, i] = char2row(s[i], N)
        end
        return new{N}(sym, mat, inv, CGroup{N})
    end
end

struct CGroup{N} <: PointGroup where N

    elements::LittleDict{Symbol, CGroupElement{N}}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}   
    function CGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => CGroupElement(N, :E, "ab", :E),
                :C21 => CGroupElement(N, :C21, "bc", :C21),
            )
            
        elseif N == 3
            els = LittleDict(
                :E => CGroupElement(N, :E, "abc", :E),
                :C31 => CGroupElement(N, :C31, "bca", :C32),
                :C32 => CGroupElement(N, :C32, "cab", :C31),
            )
            
        elseif N == 4
            els = LittleDict(
                :E => CGroupElement(N, :E, "abcd", :E),
                :C41 => CGroupElement(N, :C41, "bcda", :C43),
                :C21 => CGroupElement(N, :C21, "cdab", :C21),
                :C43 => CGroupElement(N, :C43, "dabc", :C41),                
            )
            
        elseif N == 6
            els = LittleDict(
                :E => CGroupElement(N, :E,     "abcdef", :E),
                :C61 => CGroupElement(N, :C61, "bcdefa", :C65),
                :C31 => CGroupElement(N, :C31, "cdefab", :C32),
                :C21 => CGroupElement(N, :C21, "defabc", :C21),
                :C32 => CGroupElement(N, :C32, "efabcd", :C31),
                :C65 => CGroupElement(N, :C65, "fabcde", :C61),
            )            
        end

        tb = multiplication_table(els)
        return new{N}(els, "C$N", N, tb)
    end

end

CGroup(N::Integer) = CGroup{N}()



