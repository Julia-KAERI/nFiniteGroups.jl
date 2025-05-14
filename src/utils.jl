Groups = Dict(
    :C2 => CGroup(2),
    :C3 => CGroup(3),
    :C4 => CGroup(4),
    :C6 => CGroup(6),
    :C2v => CvGroup(2),
    :C3v => CvGroup(3),
    :C4v => CvGroup(4),
    :C6v => CvGroup(6),
    :C2h => ChGroup(2),
    :C3h => ChGroup(3),
    :C4h => ChGroup(4),
    :C6h => ChGroup(6),
)


function (p::FiniteGroup)(s::Symbol)
    return keys(p.elements)
end

elements(G::FiniteGroup) = keys(G.elements)

function Base.show(io::IO, t::FiniteGroup) 
    println(io, "$(t.sym) [$(length(t.elements)) elements] : ", elements(t))
end

function Base.show(io::IO, t::FiniteGroupElement) 
    println(io, "$(t.sym) [$(t.group_rep)]")
end

Base.inv(g::FiniteGroupElement) = g.inv

Base.:*(a::T, b::T) where T<:PointGroupElement = Groups[a.group_rep]((Mtable[a.group_rep])[(a.sym, b.sym)])

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
