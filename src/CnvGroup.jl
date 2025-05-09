struct CVGroupElement{N} <: AbstractCGroupElement{N}
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
    
    function CVGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, CVGroup{N})
    end


end

struct CVGroup{N} <: PointGroup where N
    elements::Dict{Symbol, CVGroupElement{N}}
    rep::String
    order::Integer   
    function CVGroup{N}() where N
        if N == 2
            els = Dict(
                :E => CVGroupElement(N, :E, "abcd", :E),
                :C21 => CVGroupElement(N, :C21, "cdab", :C21),
                :σ1 => CVGroupElement(N, :σ1, "badc", :σ1),
                :σ2 => CVGroupElement(N, :σ2, "dcba", :σ2),
            )
            return new{2}(els, "C2v", 2*N)
        elseif N == 3
            els = Dict(
                :E => CVGroupElement(N, :E, "abcdef", :E),
                :C31 => CVGroupElement(N, :C31, "cdefab", :C32),
                :C32 => CVGroupElement(N, :C32, "efabcd", :C31),
                :σ1 => CVGroupElement(N, :σ1, "fedcba", :σ1),
                :σ2 => CVGroupElement(N, :σ2, "dcbafe", :σ2),
                :σ3 => CVGroupElement(N, :σ2, "bafedc", :σ3),
            )
            return new{3}(els, "C3v", 2*N)
        elseif N == 4
            els = Dict(
                :E => CVGroupElement(N, :E, "abcdefgh", :E),
                :C41 => CVGroupElement(N, :C41, "cdefghab", :C43),
                :C42 => CVGroupElement(N, :C42, "efghabcd", :C42),
                :C43 => CVGroupElement(N, :C43, "ghabcdef", :C41),
                :σ1 => CVGroupElement(N, :σ1, "hgfedcba", :σ1),
                :σ2 => CVGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :σ1d => CVGroupElement(N, :σ2, "bahgfedc", :σ1d),
                :σ2d => CVGroupElement(N, :σ2, "fedcbahg", :σ2d),
            )
            return new{4}(els, "C4v", 2*N)

        elseif N == 6
            els = Dict(
                :E => CVGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => CVGroupElement(N, :C61, "cdefghijklab", :C65),
                :C62 => CVGroupElement(N, :C62, "efghijklabcd", :C64),
                :C63 => CVGroupElement(N, :C63, "ghijklabcdef", :C63),
                :C64 => CVGroupElement(N, :C64, "ijklabcdefgh", :C62),
                :C65 => CVGroupElement(N, :C65, "klabcdefghij", :C61),
                :σ1 => CVGroupElement(N, :σ1,   "lkjihgfedcba", :σ1),
                :σ2 => CVGroupElement(N, :σ2,   "dcbalkjihgfe", :σ2),
                :σ3 => CVGroupElement(N, :σ3,   "hgfedcbalkji", :σ3),
                :σ1d => CVGroupElement(N, :σ1d, "balkjihgfedc", :σ1d),
                :σ2d => CVGroupElement(N, :σ2d, "fedcbalkjihg", :σ2d),
                :σ3d => CVGroupElement(N, :σ3d, "jihgfedcbalk", :σ3d),
            )
            return new{6}(els, "C6v", 2*N)
        end
    end
end

CVGroup(N) = CVGroup{N}()

Base.:*(a::T, b::T) where T<:CVGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)