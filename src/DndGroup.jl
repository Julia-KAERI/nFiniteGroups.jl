struct DdGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function DdGroupElement{N}(sym, inv, grep) where N
        new{N}(sym, inv, grep)
    end
end

struct DdGroup{N} <:AbstractCGroup{N}
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function DdGroup{N}() where N
        M = [1;;]
        if N == 2
            els = LittleDict(
                :E => :E,
                :C21 => :C21,
                :d1 => :d1,
                :d2 => :d2,
                :σ1 => :σ1,
                :σ2 => :σ2,
                :S41 => :S43,
                :S43 => :S41
            )
            M = [ :E :C21 :d1 :d2 :σ1 :σ2 :S41 :S43 ;
                :C21 :E :d2 :d1 :σ2 :σ1 :S43 :S41 ;
                :d1 :d2 :E :C21 :S41 :S43 :σ1 :σ2 ;
                :d2 :d1 :C21 :E :S43 :S41 :σ2 :σ1 ;
                :σ1 :σ2 :S43 :S41 :E :C21 :d2 :d1 ;
                :σ2 :σ1 :S41 :S43 :C21 :E :d1 :d2 ;
                :S41 :S43 :σ2 :σ1 :d1 :d2 :C21 :E ;
                :S43 :S41 :σ1 :σ2 :d2 :d1 :E :C21]

        elseif N == 3
            els = LittleDict(
                :E => :E,
                :C31 => :C32,
                :C32 => :C31,
                :d1 => :d1,
                :d2 => :d2,
                :d3 => :d3,
                :σ1 => :σ1,
                :σ2 => :σ2,
                :σ3 => :σ3,
                :S61 => :S65,
                :S63 => :S63,
                :S65 => :S61
                            )
            M = [ :E :C31 :C32 :d1 :d2 :d3 :σ1 :σ2 :σ3 :S61 :S63 :S65 ;
                :C31 :C32 :E :d3 :d1 :d2 :σ3 :σ1 :σ2 :S63 :S65 :S61 ;
                :C32 :E :C31 :d2 :d3 :d1 :σ2 :σ3 :σ1 :S65 :S61 :S63 ;
                :d1 :d2 :d3 :E :C31 :C32 :S65 :S61 :S63 :σ2 :σ3 :σ1 ;
                :d2 :d3 :d1 :C32 :E :C31 :S63 :S65 :S61 :σ3 :σ1 :σ2 ;
                :d3 :d1 :d2 :C31 :C32 :E :S61 :S63 :S65 :σ1 :σ2 :σ3 ;
                :σ1 :σ2 :σ3 :S61 :S63 :S65 :E :C31 :C32 :d1 :d2 :d3 ;
                :σ2 :σ3 :σ1 :S65 :S61 :S63 :C32 :E :C31 :d2 :d3 :d1 ;
                :σ3 :σ1 :σ2 :S63 :S65 :S61 :C31 :C32 :E :d3 :d1 :d2 ;
                :S61 :S63 :S65 :σ1 :σ2 :σ3 :d3 :d1 :d2 :C31 :C32 :E ;
                :S63 :S65 :S61 :σ3 :σ1 :σ2 :d2 :d3 :d1 :C32 :E :C31 ;
                :S65 :S61 :S63 :σ2 :σ3 :σ1 :d1 :d2 :d3 :E :C31 :C32]
        end


        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new{N}(Symbol("D$(N)d"), els, _idd, M)
    end
end

DdGroup(N) = DdGroup{N}()

function (G::DdGroup{N})(s::Symbol) where N
    return DdGroupElement{N}(s, G.elements[s], G.sym)
end
