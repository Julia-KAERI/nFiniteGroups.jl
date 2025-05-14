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
                :E => ChBaseGroupElement(N, :E, "abcdefgh", :E),
                :C41 => ChBaseGroupElement(N, :C41, "cdefghab", :C43),
                :C21 => ChBaseGroupElement(N, :C21, "efghabcd", :C21),
                :C43 => ChBaseGroupElement(N, :C43, "ghabcdef", :C41),
                :σ1 => ChBaseGroupElement(N, :σ1, "hgfedcba", :σ1),
                :σ2 => ChBaseGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :σ1d => ChBaseGroupElement(N, :σ2, "bahgfedc", :σ1d),
                :σ2d => ChBaseGroupElement(N, :σ2, "fedcbahg", :σ2d),
            )

        elseif N == 6
            els = LittleDict(
                :E => ChBaseGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => ChBaseGroupElement(N, :C61, "cdefghijklab", :C65),
                :C31 => ChBaseGroupElement(N, :C31, "efghijklabcd", :C32),
                :C21 => ChBaseGroupElement(N, :C21, "ghijklabcdef", :C21),
                :C32 => ChBaseGroupElement(N, :C32, "ijklabcdefgh", :C31),
                :C65 => ChBaseGroupElement(N, :C65, "klabcdefghij", :C61),
                :σ1 => ChBaseGroupElement(N, :σ1,   "lkjihgfedcba", :σ1),
                :σ2 => ChBaseGroupElement(N, :σ2,   "dcbalkjihgfe", :σ2),
                :σ3 => ChBaseGroupElement(N, :σ3,   "hgfedcbalkji", :σ3),
                :σ1d => ChBaseGroupElement(N, :σ1d, "balkjihgfedc", :σ1d),
                :σ2d => ChBaseGroupElement(N, :σ2d, "fedcbalkjihg", :σ2d),
                :σ3d => ChBaseGroupElement(N, :σ3d, "jihgfedcbalk", :σ3d),
            )
        end

        tb = multiplication_table(els)
        return new{N}(els, Symbol("C$(N)h"), 2*N, tb)            

    end
end

ChBaseGroup(N) = ChBaseGroup{N}()

