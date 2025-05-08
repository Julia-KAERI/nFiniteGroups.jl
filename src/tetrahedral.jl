Tetrahedral_symbol = [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2]
TetrahedralDiagonal_symbol = [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2,
    :σab, :σac, :σad, :σbc, :σbd, :σcd,
    :Sx1, :Sx3,
    :Sy1, :Sy3,
    :Sz1, :Sz3]
    
struct TetrahedralElement <: AbstractTetrahedralGroupElement   
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group
    function char2tet(c::Char)
        if c== 'a'
            return [1 0 0 0]
        elseif c== 'b'
            return [0 1 0 0]
        elseif c== 'c' 
            return [0 0 1 0]
        elseif c== 'd'
            return [0 0 0 1]
        else
            throw(ArgumentError("Invalid character: $c"))
        end
    end
    function TetrahedralElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing, grp=TetrahedralGroup)
        @assert length(nn) == 4
        @assert all(c -> c in "abcd", nn)
        mat = zeros(Int64, 4, 4) 
        for i in 1:4
            mat[:, i] = char2tet(nn[i])
        end
        return new(s, mat, inv, grp)
    end
end

Base.show(io::IO, t::TetrahedralElement) = print(io, "$(t.sym) [TetrahedralElement] : ", t.rep)


struct TetrahedralGroup<:AbstractTetrahedralGroup
    elements::Dict{Symbol, TetrahedralElement}
    function TetrahedralGroup()
        els = Dict(
        :E => TetrahedralElement(:E, "abcd", :E),
        :C2x => TetrahedralElement(:C2x, "badc", :C2x),
        :C2y => TetrahedralElement(:C2y, "dcba", :C2y), 
        :C2z => TetrahedralElement(:C2z, "cdab", :C2z), 
        :C3a => TetrahedralElement(:C3a, "adbc", :C3a2),
        :C3a2 => TetrahedralElement(:C3a2, "acdb", :C3a),
        :C3b => TetrahedralElement(:C3b, "cbda", :C3b2),
        :C3b2 => TetrahedralElement(:C3b2, "dbac", :C3b),
        :C3c => TetrahedralElement(:C3c, "dacb", :C3c2),
        :C3c2 => TetrahedralElement(:C3c2, "bdca", :C3c),
        :C3d => TetrahedralElement(:C3d, "bcad", :C3d2),
        :C3d2 => TetrahedralElement(:C3d2, "cabd", :C3d)
        )
        return new(els)
    end
end


struct TetrahedralDiagonalGroup <: AbstractTetrahedralGroup
    elements::Dict{Symbol, TetrahedralElement}
    function TetrahedralDiagonalGroup()
        els = Dict(
        :E => TetrahedralElement(:E, "abcd", :E, TetrahedralDiagonalGroup),
        :C2x => TetrahedralElement(:C2x, "badc", :C2x, TetrahedralDiagonalGroup),
        :C2y => TetrahedralElement(:C2y, "dcba", :C2y, TetrahedralDiagonalGroup), 
        :C2z => TetrahedralElement(:C2z, "cdab", :C2z, TetrahedralDiagonalGroup), 
        :C3a => TetrahedralElement(:C3a, "adbc", :C3a2, TetrahedralDiagonalGroup),
        :C3a2 => TetrahedralElement(:C3a2, "acdb", :C3a, TetrahedralDiagonalGroup),
        :C3b => TetrahedralElement(:C3b, "cbda", :C3b2, TetrahedralDiagonalGroup),
        :C3b2 => TetrahedralElement(:C3b2, "dbac", :C3b, TetrahedralDiagonalGroup),
        :C3c => TetrahedralElement(:C3c, "dacb", :C3c2, TetrahedralDiagonalGroup),
        :C3c2 => TetrahedralElement(:C3c2, "bdca", :C3c, TetrahedralDiagonalGroup),
        :C3d => TetrahedralElement(:C3d, "bcad", :C3d2, TetrahedralDiagonalGroup),
        :C3d2 => TetrahedralElement(:C3d2, "cabd", :C3d, TetrahedralDiagonalGroup),
        :σab => TetrahedralElement(:σab, "abdc", :σab, TetrahedralDiagonalGroup),
        :σac => TetrahedralElement(:σac, "adcb", :σac, TetrahedralDiagonalGroup),
        :σad => TetrahedralElement(:σad, "acbd", :σad, TetrahedralDiagonalGroup),
        :σbc => TetrahedralElement(:σbc, "dbca", :σbc, TetrahedralDiagonalGroup),
        :σbd => TetrahedralElement(:σbd, "cbad", :σbd, TetrahedralDiagonalGroup),
        :σcd => TetrahedralElement(:σcd, "bacd", :σcd, TetrahedralDiagonalGroup),
        :Sx1 => TetrahedralElement(:Sx1, "cdba", :Sx3, TetrahedralDiagonalGroup),
        :Sx3 => TetrahedralElement(:Sx3, "dcab", :Sx1, TetrahedralDiagonalGroup),
        :Sy1 => TetrahedralElement(:Sy1, "cadb", :Sy3, TetrahedralDiagonalGroup),
        :Sy3 => TetrahedralElement(:Sy3, "bdac", :Sy1, TetrahedralDiagonalGroup),
        :Sz1 => TetrahedralElement(:Sz1, "dabc", :Sz3, TetrahedralDiagonalGroup),
        :Sz3 => TetrahedralElement(:Sz3, "bcda", :Sz1, TetrahedralDiagonalGroup),
        )
        return new(els)
    end
end

