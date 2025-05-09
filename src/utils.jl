

function (p::FiniteGroup)(s::Symbol)
    # @assert s in [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2]
    return p.elements[s]
end

function Base.inv(t::FiniteGroupElement) 
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


function classes(G::T) where T<:FiniteGroup
    elementset0 = [t.sym for (k, t) in G.elements]
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

