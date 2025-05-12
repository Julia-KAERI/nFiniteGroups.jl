# Tetrahedral_symbol = [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2]
# TetrahedralDiagonal_symbol = [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2, :σab, :σac, :σad, :σbc, :σbd, :σcd, :Sx1, :Sx3, :Sy1, :Sy3, :Sz1, :Sz3]
    
struct TetrahedralGroupElement <: AbstractTetrahedralGroupElement   
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group

    function TetrahedralGroupElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing, grp=TetrahedralGroup)
        @assert length(nn) == 4
        @assert all(c -> c in "abcd", nn)
        mat = zeros(Int64, 4, 4) 
        for i in 1:4
            mat[:, i] = char2row(nn[i], 4)
        end
        return new(s, mat, inv, grp)
    end
end

# Base.show(io::IO, t::TetrahedralGroupElement) = print(io, "$(t.sym) [TetrahedralGroupElement] : ", t.rep)


struct TetrahedralGroup<:AbstractTetrahedralGroup
    elements::LittleDict{Symbol, TetrahedralGroupElement}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function TetrahedralGroup()
        els = LittleDict(
        :E => TetrahedralGroupElement(:E, "abcd", :E),
        :C2x => TetrahedralGroupElement(:C2x, "badc", :C2x),
        :C2y => TetrahedralGroupElement(:C2y, "dcba", :C2y), 
        :C2z => TetrahedralGroupElement(:C2z, "cdab", :C2z), 
        :C3a => TetrahedralGroupElement(:C3a, "adbc", :C3a2),
        :C3a2 => TetrahedralGroupElement(:C3a2, "acdb", :C3a),
        :C3b => TetrahedralGroupElement(:C3b, "cbda", :C3b2),
        :C3b2 => TetrahedralGroupElement(:C3b2, "dbac", :C3b),
        :C3c => TetrahedralGroupElement(:C3c, "dacb", :C3c2),
        :C3c2 => TetrahedralGroupElement(:C3c2, "bdca", :C3c),
        :C3d => TetrahedralGroupElement(:C3d, "bcad", :C3d2),
        :C3d2 => TetrahedralGroupElement(:C3d2, "cabd", :C3d)
        )
        tb = multiplication_table(els)
        return new(els, "T", 12, tb)
    end
end

struct TetrahedralGroupClass <: AbstractTetrahedralGroupClass
end

struct TetrahedralDiagonalGroup <: AbstractTetrahedralGroup
    elements::Dict{Symbol, TetrahedralGroupElement}
    rep::String
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function TetrahedralDiagonalGroup()
        els = LittleDict(
        :E => TetrahedralGroupElement(:E, "abcd", :E, TetrahedralDiagonalGroup),
        :C2x => TetrahedralGroupElement(:C2x, "badc", :C2x, TetrahedralDiagonalGroup),
        :C2y => TetrahedralGroupElement(:C2y, "dcba", :C2y, TetrahedralDiagonalGroup), 
        :C2z => TetrahedralGroupElement(:C2z, "cdab", :C2z, TetrahedralDiagonalGroup), 
        :C3a => TetrahedralGroupElement(:C3a, "adbc", :C3a2, TetrahedralDiagonalGroup),
        :C3a2 => TetrahedralGroupElement(:C3a2, "acdb", :C3a, TetrahedralDiagonalGroup),
        :C3b => TetrahedralGroupElement(:C3b, "cbda", :C3b2, TetrahedralDiagonalGroup),
        :C3b2 => TetrahedralGroupElement(:C3b2, "dbac", :C3b, TetrahedralDiagonalGroup),
        :C3c => TetrahedralGroupElement(:C3c, "dacb", :C3c2, TetrahedralDiagonalGroup),
        :C3c2 => TetrahedralGroupElement(:C3c2, "bdca", :C3c, TetrahedralDiagonalGroup),
        :C3d => TetrahedralGroupElement(:C3d, "bcad", :C3d2, TetrahedralDiagonalGroup),
        :C3d2 => TetrahedralGroupElement(:C3d2, "cabd", :C3d, TetrahedralDiagonalGroup),
        :σab => TetrahedralGroupElement(:σab, "abdc", :σab, TetrahedralDiagonalGroup),
        :σac => TetrahedralGroupElement(:σac, "adcb", :σac, TetrahedralDiagonalGroup),
        :σad => TetrahedralGroupElement(:σad, "acbd", :σad, TetrahedralDiagonalGroup),
        :σbc => TetrahedralGroupElement(:σbc, "dbca", :σbc, TetrahedralDiagonalGroup),
        :σbd => TetrahedralGroupElement(:σbd, "cbad", :σbd, TetrahedralDiagonalGroup),
        :σcd => TetrahedralGroupElement(:σcd, "bacd", :σcd, TetrahedralDiagonalGroup),
        :Sx1 => TetrahedralGroupElement(:Sx1, "cdba", :Sx3, TetrahedralDiagonalGroup),
        :Sx3 => TetrahedralGroupElement(:Sx3, "dcab", :Sx1, TetrahedralDiagonalGroup),
        :Sy1 => TetrahedralGroupElement(:Sy1, "cadb", :Sy3, TetrahedralDiagonalGroup),
        :Sy3 => TetrahedralGroupElement(:Sy3, "bdac", :Sy1, TetrahedralDiagonalGroup),
        :Sz1 => TetrahedralGroupElement(:Sz1, "dabc", :Sz3, TetrahedralDiagonalGroup),
        :Sz3 => TetrahedralGroupElement(:Sz3, "bcda", :Sz1, TetrahedralDiagonalGroup),
        )
        tb = multiplication_table(els)
        return new(els, "Td", 24, tb)
    end
end


# elements(t::TetrahedralGroup) = Tetrahedral_symbol 
# elements(t::TetrahedralDiagonalGroup) = TetrahedralDiagonal_symbol

# function Base.show(io::IO, t::AbstractTetrahedralGroup) 
#     print(io, "$(t.rep) ", t.elements)
# end

# Base.:*(a::T, b::T) where T<:PointGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)