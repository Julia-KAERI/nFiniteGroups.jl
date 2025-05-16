struct TetrahedralBaseGroupElement <: BaseGroupElement
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group

    function TetrahedralBaseGroupElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing, grp=TetrahedralBaseGroup)
        @assert length(nn) == 4
        @assert all(c -> c in "abcd", nn)
        mat = zeros(Int64, 4, 4) 
        for i in 1:4
            mat[:, i] = char2row(nn[i], 4)
        end
        return new(s, mat, inv, grp)
    end
end

struct TetrahedralBaseGroup<:BaseGroup
    elements::LittleDict{Symbol, TetrahedralBaseGroupElement}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function TetrahedralBaseGroup()
        els = LittleDict(
        :E => TetrahedralBaseGroupElement(:E, "abcd", :E),
        :C2x => TetrahedralBaseGroupElement(:C2x, "badc", :C2x),
        :C2y => TetrahedralBaseGroupElement(:C2y, "dcba", :C2y), 
        :C2z => TetrahedralBaseGroupElement(:C2z, "cdab", :C2z), 
        :C3a => TetrahedralBaseGroupElement(:C3a, "adbc", :C3a2),
        :C3a2 => TetrahedralBaseGroupElement(:C3a2, "acdb", :C3a),
        :C3b => TetrahedralBaseGroupElement(:C3b, "cbda", :C3b2),
        :C3b2 => TetrahedralBaseGroupElement(:C3b2, "dbac", :C3b),
        :C3c => TetrahedralBaseGroupElement(:C3c, "dacb", :C3c2),
        :C3c2 => TetrahedralBaseGroupElement(:C3c2, "bdca", :C3c),
        :C3d => TetrahedralBaseGroupElement(:C3d, "bcad", :C3d2),
        :C3d2 => TetrahedralBaseGroupElement(:C3d2, "cabd", :C3d)
        )
        tb = multiplication_table(els)
        return new(els, Symbol("T"), 12, tb)
    end
end

struct TetrahedralDiagonalBaseGroupElement <: BaseGroupElement
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group

    function TetrahedralBaseGroupElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing, grp=TetrahedralDiagonalBaseGroup)
        @assert length(nn) == 4
        @assert all(c -> c in "abcd", nn)
        mat = zeros(Int64, 4, 4) 
        for i in 1:4
            mat[:, i] = char2row(nn[i], 4)
        end
        return new(s, mat, inv, grp)
    end
end

struct TetrahedralDiagonalBaseGroup <: BaseGroup
    elements::Dict{Symbol, TetrahedralBaseGroupElement}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function TetrahedralDiagonalBaseGroup()
        els = LittleDict(
        :E => TetrahedralBaseGroupElement(:E, "abcd", :E, TetrahedralDiagonalBaseGroup),
        :C2x => TetrahedralBaseGroupElement(:C2x, "badc", :C2x, TetrahedralDiagonalBaseGroup),
        :C2y => TetrahedralBaseGroupElement(:C2y, "dcba", :C2y, TetrahedralDiagonalBaseGroup), 
        :C2z => TetrahedralBaseGroupElement(:C2z, "cdab", :C2z, TetrahedralDiagonalBaseGroup), 
        :C3a => TetrahedralBaseGroupElement(:C3a, "adbc", :C3a2, TetrahedralDiagonalBaseGroup),
        :C3a2 => TetrahedralBaseGroupElement(:C3a2, "acdb", :C3a, TetrahedralDiagonalBaseGroup),
        :C3b => TetrahedralBaseGroupElement(:C3b, "cbda", :C3b2, TetrahedralDiagonalBaseGroup),
        :C3b2 => TetrahedralBaseGroupElement(:C3b2, "dbac", :C3b, TetrahedralDiagonalBaseGroup),
        :C3c => TetrahedralBaseGroupElement(:C3c, "dacb", :C3c2, TetrahedralDiagonalBaseGroup),
        :C3c2 => TetrahedralBaseGroupElement(:C3c2, "bdca", :C3c, TetrahedralDiagonalBaseGroup),
        :C3d => TetrahedralBaseGroupElement(:C3d, "bcad", :C3d2, TetrahedralDiagonalBaseGroup),
        :C3d2 => TetrahedralBaseGroupElement(:C3d2, "cabd", :C3d, TetrahedralDiagonalBaseGroup),
        :σab => TetrahedralBaseGroupElement(:σab, "abdc", :σab, TetrahedralDiagonalBaseGroup),
        :σac => TetrahedralBaseGroupElement(:σac, "adcb", :σac, TetrahedralDiagonalBaseGroup),
        :σad => TetrahedralBaseGroupElement(:σad, "acbd", :σad, TetrahedralDiagonalBaseGroup),
        :σbc => TetrahedralBaseGroupElement(:σbc, "dbca", :σbc, TetrahedralDiagonalBaseGroup),
        :σbd => TetrahedralBaseGroupElement(:σbd, "cbad", :σbd, TetrahedralDiagonalBaseGroup),
        :σcd => TetrahedralBaseGroupElement(:σcd, "bacd", :σcd, TetrahedralDiagonalBaseGroup),
        :Sx1 => TetrahedralBaseGroupElement(:Sx1, "cdba", :Sx3, TetrahedralDiagonalBaseGroup),
        :Sx3 => TetrahedralBaseGroupElement(:Sx3, "dcab", :Sx1, TetrahedralDiagonalBaseGroup),
        :Sy1 => TetrahedralBaseGroupElement(:Sy1, "cadb", :Sy3, TetrahedralDiagonalBaseGroup),
        :Sy3 => TetrahedralBaseGroupElement(:Sy3, "bdac", :Sy1, TetrahedralDiagonalBaseGroup),
        :Sz1 => TetrahedralBaseGroupElement(:Sz1, "dabc", :Sz3, TetrahedralDiagonalBaseGroup),
        :Sz3 => TetrahedralBaseGroupElement(:Sz3, "bcda", :Sz1, TetrahedralDiagonalBaseGroup),
        )
        tb = multiplication_table(els)
        return new(els, Symbol("Td"), 24, tb)
    end
end

