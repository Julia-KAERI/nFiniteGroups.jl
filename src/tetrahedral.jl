tetrahedral_symbol = [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2]

struct TetrahedralElement <: FiniteGroupElement   
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
    function TetrahedralElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing)
        @assert length(nn) == 4
        @assert all(c -> c in "abcd", nn)
        mat = zeros(Int64, 4, 4) 
        for i in 1:4
            mat[:, i] = char2tet(nn[i])
        end
        return new(s, mat, inv, TetrahedralGroup)
    end
end

Base.show(io::IO, t::TetrahedralElement) = print(io, "$(t.sym) [TetrahedralElement] : ", t.rep)


struct TetrahedralGroup<:FiniteGroup
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


function (p::TetrahedralGroup)(s::Symbol)
    @assert s in [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2]
    return p.elements[s]
end

function inv(t::FiniteGroupElement) 
    if t.inv == nothing
        return nothing
    else
        x=t.group()
        return x(t.inv)
    end
end

function find_in_group_by_representation(G::T, rep) where T<:FiniteGroup
    for (key, value) in G.elements
        if value.rep == rep
            return G(key)
        end
    end
    return nothing
end

    