struct CGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function CGroupElement{N}(sym, inv, grep) where N
        new{N}(sym, inv, grep)
    end
end

struct CGroup{N} <:AbstractCGroup{N}
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function CGroup{N}() where N
        @assert N ∈ (1, 2, 3, 4, 5, 6)
        els = LittleDict{Symbol, Symbol}()
        for i = 0:(N-1)
            if i == 0 
                els[:E] = :E
            else
                d = gcd(N, i)
                r = div(N, d)
                s = div(i, d)
                els[Symbol("C$r$s")] = Symbol("C$r$(r-s)")
            end
        end
        if N == 1
            M = [:E ;; ]
        elseif N == 2
            M = [ :E :C21 ; :C21 :E]
        elseif N == 3
            M = [ :E :C31 :C32 ; :C31 :C32 :E ; :C32 :E :C31]
        elseif N == 4
            M = [ :E :C41 :C21 :C43 ; :C41 :C21 :C43 :E ; :C21 :C43 :E :C41 ; :C43 :E :C41 :C21]
        elseif N == 5
            M = [ :E :C51 :C52 :C53 :C54 ; :C51 :C52 :C53 :C54 :E ; :C52 :C53 :C54 :E :C51 ; :C53 :C54 :E :C51 :C52 ; :C54 :E :C51 :C52 :C53]
        elseif N == 6
            M = [ :E :C61 :C31 :C21 :C32 :C65 ; :C61 :C31 :C21 :C32 :C65 :E ; :C31 :C21 :C32 :C65 :E :C61 ; :C21 :C32 :C65 :E :C61 :C31 ; :C32 :C65 :E :C61 :C31 :C21 ; :C65 :E :C61 :C31 :C21 :C32]
        end
        
        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new{N}(Symbol("C$N"), els, _idd, M)
    end

end

CGroup(N) = CGroup{N}()

function (p::CGroup{N})(s::Symbol) where N
    return CGroupElement{N}(s, p.elements[s], p.sym)
end


