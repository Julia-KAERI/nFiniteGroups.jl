struct CvBaseGroupElement{N} <: AbstractCBaseGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    
    function CvBaseGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], 2*N)
        end
        return new{N}(sym, mat, inv, CvBaseGroup{N})
    end
end

struct CvBaseGroup{N} <: AbstractCBaseGroup{N}
    elements::LittleDict{Symbol, CvBaseGroupElement{N}}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function CvBaseGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => CvBaseGroupElement(N, :E, "abcd", :E),
                :C21 => CvBaseGroupElement(N, :C21, "cdab", :C21),
                :σ1 => CvBaseGroupElement(N, :σ1, "badc", :σ1),
                :σ2 => CvBaseGroupElement(N, :σ2, "dcba", :σ2),
            )
        elseif N == 3
            els = LittleDict(
                :E => CvBaseGroupElement(N, :E, "abcdef", :E),
                :C31 => CvBaseGroupElement(N, :C31, "cdefab", :C32),
                :C32 => CvBaseGroupElement(N, :C32, "efabcd", :C31),
                :σ1 => CvBaseGroupElement(N, :σ1, "fedcba", :σ1),
                :σ2 => CvBaseGroupElement(N, :σ2, "dcbafe", :σ2),
                :σ3 => CvBaseGroupElement(N, :σ2, "bafedc", :σ3),
            )
        elseif N == 4
            els = LittleDict(
                :E => CvBaseGroupElement(N, :E, "abcdefgh", :E),
                :C41 => CvBaseGroupElement(N, :C41, "cdefghab", :C43),
                :C21 => CvBaseGroupElement(N, :C21, "efghabcd", :C21),
                :C43 => CvBaseGroupElement(N, :C43, "ghabcdef", :C41),
                :σ1 => CvBaseGroupElement(N, :σ1, "hgfedcba", :σ1),
                :σ2 => CvBaseGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :σ1d => CvBaseGroupElement(N, :σ2, "bahgfedc", :σ1d),
                :σ2d => CvBaseGroupElement(N, :σ2, "fedcbahg", :σ2d),
            )
        elseif N == 5
            els = LittleDict(
                :E => CvBaseGroupElement(N, :E,     "abcdefghij", :E),
                :C51 => CvBaseGroupElement(N, :C41, "cdefghijab", :C54),
                :C52 => CvBaseGroupElement(N, :C52, "efghijabcd", :C53),
                :C53 => CvBaseGroupElement(N, :C53, "ghijabcdef", :C52),
                :C54 => CvBaseGroupElement(N, :S54, "ijabcdefgh", :C51),
                :σ1 => CvBaseGroupElement(N, :σ1,   "bajihgfedc", :σ1),
                :σ2 => CvBaseGroupElement(N, :σ2,   "fedcbajihg", :σ2),
                :σ3 => CvBaseGroupElement(N, :σ3,   "jihgfedcba", :σ3),
                :σ4 => CvBaseGroupElement(N, :σ4,   "dcbajihgfe", :σ4),
                :σ5 => CvBaseGroupElement(N, :σ5,   "hgfedcbaji", :σ5),
            )
        elseif N == 6
            els = LittleDict(
                :E => CvBaseGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => CvBaseGroupElement(N, :C61, "cdefghijklab", :C65),
                :C31 => CvBaseGroupElement(N, :C31, "efghijklabcd", :C32),
                :C21 => CvBaseGroupElement(N, :C21, "ghijklabcdef", :C21),
                :C32 => CvBaseGroupElement(N, :C32, "ijklabcdefgh", :C31),
                :C65 => CvBaseGroupElement(N, :C65, "klabcdefghij", :C61),
                :σ1 => CvBaseGroupElement(N, :σ1,   "lkjihgfedcba", :σ1),
                :σ2 => CvBaseGroupElement(N, :σ2,   "dcbalkjihgfe", :σ2),
                :σ3 => CvBaseGroupElement(N, :σ3,   "hgfedcbalkji", :σ3),
                :σ1d => CvBaseGroupElement(N, :σ1d, "balkjihgfedc", :σ1d),
                :σ2d => CvBaseGroupElement(N, :σ2d, "fedcbalkjihg", :σ2d),
                :σ3d => CvBaseGroupElement(N, :σ3d, "jihgfedcbalk", :σ3d),
            ) 
        end

        tb = multiplication_table(els)
        return new{N}(els, Symbol("C$(N)v"), 2*N, tb)
    end
end

CvBaseGroup(N) = CvBaseGroup{N}()
