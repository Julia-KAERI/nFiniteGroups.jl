Groups = Dict(
    :C1 => CGroup(1),
    :C2 => CGroup(2),
    :C3 => CGroup(3),
    :C4 => CGroup(4),
    :C5 => CGroup(5),
    :C6 => CGroup(6),
    :C2v => CvGroup(2),
    :C3v => CvGroup(3),
    :C4v => CvGroup(4),
    :C6v => CvGroup(6),
    :C1h => ChGroup(1),
    :C2h => ChGroup(2),
    :C3h => ChGroup(3),
    :C4h => ChGroup(4),
    :C5h => ChGroup(5),
    :C6h => ChGroup(6),
    :D2 => DGroup(2),
    :D3 => DGroup(3),
    :D4 => DGroup(4),
    :D5 => DGroup(5),
    :D6 => DGroup(6),
    :D2d => DdGroup(2),
    :D3d => DdGroup(3),
    :D2h => DhGroup(2),
    :D3h => DhGroup(3),
    :D4h => DhGroup(4),
    :D5h => DhGroup(5),
    :D6h => DhGroup(6),
    :S2 => SGroup(2),
    :S4 => SGroup(4),
    :S6 => SGroup(6),
    :T => TetrahedralGroup(), 
    :Td => TetrahedralDiagonalGroup(),
    :O => OctahedralGroup(),
    :Oh => OctahedralHorizontalGroup(),
    
)

Group(s::Symbol) = Groups[s]
Group(s::String) = Groups[Symbol(s)]


order(G::FiniteGroup) = length(G.elements)

function (G::FiniteGroup)(s::Symbol)
    return keys(G.elements)
end

elements(G::FiniteGroup) = keys(G.elements)

function Base.show(io::IO, t::FiniteGroup) 
    println(io, "$(t.sym) [$(length(t.elements)) elements] : ", elements(t))
end

function Base.show(io::IO, t::FiniteGroupElement) 
    println(io, "$(t.sym) [$(t.group_rep)]")
end

Base.inv(g::FiniteGroupElement) = g.inv

function Base.:*(a::T, b::T) where T<:PointGroupElement
    G = Groups[a.group_rep]
    i, j = G.idxdict[a.sym], G.idxdict[b.sym]
    return G(G.mtable[i, j])
end


function classes(G::T) where T<:FiniteGroup
    elementset0 = [k for k in elements(G)]
    elementset = Set(elementset0)
    elementclass = []
    while length(elementset) > 0
        el = pop!(elementset)
        class = Set([el,])
        for g in elementset0
            push!(class, ((G(g)*G(el))*G(inv(G(g)))).sym)
        end
        push!(elementclass, class)
        elementset = setdiff(elementset, class)
    end
    return elementclass
end
