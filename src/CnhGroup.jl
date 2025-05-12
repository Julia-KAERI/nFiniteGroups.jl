struct ChGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    
    function ChGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], 2*N)
        end 
        return new{N}(sym, mat, inv, ChGroup{N})
    end

end

struct ChGroup{N} <: PointGroup where N
    elements::LittleDict{Symbol, ChGroupElement{N}}
    rep::String
    order::Integer   
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}
    function ChGroup{N}() where N
        
        if N==1
            els = LittleDict(
                :E => ChGroupElement(N, :E, "ab", :E),
                :σh => ChGroupElement(N, :σh, "ba", :σh),
            )
            
        elseif N == 2
            els = LittleDict(
                :E => ChGroupElement(N, :E, "abcd", :E),
                :C21 => ChGroupElement(N, :C21, "badc", :C21),
                :σh => ChGroupElement(N, :σh, "cdab", :σh),
                :i => ChGroupElement(N, :i, "dcba", :i),
            )
        elseif N == 3
            els = LittleDict(
                :E => ChGroupElement(N, :E, "abcdef", :E),
                :C31 => ChGroupElement(N, :C31, "bcaefd", :C32),
                :C32 => ChGroupElement(N, :C32, "cabfde", :C31),
                :σh => ChGroupElement(N, :σh, "defabc", :σh),
                :S3 => ChGroupElement(N, :S3, "efdbca", :σhC32),
                :σhC32 => ChGroupElement(N, :σhC32, "fdecab", :S3),
            )

        elseif N == 4
            els = LittleDict(
                :E => ChGroupElement(N, :E, "abcdefgh", :E),
                :C41 => ChGroupElement(N, :C41, "cdefghab", :C43),
                :C21 => ChGroupElement(N, :C21, "efghabcd", :C21),
                :C43 => ChGroupElement(N, :C43, "ghabcdef", :C41),
                :σ1 => ChGroupElement(N, :σ1, "hgfedcba", :σ1),
                :σ2 => ChGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :σ1d => ChGroupElement(N, :σ2, "bahgfedc", :σ1d),
                :σ2d => ChGroupElement(N, :σ2, "fedcbahg", :σ2d),
            )

        elseif N == 6
            els = LittleDict(
                :E => ChGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => ChGroupElement(N, :C61, "cdefghijklab", :C65),
                :C31 => ChGroupElement(N, :C31, "efghijklabcd", :C32),
                :C21 => ChGroupElement(N, :C21, "ghijklabcdef", :C21),
                :C32 => ChGroupElement(N, :C32, "ijklabcdefgh", :C31),
                :C65 => ChGroupElement(N, :C65, "klabcdefghij", :C61),
                :σ1 => ChGroupElement(N, :σ1,   "lkjihgfedcba", :σ1),
                :σ2 => ChGroupElement(N, :σ2,   "dcbalkjihgfe", :σ2),
                :σ3 => ChGroupElement(N, :σ3,   "hgfedcbalkji", :σ3),
                :σ1d => ChGroupElement(N, :σ1d, "balkjihgfedc", :σ1d),
                :σ2d => ChGroupElement(N, :σ2d, "fedcbalkjihg", :σ2d),
                :σ3d => ChGroupElement(N, :σ3d, "jihgfedcbalk", :σ3d),
            )
        end

        tb = multiplication_table(els)
        return new{N}(els, "C$N", 2*N, tb)            

    end
end

ChGroup(N) = ChGroup{N}()

