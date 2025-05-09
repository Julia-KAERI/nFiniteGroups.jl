
abstract type AbstractCGroup{N} <: PointGroup end
abstract type AbstractCGroupElement{N} <: PointGroupElement end

struct CGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group
    function CGroupElement(N::Integer, n::Integer)
        @assert N ∈ (1, 2, 3, 4, 6)
        r = divrem(n, N)[2]
        q = divrem(N-r, N)[2]
        return new{N}(Symbol("C$(N)_$(r)"), [1 r;0 1], Symbol("C$(N)_$(q)"), CGroup{N})
    end
end


struct CGroup{N} <: PointGroup where N

    elements::Dict{Symbol, CGroupElement{N}}
    rep::String
    order::Integer   
    function CGroup{N}() where N
        @assert N ∈ (1, 2, 3, 4, 6)
        els = Dict()
        for r in 0:(N-1)
            els[Symbol("C$(N)_$(r)")] = CGroupElement(N, r)
        end
        return new{N}(els, "C$N", N)
    end

end

CGroup(N::Integer) = CGroup{N}()


function Base.:*(a::T, b::T) where T<:CGroupElement 
    gr = a.group()
    N = gr.order
    c = a.rep*b.rep
    d = [1 divrem(c[1,2], N)[2]; 0 1]
    find_in_group_by_representation(a.group(), d)
end

elements(G::CGroup{N}) where N = [t for (k, t) in G.elements]

