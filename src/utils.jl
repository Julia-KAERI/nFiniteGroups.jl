
Base.:*(a::T, b::T) where T<:FiniteGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)

function classes(G::T) where T<:FiniteGroup
    elementset0 = [t.sym for (k, t) in Tet.elements]
    elementset = Set(elementset0)
    elementclass = []
    while length(elementset) > 0
        el = pop!(elementset)
        class = Set([el,])
        for g in elementset0
            push!(class, ((G(g)*G(el))*inv(G(g))).sym)
        end
        push!(elementclass, class)
        elementset = setdiff(elementset, class)
    end
    return elementclass
end