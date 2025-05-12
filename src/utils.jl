function (p::FiniteGroup)(s::Symbol)
    # @assert s in [:E, :C2x, :C2y, :C2z, :C3a, :C3a2, :C3b, :C3b2, :C3c, :C3c2, :C3d, :C3d2]
    return p.elements[s]
end

elements(G::FiniteGroup) = [k for (k, v) in G.elements]

function Base.show(io::IO, t::FiniteGroupElement) 
    println(io, "$(t.sym) [$(t.group().rep)]")
end

Base.:*(a::T, b::T) where T<:FiniteGroupElement = find_in_group_by_representation(a.group(), a.rep * b.rep)

function gmul(a::T, b::T) where T<:FiniteGroupElement 
    S = a.group()
    return S(S.table[a.sym, b.sym])
end

function Base.show(io::IO, t::FiniteGroup) 
    println(io, "$(t.rep) [$(length(t.elements)) elements] : ", elements(t))
end


"""
    char2row(c::Char, N)

This function is used to convert a character to a row vector representation.
The character is expected to be in the range 'a' to 'x', and the function 
returns a row vector of size (1, N) where N is the number of elements in 
the group.
The function uses the `findfirst` function to find the index of the character
in the string "abcdefghijklmnopqrstuvwx", and sets the corresponding position 
in the row vector to 1.
 
"""
function char2row(c::Char, N)
    r = "abcdefghijklmnopqrstuvwx"
    s = zeros(Int64, (1, N))
    idx = findfirst(c, r)
    s[1, idx]=1
    return s
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

function multiplication_table(D::LittleDict)
    function _find(D, rep) 
        for (key, value) in D
            if value.rep == rep
                return key
            end
        end
        return nothing
    end
    n = length(D)
    table = LittleDict{Tuple{Symbol, Symbol}, Symbol}()
    kk = keys(D)
    for k1 in kk
        for k2 in kk
            k = _find(D, D[k2].rep * D[k1].rep)
            table[(k2, k1)] = k
        end
    end
    return table
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

