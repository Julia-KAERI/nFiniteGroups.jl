
abstract type AbstractDGroup{N} <: PointGroup end
abstract type AbstractDGroupElement{N} <: PointGroupElement end

struct DGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    function DGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], 2*N)
        end
 
        return new{N}(sym, mat, inv, DGroup{N})
    end
end

struct DGroup{N} <: PointGroup where N
    elements::LittleDict{Symbol, DGroupElement{N}}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}   
    function DGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => DGroupElement(N, :E, "abcd", :E),
                :C21 => DGroupElement(N, :C21, "cdab", :C21),
                :d1 => DGroupElement(N, :d1, "badc", :d1),
                :d2 => DGroupElement(N, :d2, "dcba", :d2),
            )
        
        elseif N == 3
            els = LittleDict(
                :E => DGroupElement(N, :E, "abcdef", :E),
                :C31 => DGroupElement(N, :C31, "bcaefd", :C32),
                :C32 => DGroupElement(N, :C32, "cabfde", :C31),
                :d1 => DGroupElement(N, :d1, "dfeacb", :d1),
                :d2 => DGroupElement(N, :d2, "edfbac", :d2),
                :d3 => DGroupElement(N, :d3, "fedcba", :d3),
            )

        elseif N == 4
            els = LittleDict(
                :E => DGroupElement(N, :E, "abcdefgh", :E),
                :C41 => DGroupElement(N, :C41, "bcdafghe", :C43),
                :C2 => DGroupElement(N, :C2, "cdabghef", :C2),
                :C43 => DGroupElement(N, :C43, "dabchefg", :C41),
                :d1 => DGroupElement(N, :d1, "ehgfadcb", :d1),
                :d2 => DGroupElement(N, :d2, "fehgbadc", :d2),
                :d3 => DGroupElement(N, :d3, "gfehcbad", :d3),
                :d4 => DGroupElement(N, :d4, "hgfedcba", :d4),
            )

        elseif N == 6
            els = LittleDict(
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
        end
        table = multiplication_table(els)
        return new{N}(els, "D$N", 2*N, table)

    end
end

DGroup(N) = DGroup{N}()

struct DdGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    # function char2row(c::Char, N)
    #     r = "abcdefghijkl"
    #     s = zeros(Int64, (1, 4*N))
    #     idx = findfirst(c, r)
    #     s[1, idx]=1
    #     return s
    # end
    
    function DdGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 4*N
        mat = zeros(Int64, 4*N, 4*N) 
        for i in 1:4*N
            mat[:, i] = char2row(s[i], 4*N)
        end
 
        return new{N}(sym, mat, inv, DdGroup{N})
    end


end

struct DdGroup{N} <: PointGroup where N
    elements::LittleDict{Symbol, DdGroupElement{N}}
    rep::String
    order::Integer 
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  

    function DdGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => DdGroupElement(N, :E, "abcdefgh", :E),
                :C21 => DdGroupElement(N, :C21, "cdabghef", :C21),
                :d1 => DdGroupElement(N, :d1, "ehgfadcb", :d1),
                :d2 => DdGroupElement(N, :d2, "gfehcbad", :d2),
                :σ1 => DdGroupElement(N, :σ1, "badcfehg", :σ1), 
                :σ2 => DdGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :S41 => DdGroupElement(N, :S41, "fghebcda", :S43),
                :S43 => DdGroupElement(N, :S43, "hefgdabc", :S41),
            )

        elseif N == 3
            els = LittleDict(
                :E => DdGroupElement(N, :E,        "abcdefghijkl", :E),
                :C31 => DdGroupElement(N, :C31,    "cdefabijklgh", :C32),
                :C32 => DdGroupElement(N, :C32,    "efabcdklghij", :C31),
                :d1 => DdGroupElement(N, :d1,      "hglkjibafedc", :d1),
                :d2 => DdGroupElement(N, :d2,      "jihglkdcbafe", :d2),
                :d3 => DdGroupElement(N, :d3,      "lkjihgfedcba", :d3),
                :σ1 => DdGroupElement(N, :σ1,      "bafedclkjihg", :σ1),
                :σ2 => DdGroupElement(N, :σ2,      "dcbafehglkji", :σ2),
                :σ3 => DdGroupElement(N, :σ3,      "fedcbajihglk", :σ3),
                :S61 => DdGroupElement(N, :S61,    "ghijklcdefab", :S65),
                :S63 => DdGroupElement(N, :S63,    "ijklghefabcd", :S63),
                :S65 => DdGroupElement(N, :S65,    "klghijabcdef", :S61),
            )
        
        end

        table = multiplication_table(els)
        return  new{N}(els, "D$(N)d", 4*N, table)
    end
end

DdGroup(N) = DdGroup{N}()
# elements(G::DdGroup{N}) where N = [k for (k, t) in G.elements]
# Base.:*(a::T, b::T) where T<:DdGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)

struct DhGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    
    function DhGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 4*N
        mat = zeros(Int64, 4*N, 4*N) 
        for i in 1:4*N
            mat[:, i] = char2row(s[i], 4*N)
        end 
        return new{N}(sym, mat, inv, DhGroup{N})
    end
end

struct DhGroup{N} <: PointGroup where N
    elements::LittleDict{Symbol, DhGroupElement{N}}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function DhGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => DhGroupElement(N, :E, "abcdefgh", :E),
                :C21 => DhGroupElement(N, :C21, "cdabghef", :C21),
                :σ1 => DhGroupElement(N, :σ1, "dcbahgfe", :σ1),
                :σ2 => DhGroupElement(N, :σ2, "badcfehg", :σ2),
                :σh => DhGroupElement(N, :σh, "efghabcd", :σh), 
                :i => DhGroupElement(N, :i, "ghefcdab", :i),
                :σ1i => DhGroupElement(N, :σ1i, "fehgbadc", :σ1i),
                :σ2i => DhGroupElement(N, :σ2i, "hgfedcba", :σ2i),

            )
            
        elseif N == 3
            els = LittleDict(
                :E => DhGroupElement(N, :E,            "abcdefghijkl", :E),
                :C31 => DhGroupElement(N, :C31,        "cdefabijklgh", :C32),
                :C32 => DhGroupElement(N, :C32,        "efabcdklghij", :C31),
                :σ1 => DhGroupElement(N, :σ1,          "fedcbalkjihg", :σ1),
                :σ2 => DhGroupElement(N, :σ2,          "bafedchglkji", :σ2),
                :σ3 => DhGroupElement(N, :σ3,          "dcbafejihglk", :σ3),
                :σh => DhGroupElement(N, :σh,          "ghijklabcdef", :σh),
                :S31 => DhGroupElement(N, :S31,        "ijklghcdefab", :S32),
                :S32 => DhGroupElement(N, :S32,        "klghijefabcd", :S31),
                :σ1σh => DhGroupElement(N, :σ1σh,      "lkjihgfedcba", :σ1σh),
                :σ2σh => DhGroupElement(N, :σ2σh,      "hglkjibafedc", :σ2σh),
                :σ3σh => DhGroupElement(N, :σ3σh,      "jihglkdcbafe", :σ3σh),
            )
            
        elseif N == 4
            els = LittleDict(
                :E => DhGroupElement(N, :E,            "abcdefghijklmnop", :E),
                :C41 => DhGroupElement(N, :C41,        "cdefghabklmnopij", :C43),
                :C21 => DhGroupElement(N, :C21,        "efghabcdmnopijkl", :C21),
                :C43 => DhGroupElement(N, :C43,        "ghabcdefopijklmn", :C41),
                :σ1 => DhGroupElement(N, :σ1,          "hgfedcbaponmlkji", :σ1),
                :σ2 => DhGroupElement(N, :σ2,          "bahgfedcjiponmlk", :σ2),
                :σ3 => DhGroupElement(N, :σ3,          "dcbahgfelkjiponm", :σ3),
                :σ4 => DhGroupElement(N, :σ4,          "fedcbahgnmlkjipo", :σ4),
                :σh => DhGroupElement(N, :σh,          "ijklmnopabcdefgh", :σh),
                :S41 => DhGroupElement(N, :S41,        "klmnopijcdefghab", :S43),
                :S21 => DhGroupElement(N, :S21,        "mnopijklefghabcd", :S21),
                :S43 => DhGroupElement(N, :S43,        "opijklmnghabcdef", :S41),
                :σ1σh => DhGroupElement(N, :σ1σh,       "ponmlkjihgfedcba", :σ1σh),
                :σ2σh => DhGroupElement(N, :σ2σh,       "jiponmlkbahgfedc", :σ2σh),
                :σ3σh => DhGroupElement(N, :σ3σh,       "lkjiponmdcbahgfe", :σ3σh),
                :σ4σh => DhGroupElement(N, :σ4σh,       "nmlkjipofedcbahg", :σ4σh),
            )
            
        elseif N == 6
            els = LittleDict(
                :E => DhGroupElement(N, :E,            "abcdefghijklmnopqrstuvwx", :E),
                :C61 => DhGroupElement(N, :C61,        "cdefghijklabopqrstuvwxmn", :C65),
                :C31 => DhGroupElement(N, :C21,        "efghijklabcdqrstuvwxmnop", :C32),
                :C21 => DhGroupElement(N, :C21,        "ghijklabcdefstuvwxmnopqr", :C21),
                :C32 => DhGroupElement(N, :C32,        "ijklabcdefghuvwxmnopqrst", :C31),
                :C65 => DhGroupElement(N, :C65,        "klabcdefghijwxmnopqrstuv", :C61),
                :σ1 => DhGroupElement(N, :σ1,          "balkjihgfedcnmxwvutsrqpo", :σ1),
                :σ2 => DhGroupElement(N, :σ2,          "dcbalkjihgfeponmxwvutsrq", :σ2),
                :σ3 => DhGroupElement(N, :σ3,          "fedcbalkjihgrqponmxwvuts", :σ3),
                :σ4 => DhGroupElement(N, :σ4,          "hgfedcbalkjitsrqponmxwvu", :σ4),
                :σ5 => DhGroupElement(N, :σ5,          "jihgfedcbalkvutsrqponmxw", :σ5),
                :σ6 => DhGroupElement(N, :σ6,          "lkjihgfedcbaxwvutsrqponm", :σ6),
                :σh => DhGroupElement(N, :σh,          "mnopqrstuvwxabcdefghijkl", :σh),
                :S61 => DhGroupElement(N, :S61,        "opqrstuvwxmncdefghijklab", :S65),
                :S31 => DhGroupElement(N, :S31,        "qrstuvwxmnopefghijklabcd", :S32),
                :S21 => DhGroupElement(N, :S21,        "stuvwxmnopqrghijklabcdef", :S21),
                :S32 => DhGroupElement(N, :S32,        "uvwxmnopqrstijklabcdefgh", :S31),
                :S65 => DhGroupElement(N, :S65,        "wxmnopqrstuvklabcdefghij", :S61),
                :σ1σh => DhGroupElement(N, :σ1σh,       "nmxwvutsrqpobalkjihgfedc", :σ1σh),
                :σ2σh => DhGroupElement(N, :σ2σh,       "ponmxwvutsrqdcbalkjihgfe", :σ2σh),
                :σ3σh => DhGroupElement(N, :σ3σh,       "rqponmxwvutsfedcbalkjihg", :σ3σh),
                :σ4σh => DhGroupElement(N, :σ4σh,       "tsrqponmxwvuhgfedcbalkji", :σ4σh),
                :σ5σh => DhGroupElement(N, :σ5σh,       "vutsrqponmxwjihgfedcbalk", :σ5σh),
                :σ6σh => DhGroupElement(N, :σ6σh,       "xwvutsrqponmlkjihgfedcba", :σ6σh),
            )
            
        end

        tb = multiplication_table(els)
        return return new{N}(els, "D$(N)h", 4*N, tb)
    end
end

DhGroup(N) = DhGroup{N}()