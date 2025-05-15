struct ChBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    
    function ChBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], 2*N)
        end 
        return new{N}(sym, mat, inv, ChBaseGroup{N})
    end

end

struct ChBaseGroup{N} <: AbstractCBaseGroup{N}
    elements::LittleDict{Symbol, ChBaseGroupElement{N}}
    sym::Symbol
    order::Integer   
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}
    function ChBaseGroup{N}() where N
        
        if N==1
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E, "ab", :E),
                :σh => ChBaseGroupElement(N, :σh, "ba", :σh),
            )
            
        elseif N == 2
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E, "abcd", :E),
                :C21 => ChBaseGroupElement(N, :C21, "badc", :C21),
                :σh => ChBaseGroupElement(N, :σh, "cdab", :σh),
                :i => ChBaseGroupElement(N, :i, "dcba", :i),
            )
        elseif N == 3
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E, "abcdef", :E),
                :C31 => ChBaseGroupElement(N, :C31, "bcaefd", :C32),
                :C32 => ChBaseGroupElement(N, :C32, "cabfde", :C31),
                :σh => ChBaseGroupElement(N, :σh, "defabc", :σh),
                :S3 => ChBaseGroupElement(N, :S3, "efdbca", :σhC32),
                :σhC32 => ChBaseGroupElement(N, :σhC32, "fdecab", :S3),
            )

        elseif N == 4
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E,     "abcdefgh", :E),
                :C41 => ChBaseGroupElement(N, :C41, "bcdafghe", :C43),
                :C21 => ChBaseGroupElement(N, :C21, "cdabghef", :C21),
                :C43 => ChBaseGroupElement(N, :C43, "dabchefg", :C41),
                :σh => ChBaseGroupElement(N, :σh,   "efghabcd", :σh),
                :S41 => ChBaseGroupElement(N, :S41, "fghebcda", :S43),
                :i => ChBaseGroupElement(N, :i,     "ghefcdab", :i),
                :S43 => ChBaseGroupElement(N, :S43, "hefgdabc", :S41),
            )
        elseif N == 5
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E,     "abcdefghij", :E),
                :C51 => ChBaseGroupElement(N, :C51, "bcdeaghijf", :C54),
                :C52 => ChBaseGroupElement(N, :C52, "cdeabhijfg", :C53),
                :C53 => ChBaseGroupElement(N, :C53, "deabcijfgh", :C52),
                :C54 => ChBaseGroupElement(N, :C54, "eabcdjfghi", :C51),
                :σh => ChBaseGroupElement(N, :σh,   "fghijabcde", :σh),
                :S51 => ChBaseGroupElement(N, :S51, "ghijfbcdea", :S54),
                :S52 => ChBaseGroupElement(N, :S52, "hijfgcdeab", :S53),
                :S53 => ChBaseGroupElement(N, :S53, "ijfghdeabc", :S52),
                :S54 => ChBaseGroupElement(N, :S54, "jfghieabcd", :S51),
            )
        elseif N == 6
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => ChBaseGroupElement(N, :C61, "bcdefahijklg", :C65),
                :C31 => ChBaseGroupElement(N, :C31, "cdefabijklgh", :C32),
                :C21 => ChBaseGroupElement(N, :C21, "defabcjklghi", :C21),
                :C32 => ChBaseGroupElement(N, :C32, "efabcdklghij", :C31),
                :C65 => ChBaseGroupElement(N, :C65, "fabcdelghijk", :C61),
                :σh => ChBaseGroupElement(N, :σh,   "ghijklabcdef", :σh),
                :S61 => ChBaseGroupElement(N, :S61, "hijklgbcdefa", :S65),
                :S31 => ChBaseGroupElement(N, :S31, "ijklghcdefab", :S32),
                :i => ChBaseGroupElement(N, :i,     "jklghidefabc", :i),
                :S32 => ChBaseGroupElement(N, :S32, "klghijefabcd", :S31),
                :S65 => ChBaseGroupElement(N, :S65, "lghijkfabcde", :S61),
            )
        end

        tb = multiplication_table(els)
        return new{N}(els, Symbol("C$(N)h"), 2*N, tb)            

    end
end

ChBaseGroup(N) = ChBaseGroup{N}()

