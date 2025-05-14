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
        @assert N ∈ (2, 3, 4, 6)
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
        return new{N}(Symbol("C$N"), els)
    end

end

CGroup(N) = CGroup{N}()

function (p::CGroup{N})(s::Symbol) where N
    return CGroupElement{N}(s, p.elements[s], p.sym)
end

Mtable[:C2] = LittleDict(
    (:E, :E) => :E,
    (:C21, :E) => :C21,
    (:E, :C21) => :C21,
    (:C21, :C21) => :E
)

Mtable[:C3] = LittleDict(
    (:E, :E) => :E,
    (:C31, :E) => :C31,
    (:C32, :E) => :C32,
    (:E, :C31) => :C31,
    (:C31, :C31) => :C32,
    (:C32, :C31) => :E,
    (:E, :C32) => :C32,
    (:C31, :C32) => :E,
    (:C32, :C32) => :C31
)

Mtable[:C4] = LittleDict(
    (:E, :E) => :E,
    (:C41, :E) => :C41,
    (:C21, :E) => :C21,
    (:C43, :E) => :C43,
    (:E, :C41) => :C41,
    (:C41, :C41) => :C21,
    (:C21, :C41) => :C43,
    (:C43, :C41) => :E,
    (:E, :C21) => :C21,
    (:C41, :C21) => :C43,
    (:C21, :C21) => :E,
    (:C43, :C21) => :C41,
    (:E, :C43) => :C43,
    (:C41, :C43) => :E,
    (:C21, :C43) => :C41,
    (:C43, :C43) => :C21
)

Mtable[:C6] = LittleDict(
    (:E, :E) => :E,
    (:C61, :E) => :C61,
    (:C31, :E) => :C31,
    (:C21, :E) => :C21,
    (:C32, :E) => :C32,
    (:C65, :E) => :C65,
    (:E, :C61) => :C61,
    (:C61, :C61) => :C31,
    (:C31, :C61) => :C21,
    (:C21, :C61) => :C32,
    (:C32, :C61) => :C65,
    (:C65, :C61) => :E,
    (:E, :C31) => :C31,
    (:C61, :C31) => :C21,
    (:C31, :C31) => :C32,
    (:C21, :C31) => :C65,
    (:C32, :C31) => :E,
    (:C65, :C31) => :C61,
    (:E, :C21) => :C21,
    (:C61, :C21) => :C32,
    (:C31, :C21) => :C65,
    (:C21, :C21) => :E,
    (:C32, :C21) => :C61,
    (:C65, :C21) => :C31,
    (:E, :C32) => :C32,
    (:C61, :C32) => :C65,
    (:C31, :C32) => :E,
    (:C21, :C32) => :C61,
    (:C32, :C32) => :C31,
    (:C65, :C32) => :C21,
    (:E, :C65) => :C65,
    (:C61, :C65) => :E,
    (:C31, :C65) => :C61,
    (:C21, :C65) => :C31,
    (:C32, :C65) => :C21,
    (:C65, :C65) => :C32
)

