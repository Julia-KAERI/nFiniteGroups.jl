struct DGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function DGroupElement{N}(sym, inv, grep) where N
        new{N}(sym, inv, grep)
    end
end

struct DGroup{N} <:AbstractCGroup{N}
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function DGroup{N}() where N
        if N == 2
            els = LittleDict(
                :E => :E,
                :C21 => :C21,
                :d1 => :d1,
                :d2 => :d2
            )
            M = [ :E :C21 :d1 :d2 ;
                :C21 :E :d2 :d1 ;
                :d1 :d2 :E :C21 ;
                :d2 :d1 :C21 :E]

        elseif N == 3
            els = LittleDict(
                :E => :E,
                :C31 => :C32,
                :C32 => :C31,
                :d1 => :d1,
                :d2 => :d2,
                :d3 => :d3
                            )
            M = [ :E :C31 :C32 :d1 :d2 :d3 ;
                :C31 :C32 :E :d3 :d1 :d2 ;
                :C32 :E :C31 :d2 :d3 :d1 ;
                :d1 :d2 :d3 :E :C31 :C32 ;
                :d2 :d3 :d1 :C32 :E :C31 ;
                :d3 :d1 :d2 :C31 :C32 :E]
        elseif N == 4
            els = LittleDict(
                :E => :E,
                :C41 => :C43,
                :C2 => :C2,
                :C43 => :C41,
                :d1 => :d1,
                :d2 => :d2,
                :d3 => :d3,
                :d4 => :d4
            )
            M = [ :E :C41 :C2 :C43 :d1 :d2 :d3 :d4 ;
                :C41 :C2 :C43 :E :d4 :d1 :d2 :d3 ;
                :C2 :C43 :E :C41 :d3 :d4 :d1 :d2 ;
                :C43 :E :C41 :C2 :d2 :d3 :d4 :d1 ;
                :d1 :d2 :d3 :d4 :E :C41 :C2 :C43 ;
                :d2 :d3 :d4 :d1 :C43 :E :C41 :C2 ;
                :d3 :d4 :d1 :d2 :C2 :C43 :E :C41 ;
                :d4 :d1 :d2 :d3 :C41 :C2 :C43 :E]
        elseif N == 5
             els = LittleDict(
                :E => :E,
                :C51 => :C54,
                :C52 => :C53,
                :C53 => :C52,
                :C54 => :C51,
                :d1 => :d1,
                :d2 => :d2,
                :d3 => :d3,
                :d4 => :d4,
                :d5 => :d5
                        )        
            M = [ :E :C41 :C2 :C43 :d1 :d2 :d3 :d4 ;
                :C41 :C2 :C43 :E :d4 :d1 :d2 :d3 ;
                :C2 :C43 :E :C41 :d3 :d4 :d1 :d2 ;
                :C43 :E :C41 :C2 :d2 :d3 :d4 :d1 ;
                :d1 :d2 :d3 :d4 :E :C41 :C2 :C43 ;
                :d2 :d3 :d4 :d1 :C43 :E :C41 :C2 ;
                :d3 :d4 :d1 :d2 :C2 :C43 :E :C41 ;
                :d4 :d1 :d2 :d3 :C41 :C2 :C43 :E]   
        elseif N == 6
            els = LittleDict(
                :E => :E,
                :C61 => :C65,
                :C31 => :C32,
                :C21 => :C21,
                :C32 => :C31,
                :C65 => :C61,
                :d1 => :d1,
                :d2 => :d2,
                :d3 => :d3,
                :d4 => :d4,
                :d5 => :d5,
                :d6 => :d6
                        )
            M = [ :E :C61 :C31 :C21 :C32 :C65 :d1 :d2 :d3 :d4 :d5 :d6 ;
                :C61 :C31 :C21 :C32 :C65 :E :d6 :d1 :d2 :d3 :d4 :d5 ;
                :C31 :C21 :C32 :C65 :E :C61 :d5 :d6 :d1 :d2 :d3 :d4 ;
                :C21 :C32 :C65 :E :C61 :C31 :d4 :d5 :d6 :d1 :d2 :d3 ;
                :C32 :C65 :E :C61 :C31 :C21 :d3 :d4 :d5 :d6 :d1 :d2 ;
                :C65 :E :C61 :C31 :C21 :C32 :d2 :d3 :d4 :d5 :d6 :d1 ;
                :d1 :d2 :d3 :d4 :d5 :d6 :E :C61 :C31 :C21 :C32 :C65 ;
                :d2 :d3 :d4 :d5 :d6 :d1 :C65 :E :C61 :C31 :C21 :C32 ;
                :d3 :d4 :d5 :d6 :d1 :d2 :C32 :C65 :E :C61 :C31 :C21 ;
                :d4 :d5 :d6 :d1 :d2 :d3 :C21 :C32 :C65 :E :C61 :C31 ;
                :d5 :d6 :d1 :d2 :d3 :d4 :C31 :C21 :C32 :C65 :E :C61 ;
                :d6 :d1 :d2 :d3 :d4 :d5 :C61 :C31 :C21 :C32 :C65 :E]
        end


        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new{N}(Symbol("D$(N)"), els, _idd, M)
    end
end

DGroup(N) = DGroup{N}()

function (p::DGroup{N})(s::Symbol) where N
    return DGroupElement{N}(s, p.elements[s], p.sym)
end
