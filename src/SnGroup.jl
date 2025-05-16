struct SGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function SGroupElement{N}(sym, inv, grep) where N
        new{N}(sym, inv, grep)
    end
end

struct SGroup{N} <:AbstractCGroup{N}
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function SGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => :E,
                :i => :i
            )
            M = [ :E :i ;
                :i :E]

        elseif N == 4
            els = LittleDict(
                :E => :E,
                :S41 => :S43,
                :C21 => :C21,
                :S43 => :S41
            )
            M = [ :E :S41 :C21 :S43 ;
                :S41 :C21 :S43 :E ;
                :C21 :S43 :E :S41 ;
                :S43 :E :S41 :C21]

        elseif N == 6
            els = LittleDict(
                :E => :E,
                :S61 => :S65,
                :C31 => :C32,
                :S63 => :S63,
                :C32 => :C31,
                :S65 => :S61
            )
            M = [ :E :S61 :C31 :S63 :C32 :S65 ;
                :S61 :C31 :S63 :C32 :S65 :E ;
                :C31 :S63 :C32 :S65 :E :S61 ;
                :S63 :C32 :S65 :E :S61 :C31 ;
                :C32 :S65 :E :S61 :C31 :S63 ;
                :S65 :E :S61 :C31 :S63 :C32]
        end


        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new{N}(Symbol("S$(N)"), els, _idd, M)
    end
end

SGroup(N) = SGroup{N}()

function (G::SGroup{N})(s::Symbol) where N
    return SGroupElement{N}(s, G.elements[s], G.sym)
end