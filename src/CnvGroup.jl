struct CvGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function CvGroupElement{N}(sym, inv, grep) where N
        new{N}(sym, inv, grep)
    end
end

struct CvGroup{N} <:AbstractCGroup{N}
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function CvGroup{N}() where N
        M = [:E;;]
        @assert N ∈ (2, 3, 4, 6)
        if N == 2
            els = LittleDict(
                :E => :E,
                :C21 => :C21,
                :σ1 => :σ1,
                :σ2 => :σ2
                )
                M = [ :E :C21 :σ1 :σ2 ;
                    :C21 :E :σ2 :σ1 ;
                    :σ1 :σ2 :E :C21 ;
                    :σ2 :σ1 :C21 :E]
        elseif N == 3
            els = LittleDict(
                :E => :E,
                :C31 => :C32,
                :C32 => :C31,
                :σ1 => :σ1,
                :σ2 => :σ2,
                :σ3 => :σ2
                )
            M = [ :E :C31 :C32 :σ1 :σ2 :σ2 ;
                :C31 :C32 :E :σ2 :σ2 :σ1 ;
                :C32 :E :C31 :σ2 :σ1 :σ2 ;
                :σ1 :σ2 :σ2 :E :C32 :C31 ;
                :σ2 :σ1 :σ2 :C31 :E :C32 ;
                :σ2 :σ2 :σ1 :C32 :C31 :E]
        elseif N == 4
            els = LittleDict(
                :E => :E,
                :C41 => :C43,
                :C21 => :C21,
                :C43 => :C41,
                :σ1 => :σ1,
                :σ2 => :σ2,
                :σ1d => :σ2,
                :σ2d => :σ2
            )
            M = [ :E :C41 :C21 :C43 :σ1 :σ2 :σ2 :σ2 ;
                :C41 :C21 :C43 :E :σ2 :σ2 :σ1 :σ2 ;
                :C21 :C43 :E :C41 :σ2 :σ1 :σ2 :σ2 ;
                :C43 :E :C41 :C21 :σ2 :σ2 :σ2 :σ1 ;
                :σ1 :σ2 :σ2 :σ2 :E :C21 :C41 :C43 ;
                :σ2 :σ2 :σ1 :σ2 :C21 :E :C43 :C41 ;
                :σ2 :σ2 :σ2 :σ1 :C43 :C41 :E :C21 ;
                :σ2 :σ1 :σ2 :σ2 :C41 :C43 :C21 :E]
            
        elseif N == 6
            els = LittleDict(
                :E => :E,
                :C61 => :C65,
                :C31 => :C32,
                :C21 => :C21,
                :C32 => :C31,
                :C65 => :C61,
                :σ1 => :σ1,
                :σ2 => :σ2,
                :σ3 => :σ3,
                :σ1d => :σ1d,
                :σ2d => :σ2d,
                :σ3d => :σ3d
            )
            M = [ :E :C61 :C31 :C21 :C32 :C65 :σ1 :σ2 :σ3 :σ1d :σ2d :σ3d ;
                :C61 :C31 :C21 :C32 :C65 :E :σ3d :σ1d :σ2d :σ1 :σ2 :σ3 ;
                :C31 :C21 :C32 :C65 :E :C61 :σ3 :σ1 :σ2 :σ3d :σ1d :σ2d ;
                :C21 :C32 :C65 :E :C61 :C31 :σ2d :σ3d :σ1d :σ3 :σ1 :σ2 ;
                :C32 :C65 :E :C61 :C31 :C21 :σ2 :σ3 :σ1 :σ2d :σ3d :σ1d ;
                :C65 :E :C61 :C31 :C21 :C32 :σ1d :σ2d :σ3d :σ2 :σ3 :σ1 ;
                :σ1 :σ1d :σ2 :σ2d :σ3 :σ3d :E :C31 :C32 :C61 :C21 :C65 ;
                :σ2 :σ2d :σ3 :σ3d :σ1 :σ1d :C32 :E :C31 :C65 :C61 :C21 ;
                :σ3 :σ3d :σ1 :σ1d :σ2 :σ2d :C31 :C32 :E :C21 :C65 :C61 ;
                :σ1d :σ2 :σ2d :σ3 :σ3d :σ1 :C65 :C61 :C21 :E :C31 :C32 ;
                :σ2d :σ3 :σ3d :σ1 :σ1d :σ2 :C21 :C65 :C61 :C32 :E :C31 ;
                :σ3d :σ1 :σ1d :σ2 :σ2d :σ3 :C61 :C21 :C65 :C31 :C32 :E]
        end
        
        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new{N}(Symbol("C$(N)v"), els, _idd, M)
        
    end

end

CvGroup(N) = CvGroup{N}()

function (p::CvGroup{N})(s::Symbol) where N
    return CvGroupElement{N}(s, p.elements[s], p.sym)
end
