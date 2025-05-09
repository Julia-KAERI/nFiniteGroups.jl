struct CHGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    function char2row(c::Char, N)
        r = "abcdefghijkl"
        s = zeros(Int64, (1, 2*N))
        idx = findfirst(c, r)
        s[1, idx]=1
        return s
    end
    
    function CHGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, CHGroup{N})
    end


end

struct CHGroup{N} <: PointGroup where N
    elements::Dict{Symbol, CHGroupElement{N}}
    rep::String
    order::Integer   
    function CHGroup{N}() where N
        
        if N==1
            els = Dict(
                :E => CHGroupElement(N, :E, "ab", :E),
                :σh => CHGroupElement(N, :σh, "ba", :σh),
            )
            return new{1}(els, "C1h", 2*N)
        elseif N == 2
            els = Dict(
                :E => CHGroupElement(N, :E, "abcd", :E),
                :C21 => CHGroupElement(N, :C21, "badc", :C21),
                :σh => CHGroupElement(N, :σh, "cdab", :σh),
                :i => CHGroupElement(N, :i, "dcba", :i),
            )
            return new{2}(els, "C2h", 2*N)
        elseif N == 3
            els = Dict(
                :E => CHGroupElement(N, :E, "abcdef", :E),
                :C31 => CHGroupElement(N, :C31, "bcaefd", :C32),
                :C32 => CHGroupElement(N, :C32, "cabfde", :C31),
                :σh => CHGroupElement(N, :σh, "defabc", :σh),
                :S3 => CHGroupElement(N, :S3, "efdbca", :σhC32),
                :σhC32 => CHGroupElement(N, :σhC32, "fdecab", :S3),
            )
            return new{3}(els, "C3h", 2*N)
        elseif N == 4
            els = Dict(
                :E => CHGroupElement(N, :E, "abcdefgh", :E),
                :C41 => CHGroupElement(N, :C41, "cdefghab", :C43),
                :C42 => CHGroupElement(N, :C42, "efghabcd", :C42),
                :C43 => CHGroupElement(N, :C43, "ghabcdef", :C41),
                :σ1 => CHGroupElement(N, :σ1, "hgfedcba", :σ1),
                :σ2 => CHGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :σ1d => CHGroupElement(N, :σ2, "bahgfedc", :σ1d),
                :σ2d => CHGroupElement(N, :σ2, "fedcbahg", :σ2d),
            )
            return new{4}(els, "C4h", 2*N)

        elseif N == 6
            els = Dict(
                :E => CHGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => CHGroupElement(N, :C61, "cdefghijklab", :C65),
                :C62 => CHGroupElement(N, :C62, "efghijklabcd", :C64),
                :C63 => CHGroupElement(N, :C63, "ghijklabcdef", :C63),
                :C64 => CHGroupElement(N, :C64, "ijklabcdefgh", :C62),
                :C65 => CHGroupElement(N, :C65, "klabcdefghij", :C61),
                :σ1 => CHGroupElement(N, :σ1,   "lkjihgfedcba", :σ1),
                :σ2 => CHGroupElement(N, :σ2,   "dcbalkjihgfe", :σ2),
                :σ3 => CHGroupElement(N, :σ3,   "hgfedcbalkji", :σ3),
                :σ1d => CHGroupElement(N, :σ1d, "balkjihgfedc", :σ1d),
                :σ2d => CHGroupElement(N, :σ2d, "fedcbalkjihg", :σ2d),
                :σ3d => CHGroupElement(N, :σ3d, "jihgfedcbalk", :σ3d),
            )
            return new{6}(els, "C6h", 2*N)
        end
    end
end

CHGroup(N) = CHGroup{N}()

Base.:*(a::T, b::T) where T<:CHGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)