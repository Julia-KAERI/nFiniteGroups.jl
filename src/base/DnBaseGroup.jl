struct DBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    function DBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], 2*N)
        end
 
        return new{N}(sym, mat, inv, DBaseGroup{N})
    end
end

struct DBaseGroup{N} <: AbstractCBaseGroup{N}
    elements::LittleDict{Symbol, DBaseGroupElement{N}}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}   
    function DBaseGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => DBaseGroupElement(N, :E, "abcd", :E),
                :C21 => DBaseGroupElement(N, :C21, "cdab", :C21),
                :d1 => DBaseGroupElement(N, :d1, "badc", :d1),
                :d2 => DBaseGroupElement(N, :d2, "dcba", :d2),
            )
        
        elseif N == 3
            els = LittleDict(
                :E => DBaseGroupElement(N, :E, "abcdef", :E),
                :C31 => DBaseGroupElement(N, :C31, "bcaefd", :C32),
                :C32 => DBaseGroupElement(N, :C32, "cabfde", :C31),
                :d1 => DBaseGroupElement(N, :d1, "dfeacb", :d1),
                :d2 => DBaseGroupElement(N, :d2, "edfbac", :d2),
                :d3 => DBaseGroupElement(N, :d3, "fedcba", :d3),
            )

        elseif N == 4
            els = LittleDict(
                :E => DBaseGroupElement(N, :E, "abcdefgh", :E),
                :C41 => DBaseGroupElement(N, :C41, "bcdafghe", :C43),
                :C2 => DBaseGroupElement(N, :C2, "cdabghef", :C2),
                :C43 => DBaseGroupElement(N, :C43, "dabchefg", :C41),
                :d1 => DBaseGroupElement(N, :d1, "ehgfadcb", :d1),
                :d2 => DBaseGroupElement(N, :d2, "fehgbadc", :d2),
                :d3 => DBaseGroupElement(N, :d3, "gfehcbad", :d3),
                :d4 => DBaseGroupElement(N, :d4, "hgfedcba", :d4),
            )

        elseif N == 5
            els = LittleDict(
                :E => DBaseGroupElement(N, :E,     "abcdefghij", :E),
                :C51 => DBaseGroupElement(N, :C51, "bcdeaghijf", :C54),
                :C52 => DBaseGroupElement(N, :C52, "cdeabhijfg", :C53),
                :C53 => DBaseGroupElement(N, :C53, "deabcijfgh", :C52),
                :C54 => DBaseGroupElement(N, :C54, "eabcdjfghi", :C51),
                :d1 => DBaseGroupElement(N, :d1,    "fjihgaedcb", :d1),
                :d2 => DBaseGroupElement(N, :d2,    "gfjihbaedc", :d2),
                :d3 => DBaseGroupElement(N, :d3,    "hgfjicbaed", :d3),
                :d4 => DBaseGroupElement(N, :d4,    "ihgfjdcbae", :d4),
                :d5 => DBaseGroupElement(N, :d5,    "jihgfedcba", :d5),
            )
    
        elseif N == 6
            els = LittleDict(
                :E => DBaseGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => DBaseGroupElement(N, :C61, "bcdefahijklg", :C65),
                :C31 => DBaseGroupElement(N, :C31, "cdefabijklgh", :C32),
                :C21 => DBaseGroupElement(N, :C21, "defabcjklghi", :C21),
                :C32 => DBaseGroupElement(N, :C32, "efabcdklghij", :C31),
                :C65 => DBaseGroupElement(N, :C65, "fabcdelghijk", :C61),
                :d1 => DBaseGroupElement(N, :d1,   "glkjihafedcb", :d1),
                :d2 => DBaseGroupElement(N, :d2,   "hglkjibafedc", :d2),
                :d3 => DBaseGroupElement(N, :d3,   "ihglkjcbafed", :d3),
                :d4 => DBaseGroupElement(N, :d4,   "jihglkdcbafe", :d4),
                :d5 => DBaseGroupElement(N, :d5,   "kjihgledcbaf", :d5),
                :d6 => DBaseGroupElement(N, :d6,   "lkjihgfedcba", :d6),
            )
        end
        table = multiplication_table(els)
        return new{N}(els, Symbol("D$N"), 2*N, table)

    end
end

DBaseGroup(N) = DBaseGroup{N}()

struct DdBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

   
    function DdBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 4*N
        mat = zeros(Int64, 4*N, 4*N) 
        for i in 1:4*N
            mat[:, i] = char2row(s[i], 4*N)
        end
 
        return new{N}(sym, mat, inv, DdBaseGroup{N})
    end


end

struct DdBaseGroup{N} <: AbstractCBaseGroup{N}
    elements::LittleDict{Symbol, DdBaseGroupElement{N}}
    sym::Symbol
    order::Integer 
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  

    function DdBaseGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => DdBaseGroupElement(N, :E, "abcdefgh", :E),
                :C21 => DdBaseGroupElement(N, :C21, "cdabghef", :C21),
                :d1 => DdBaseGroupElement(N, :d1, "ehgfadcb", :d1),
                :d2 => DdBaseGroupElement(N, :d2, "gfehcbad", :d2),
                :σ1 => DdBaseGroupElement(N, :σ1, "badcfehg", :σ1), 
                :σ2 => DdBaseGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :S41 => DdBaseGroupElement(N, :S41, "fghebcda", :S43),
                :S43 => DdBaseGroupElement(N, :S43, "hefgdabc", :S41),
            )

        elseif N == 3
            els = LittleDict(
                :E => DdBaseGroupElement(N, :E,        "abcdefghijkl", :E),
                :C31 => DdBaseGroupElement(N, :C31,    "cdefabijklgh", :C32),
                :C32 => DdBaseGroupElement(N, :C32,    "efabcdklghij", :C31),
                :d1 => DdBaseGroupElement(N, :d1,      "hglkjibafedc", :d1),
                :d2 => DdBaseGroupElement(N, :d2,      "jihglkdcbafe", :d2),
                :d3 => DdBaseGroupElement(N, :d3,      "lkjihgfedcba", :d3),
                :σ1 => DdBaseGroupElement(N, :σ1,      "bafedclkjihg", :σ1),
                :σ2 => DdBaseGroupElement(N, :σ2,      "dcbafehglkji", :σ2),
                :σ3 => DdBaseGroupElement(N, :σ3,      "fedcbajihglk", :σ3),
                :S61 => DdBaseGroupElement(N, :S61,    "ghijklcdefab", :S65),
                :S63 => DdBaseGroupElement(N, :S63,    "ijklghefabcd", :S63),
                :S65 => DdBaseGroupElement(N, :S65,    "klghijabcdef", :S61),
            )
        
        end

        table = multiplication_table(els)
        return  new{N}(els, Symbol("D$(N)d"), 4*N, table)
    end
end

DdBaseGroup(N) = DdBaseGroup{N}()


struct DhBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 
    
    function DhBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 4*N
        mat = zeros(Int64, 4*N, 4*N) 
        for i in 1:4*N
            mat[:, i] = char2row(s[i], 4*N)
        end 
        return new{N}(sym, mat, inv, DhBaseGroup{N})
    end
end

struct DhBaseGroup{N} <: AbstractCBaseGroup{N}
    elements::LittleDict{Symbol, DhBaseGroupElement{N}}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function DhBaseGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => DhBaseGroupElement(N, :E, "abcdefgh", :E),
                :C21 => DhBaseGroupElement(N, :C21, "cdabghef", :C21),
                :σ1 => DhBaseGroupElement(N, :σ1, "dcbahgfe", :σ1),
                :σ2 => DhBaseGroupElement(N, :σ2, "badcfehg", :σ2),
                :σh => DhBaseGroupElement(N, :σh, "efghabcd", :σh), 
                :i => DhBaseGroupElement(N, :i, "ghefcdab", :i),
                :σ1i => DhBaseGroupElement(N, :σ1i, "fehgbadc", :σ1i),
                :σ2i => DhBaseGroupElement(N, :σ2i, "hgfedcba", :σ2i),

            )
            
        elseif N == 3
            els = LittleDict(
                :E => DhBaseGroupElement(N, :E,            "abcdefghijkl", :E),
                :C31 => DhBaseGroupElement(N, :C31,        "cdefabijklgh", :C32),
                :C32 => DhBaseGroupElement(N, :C32,        "efabcdklghij", :C31),
                :σ1 => DhBaseGroupElement(N, :σ1,          "fedcbalkjihg", :σ1),
                :σ2 => DhBaseGroupElement(N, :σ2,          "bafedchglkji", :σ2),
                :σ3 => DhBaseGroupElement(N, :σ3,          "dcbafejihglk", :σ3),
                :σh => DhBaseGroupElement(N, :σh,          "ghijklabcdef", :σh),
                :S31 => DhBaseGroupElement(N, :S31,        "ijklghcdefab", :S32),
                :S32 => DhBaseGroupElement(N, :S32,        "klghijefabcd", :S31),
                :σ1σh => DhBaseGroupElement(N, :σ1σh,      "lkjihgfedcba", :σ1σh),
                :σ2σh => DhBaseGroupElement(N, :σ2σh,      "hglkjibafedc", :σ2σh),
                :σ3σh => DhBaseGroupElement(N, :σ3σh,      "jihglkdcbafe", :σ3σh),
            )
            
        elseif N == 4
            els = LittleDict(
                :E => DhBaseGroupElement(N, :E,            "abcdefghijklmnop", :E),
                :C41 => DhBaseGroupElement(N, :C41,        "cdefghabklmnopij", :C43),
                :C21 => DhBaseGroupElement(N, :C21,        "efghabcdmnopijkl", :C21),
                :C43 => DhBaseGroupElement(N, :C43,        "ghabcdefopijklmn", :C41),
                :σ1 => DhBaseGroupElement(N, :σ1,          "hgfedcbaponmlkji", :σ1),
                :σ2 => DhBaseGroupElement(N, :σ2,          "bahgfedcjiponmlk", :σ2),
                :σ3 => DhBaseGroupElement(N, :σ3,          "dcbahgfelkjiponm", :σ3),
                :σ4 => DhBaseGroupElement(N, :σ4,          "fedcbahgnmlkjipo", :σ4),
                :σh => DhBaseGroupElement(N, :σh,          "ijklmnopabcdefgh", :σh),
                :S41 => DhBaseGroupElement(N, :S41,        "klmnopijcdefghab", :S43),
                :S21 => DhBaseGroupElement(N, :S21,        "mnopijklefghabcd", :S21),
                :S43 => DhBaseGroupElement(N, :S43,        "opijklmnghabcdef", :S41),
                :σ1σh => DhBaseGroupElement(N, :σ1σh,       "ponmlkjihgfedcba", :σ1σh),
                :σ2σh => DhBaseGroupElement(N, :σ2σh,       "jiponmlkbahgfedc", :σ2σh),
                :σ3σh => DhBaseGroupElement(N, :σ3σh,       "lkjiponmdcbahgfe", :σ3σh),
                :σ4σh => DhBaseGroupElement(N, :σ4σh,       "nmlkjipofedcbahg", :σ4σh),
            )
        elseif N == 5
            els = LittleDict(
                :E => DhBaseGroupElement(N, :E,            "abcdefghijklmnopqrst", :E),
                :C51 => DhBaseGroupElement(N, :C51,        "cdefghijabmnopqrstkl", :C54),
                :C52 => DhBaseGroupElement(N, :C52,        "efghijabcdopqrstklmn", :C53),
                :C53 => DhBaseGroupElement(N, :C53,        "ghijabcdefqrstklmnop", :C52),
                :C54 => DhBaseGroupElement(N, :C54,        "ijabcdefghstklmnopqr", :C51),
                :σ1 => DhBaseGroupElement(N, :σ1,          "jihgfedcbatsrqponmlk", :σ1),
                :σ2 => DhBaseGroupElement(N, :σ2,          "bajihgfedclktsrqponm", :σ2),
                :σ3 => DhBaseGroupElement(N, :σ3,          "dcbajihgfenmlktsrqpo", :σ3),
                :σ4 => DhBaseGroupElement(N, :σ4,          "fedcbajihgponmlktsrq", :σ4),
                :σ5 => DhBaseGroupElement(N, :σ5,          "hgfedcbajirqponmlkts", :σ5),
                :σh => DhBaseGroupElement(N, :σh,          "klmnopqrstabcdefghij", :σh),
                :S51 => DhBaseGroupElement(N, :S51,        "mnopqrstklcdefghijab", :S54),
                :S52 => DhBaseGroupElement(N, :S52,        "opqrstklmnefghijabcd", :S53),
                :S53 => DhBaseGroupElement(N, :S53,        "qrstklmnopghijabcdef", :S52),
                :S54 => DhBaseGroupElement(N, :S54,        "stklmnopqrijabcdefgh", :S51),
                :σ1σh => DhBaseGroupElement(N, :σ1σh,       "tsrqponmlkjihgfedcba", :σ1σh),
                :σ2σh => DhBaseGroupElement(N, :σ2σh,       "lktsrqponmbajihgfedc", :σ2σh),
                :σ3σh => DhBaseGroupElement(N, :σ3σh,       "nmlktsrqpodcbajihgfe", :σ3σh),
                :σ4σh => DhBaseGroupElement(N, :σ4σh,       "ponmlktsrqfedcbajihg", :σ4σh),
                :σ5σh => DhBaseGroupElement(N, :σ5σh,       "rqponmlktshgfedcbaji", :σ5σh),
            )
        elseif N == 6
            els = LittleDict(
                :E => DhBaseGroupElement(N, :E,            "abcdefghijklmnopqrstuvwx", :E),
                :C61 => DhBaseGroupElement(N, :C61,        "cdefghijklabopqrstuvwxmn", :C65),
                :C31 => DhBaseGroupElement(N, :C31,        "efghijklabcdqrstuvwxmnop", :C32),
                :C21 => DhBaseGroupElement(N, :C21,        "ghijklabcdefstuvwxmnopqr", :C21),
                :C32 => DhBaseGroupElement(N, :C32,        "ijklabcdefghuvwxmnopqrst", :C31),
                :C65 => DhBaseGroupElement(N, :C65,        "klabcdefghijwxmnopqrstuv", :C61),
                :σ1 => DhBaseGroupElement(N, :σ1,          "balkjihgfedcnmxwvutsrqpo", :σ1),
                :σ2 => DhBaseGroupElement(N, :σ2,          "dcbalkjihgfeponmxwvutsrq", :σ2),
                :σ3 => DhBaseGroupElement(N, :σ3,          "fedcbalkjihgrqponmxwvuts", :σ3),
                :σ4 => DhBaseGroupElement(N, :σ4,          "hgfedcbalkjitsrqponmxwvu", :σ4),
                :σ5 => DhBaseGroupElement(N, :σ5,          "jihgfedcbalkvutsrqponmxw", :σ5),
                :σ6 => DhBaseGroupElement(N, :σ6,          "lkjihgfedcbaxwvutsrqponm", :σ6),
                :σh => DhBaseGroupElement(N, :σh,          "mnopqrstuvwxabcdefghijkl", :σh),
                :S61 => DhBaseGroupElement(N, :S61,        "opqrstuvwxmncdefghijklab", :S65),
                :S31 => DhBaseGroupElement(N, :S31,        "qrstuvwxmnopefghijklabcd", :S32),
                :S21 => DhBaseGroupElement(N, :S21,        "stuvwxmnopqrghijklabcdef", :S21),
                :S32 => DhBaseGroupElement(N, :S32,        "uvwxmnopqrstijklabcdefgh", :S31),
                :S65 => DhBaseGroupElement(N, :S65,        "wxmnopqrstuvklabcdefghij", :S61),
                :σ1σh => DhBaseGroupElement(N, :σ1σh,       "nmxwvutsrqpobalkjihgfedc", :σ1σh),
                :σ2σh => DhBaseGroupElement(N, :σ2σh,       "ponmxwvutsrqdcbalkjihgfe", :σ2σh),
                :σ3σh => DhBaseGroupElement(N, :σ3σh,       "rqponmxwvutsfedcbalkjihg", :σ3σh),
                :σ4σh => DhBaseGroupElement(N, :σ4σh,       "tsrqponmxwvuhgfedcbalkji", :σ4σh),
                :σ5σh => DhBaseGroupElement(N, :σ5σh,       "vutsrqponmxwjihgfedcbalk", :σ5σh),
                :σ6σh => DhBaseGroupElement(N, :σ6σh,       "xwvutsrqponmlkjihgfedcba", :σ6σh),
            )
            
        end

        tb = multiplication_table(els)
        return return new{N}(els, Symbol("D$(N)h"), 4*N, tb)
    end
end

DhBaseGroup(N) = DhBaseGroup{N}()