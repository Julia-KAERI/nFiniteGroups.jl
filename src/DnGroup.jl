
abstract type AbstractDGroup{N} <: PointGroup end
abstract type AbstractDGroupElement{N} <: PointGroupElement end

struct DGroupElement{N} <: AbstractCGroupElement{N}
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
    
    function DGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, DGroup{N})
    end


end

struct DGroup{N} <: PointGroup where N
    elements::Dict{Symbol, DGroupElement{N}}
    rep::String
    order::Integer   
    function DGroup{N}() where N
        if N == 2
            els = Dict(
                :E => DGroupElement(N, :E, "abcd", :E),
                :C21 => DGroupElement(N, :C21, "cdab", :C21),
                :d1 => DGroupElement(N, :d1, "badc", :d1),
                :d2 => DGroupElement(N, :d2, "dcba", :d2),
            )
            return new{2}(els, "D2", 2*N)
        elseif N == 3
            els = Dict(
                :E => DGroupElement(N, :E, "abcdef", :E),
                :C31 => DGroupElement(N, :C31, "bcaefd", :C32),
                :C32 => DGroupElement(N, :C32, "cabfde", :C31),
                :d1 => DGroupElement(N, :d1, "dfeacb", :d1),
                :d2 => DGroupElement(N, :d2, "edfbac", :d2),
                :d3 => DGroupElement(N, :d3, "fedcba", :d3),
            )
            return new{3}(els, "D3", 2*N)
        elseif N == 4
            els = Dict(
                :E => DGroupElement(N, :E, "abcdefgh", :E),
                :C41 => DGroupElement(N, :C41, "bcdafghe", :C43),
                :C2 => DGroupElement(N, :C2, "cdabghef", :C2),
                :C43 => DGroupElement(N, :C43, "dabchefg", :C41),
                :d1 => DGroupElement(N, :d1, "ehgfadcb", :d1),
                :d2 => DGroupElement(N, :d2, "fehgbadc", :d2),
                :d3 => DGroupElement(N, :d3, "gfehcbad", :d3),
                :d4 => DGroupElement(N, :d4, "hgfedcba", :d4),
            )
            return new{4}(els, "D4", 2*N)

        elseif N == 6
            els = Dict(
                :E => DGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => DGroupElement(N, :C61, "bcdefahijklg", :C65),
                :C31 => DGroupElement(N, :C31, "cdefabijklgh", :C32),
                :C21 => DGroupElement(N, :C21, "defabcjklghi", :C21),
                :C32 => DGroupElement(N, :C32, "efabcdklghij", :C31),
                :C65 => DGroupElement(N, :C65, "fabcdelghijk", :C61),
                :d1 => DGroupElement(N, :d1,   "glkjihafedcb", :d1),
                :d2 => DGroupElement(N, :d2,   "hglkjibafedc", :d2),
                :d3 => DGroupElement(N, :d3,   "ihglkjcbafed", :d3),
                :d4 => DGroupElement(N, :d4,   "jihglkdcbafe", :d4),
                :d5 => DGroupElement(N, :d5,   "kjihgledcbaf", :d5),
                :d6 => DGroupElement(N, :d6,   "lkjihgfedcba", :d6),
            )
            return new{6}(els, "C6v", 2*N)
        end
    end
end

DGroup(N) = DGroup{N}()

Base.:*(a::T, b::T) where T<:DGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)

struct DndGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    function char2row(c::Char, N)
        r = "abcdefghijkl"
        s = zeros(Int64, (1, 4*N))
        idx = findfirst(c, r)
        s[1, idx]=1
        return s
    end
    
    function DndGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 4*N
        mat = zeros(Int64, 4*N, 4*N) 
        for i in 1:4*N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, DndGroup{N})
    end


end

struct DndGroup{N} <: PointGroup where N
    elements::Dict{Symbol, DndGroupElement{N}}
    rep::String
    order::Integer   
    function DndGroup{N}() where N
        if N == 2
            els = Dict(
                :E => DndGroupElement(N, :E, "abcdefgh", :E),
                :C21 => DndGroupElement(N, :C21, "cdabghef", :C21),
                :d1 => DndGroupElement(N, :d1, "ehgfadcb", :d1),
                :d2 => DndGroupElement(N, :d2, "gfehcbad", :d2),
                :σ1 => DndGroupElement(N, :σ1, "badcfehg", :σ1), 
                :σ2 => DndGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :S41 => DndGroupElement(N, :S41, "fghebcda", :S43),
                :S43 => DndGroupElement(N, :S43, "hefgdabc", :S41),

            )
            return new{2}(els, "D2d", 4*N)
        elseif N == 3
            els = Dict(
                :E => DndGroupElement(N, :E,        "abcdefghijkl", :E),
                :C31 => DndGroupElement(N, :C31,    "cdefabijklgh", :C32),
                :C32 => DndGroupElement(N, :C32,    "efabcdklghij", :C31),
                :d1 => DndGroupElement(N, :d1,      "hglkjibafedc", :d1),
                :d2 => DndGroupElement(N, :d2,      "jihglkdcbafe", :d2),
                :d3 => DndGroupElement(N, :d3,      "lkjihgfedcba", :d3),
                :σ1 => DndGroupElement(N, :σ1,      "bafedclkjihg", :σ1),
                :σ2 => DndGroupElement(N, :σ2,      "dcbafehglkji", :σ2),
                :σ3 => DndGroupElement(N, :σ3,      "fedcbajihglk", :σ3),
                :S61 => DndGroupElement(N, :S61,    "ghijklcdefab", :S65),
                :S63 => DndGroupElement(N, :S63,    "ijklghefabcd", :S63),
                :S65 => DndGroupElement(N, :S65,    "klghijabcdef", :S61),
            )
            return new{3}(els, "D3d", 4*N)
        
        end
    end
end

DndGroup(N) = DndGroup{N}()
elements(G::DndGroup{N}) where N = [k for (k, t) in G.elements]
Base.:*(a::T, b::T) where T<:DndGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)

struct DnhGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    function char2row(c::Char, N)
        r = "abcdefghijkl"
        s = zeros(Int64, (1, 4*N))
        idx = findfirst(c, r)
        s[1, idx]=1
        return s
    end
    
    function DnhGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 4*N
        mat = zeros(Int64, 4*N, 4*N) 
        for i in 1:4*N
            mat[:, i] = char2row(s[i], N)
        end
 
        return new{N}(sym, mat, inv, DnhGroup{N})
    end


end

struct DnhGroup{N} <: PointGroup where N
    elements::Dict{Symbol, DnhGroupElement{N}}
    rep::String
    order::Integer

    function DnhGroup{N}() where N
        if N == 2
            els = Dict(
                :E => DnhGroupElement(N, :E, "abcdefgh", :E),
                :C21 => DnhGroupElement(N, :C21, "cdabghef", :C21),
                :σ1 => DnhGroupElement(N, :σ1, "dcbahgfe", :σ1),
                :σ2 => DnhGroupElement(N, :σ2, "badcfehg", :σ2),
                :σh => DnhGroupElement(N, :σh, "efghabcd", :σh), 
                :i => DnhGroupElement(N, :i, "ghefcdab", :i),
                :σ1i => DnhGroupElement(N, :σ1i, "fehgbadc", :σ1i),
                :σ2i => DnhGroupElement(N, :σ2i, "hgfedcba", :σ2i),

            )
            return new{2}(els, "D2h", 4*N, nothing)
        elseif N == 3
            els = Dict(
                :E => DnhGroupElement(N, :E,            "abcdefghijkl", :E),
                :C31 => DnhGroupElement(N, :C31,        "cdefabijklgh", :C32),
                :C32 => DnhGroupElement(N, :C32,        "efabcdklghij", :C31),
                :σ1 => DnhGroupElement(N, :σ1,          "fedcbalkjihg", :σ1),
                :σ2 => DnhGroupElement(N, :σ2,          "bafedchglkji", :σ2),
                :σ3 => DnhGroupElement(N, :σ3,          "dcbafejihglk", :σ3),
                :σh => DnhGroupElement(N, :σh,          "ghijklabcdef", :σh),
                :S31 => DnhGroupElement(N, :S31,        "ijklghcdefab", :S32),
                :S32 => DnhGroupElement(N, :S32,        "klghijefabcd", :S31),
                :σ1σh => DnhGroupElement(N, :σ1σh,      "lkjihgfedcba", :σ1σh),
                :σ2σh => DnhGroupElement(N, :σ2σh,      "hglkjibafedc", :σ2σh),
                :σ3σh => DnhGroupElement(N, :σ3σh,      "jihglkdcbafe", :σ3σh),
            )
            return new{3}(els, "D3h", 4*N)
        elseif N == 4
            els = Dict(
                :E => DnhGroupElement(N, :E,            "abcdefghijklmnop", :E),
                :C41 => DnhGroupElement(N, :C41,        "cdefghabklmnopij", :C43),
                :C21 => DnhGroupElement(N, :C21,        "efghabcdmnopijkl", :C21),
                :C43 => DnhGroupElement(N, :C43,        "ghabcdefopijklmn", :C41),
                :σ2 => DnhGroupElement(N, :σ2,          "bafedchglkji", :σ2),
                :σ3 => DnhGroupElement(N, :σ3,          "dcbafejihglk", :σ3),
                :σh => DnhGroupElement(N, :σh,          "ghijklabcdef", :σh),
                :S31 => DnhGroupElement(N, :S31,        "ijklghcdefab", :S32),
                :S32 => DnhGroupElement(N, :S32,        "klghijefabcd", :S31),
                :σ1σh => DnhGroupElement(N, :σ1σh,      "lkjihgfedcba", :σ1σh),
                :σ2σh => DnhGroupElement(N, :σ2σh,      "hglkjibafedc", :σ2σh),
                :σ3σh => DnhGroupElement(N, :σ3σh,      "jihglkdcbafe", :σ3σh),
            )
            return new{4}(els, "D4h", 4*N)
        
        end
    end
end

DnhGroup(N) = DnhGroup{N}()
elements(G::DnhGroup{N}) where N = [k for (k, t) in G.elements]
Base.:*(a::T, b::T) where T<:DnhGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)