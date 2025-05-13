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
    
    function CGroup{N}() where N
        els = LittleDict{Symbol, Symbol}()
        for i = 0:(N-1)
            if i == 0 
                els[:E] = :E
            else
                els[Symbol("C$N$i")] = Symbol("C$N$(N-i)")
            end
        end
        return new{N}(Symbol("C$N"), els)
    end

end

CGroup(N) = CGroup{N}()

function (p::CGroup{N})(s::Symbol) where N
    return CGroupElement{N}(s, p.elements[s], p.sym)
end

