struct CvGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group 

    
    function CvGroupElement(N::Integer, sym::Symbol, s::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(s) == 2*N
        mat = zeros(Int64, 2*N, 2*N) 
        for i in 1:2*N
            mat[:, i] = char2row(s[i], 2*N)
        end
        return new{N}(sym, mat, inv, CvGroup{N})
    end


end

struct CvGroup{N} <: PointGroup where N
    elements::LittleDict{Symbol, CvGroupElement{N}}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function CvGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => CvGroupElement(N, :E, "abcd", :E),
                :C21 => CvGroupElement(N, :C21, "cdab", :C21),
                :σ1 => CvGroupElement(N, :σ1, "badc", :σ1),
                :σ2 => CvGroupElement(N, :σ2, "dcba", :σ2),
            )
        elseif N == 3
            els = LittleDict(
                :E => CvGroupElement(N, :E, "abcdef", :E),
                :C31 => CvGroupElement(N, :C31, "cdefab", :C32),
                :C32 => CvGroupElement(N, :C32, "efabcd", :C31),
                :σ1 => CvGroupElement(N, :σ1, "fedcba", :σ1),
                :σ2 => CvGroupElement(N, :σ2, "dcbafe", :σ2),
                :σ3 => CvGroupElement(N, :σ2, "bafedc", :σ3),
            )
        elseif N == 4
            els = LittleDict(
                :E => CvGroupElement(N, :E, "abcdefgh", :E),
                :C41 => CvGroupElement(N, :C41, "cdefghab", :C43),
                :C42 => CvGroupElement(N, :C42, "efghabcd", :C42),
                :C43 => CvGroupElement(N, :C43, "ghabcdef", :C41),
                :σ1 => CvGroupElement(N, :σ1, "hgfedcba", :σ1),
                :σ2 => CvGroupElement(N, :σ2, "dcbahgfe", :σ2),
                :σ1d => CvGroupElement(N, :σ2, "bahgfedc", :σ1d),
                :σ2d => CvGroupElement(N, :σ2, "fedcbahg", :σ2d),
            )

        elseif N == 6
            els = LittleDict(
                :E => CvGroupElement(N, :E,     "abcdefghijkl", :E),
                :C61 => CvGroupElement(N, :C61, "cdefghijklab", :C65),
                :C62 => CvGroupElement(N, :C62, "efghijklabcd", :C64),
                :C63 => CvGroupElement(N, :C63, "ghijklabcdef", :C63),
                :C64 => CvGroupElement(N, :C64, "ijklabcdefgh", :C62),
                :C65 => CvGroupElement(N, :C65, "klabcdefghij", :C61),
                :σ1 => CvGroupElement(N, :σ1,   "lkjihgfedcba", :σ1),
                :σ2 => CvGroupElement(N, :σ2,   "dcbalkjihgfe", :σ2),
                :σ3 => CvGroupElement(N, :σ3,   "hgfedcbalkji", :σ3),
                :σ1d => CvGroupElement(N, :σ1d, "balkjihgfedc", :σ1d),
                :σ2d => CvGroupElement(N, :σ2d, "fedcbalkjihg", :σ2d),
                :σ3d => CvGroupElement(N, :σ3d, "jihgfedcbalk", :σ3d),
            ) 
        end

        tb = multiplication_table(els)
        return new{N}(els, "C$(N)v", 2*N, tb)
    end
end

CvGroup(N) = CvGroup{N}()
