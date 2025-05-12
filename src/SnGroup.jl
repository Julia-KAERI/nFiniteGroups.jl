struct SGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    function char2row(c::Char, N)
        r = "abcdefghijkl"
        s = zeros(Int64, (1, N))
        idx = findfirst(c, r)
        s[1, idx]=1
        return s
    end
    
    function SGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == N
        mat = zeros(Int64, N, N) 
        for i in 1:N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, SGroup{N})
    end


end

struct SGroup{N} <: PointGroup where N
    elements::Dict{Symbol, SGroupElement{N}}
    rep::String
    order::Integer   
    function SGroup{N}() where N
        
        if N==2
            els = Dict(
                :E => SGroupElement(N, :E, "ab", :E),
                :i => SGroupElement(N, :i, "ba", :i),
            )
            return new{2}(els, "S2", N)
        elseif N == 4
            els = Dict(
                :E => SGroupElement(N, :E, "abcd", :E),
                :S41 => SGroupElement(N, :S41, "bcda", :S43),
                :C2 => SGroupElement(N, :C2, "cdab", :C2),
                :S43 => SGroupElement(N, :S43, "dabc", :S41),
            )
            return new{4}(els, "S4", N)
        elseif N == 6
            els = Dict(
                :E => SGroupElement(N, :E, "abcdef", :E),
                :S61 => SGroupElement(N, :S61, "efdabc", :S65),
                :C31 => SGroupElement(N, :C31, "bcaefd", :C32),
                :S63 => SGroupElement(N, :S63, "fdebca", :S63),
                :C32 => SGroupElement(N, :C32, "cabfde", :C31),
                :S65 => SGroupElement(N, :S65, "defcab", :S61),
            )
            return new{6}(els, "S6", N)
        end
    end
end

SGroup(N) = SGroup{N}()

Base.:*(a::T, b::T) where T<:SGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)