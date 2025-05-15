struct ChGroupElement{N} <: AbstractCGroupElement{N}
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function ChGroupElement{N}(sym, inv, grep) where N
        new{N}(sym, inv, grep)
    end
end

struct ChGroup{N} <:AbstractCGroup{N}
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function ChGroup{N}() where N
        @assert N ∈ (1, 2, 3, 4, 5,  6)
        
        if N == 1
            els = LittleDict(
                :E => :E,
                :σh => :σh
            )
            M = [ :E :σh;
                 :σh :E]
        elseif N == 2
            els = LittleDict(
                :E => :E,
                :C21 => :C21,
                :σh => :σh,
                :i => :i
            )
            M = [ :E :C21 :σh :i ;
                 :C21 :E :i :σh ;
                :σh :i :E :C21 ;
                :i :σh :C21 :E]
        elseif N == 3
            els = LittleDict(
                :E => :E,
                :C31 => :C32,
                :C32 => :C31,
                :σh => :σh,
                :S3 => :σhC32,
                :σhC32 => :S3
                )
            M = [ :E :C31 :C32 :σh :S3 :σhC32 ;
                 :C31 :C32 :E :S3 :σhC32 :σh ; 
                 :C32 :E :C31 :σhC32 :σh :S3 ; 
                 :σh :S3 :σhC32 :E :C31 :C32 ; 
                 :S3 :σhC32 :σh :C31 :C32 :E ; 
                 :σhC32 :σh :S3 :C32 :E :C31]

        elseif N == 4
            els = LittleDict(
                :E => :E,
                :C41 => :C43,
                :C21 => :C21,
                :C43 => :C41,
                :σh => :σh,
                :S41 => :S43,
                :i => :i,
                :S43 => :S41
            )
            M = [ :E :C41 :C21 :C43 :σh :S41 :i :S43 ;
                :C41 :C21 :C43 :E :S41 :i :S43 :σh ;
                :C21 :C43 :E :C41 :i :S43 :σh :S41 ;
                :C43 :E :C41 :C21 :S43 :σh :S41 :i ;
                :σh :S41 :i :S43 :E :C41 :C21 :C43 ;
                :S41 :i :S43 :σh :C41 :C21 :C43 :E ;
                :i :S43 :σh :S41 :C21 :C43 :E :C41 ;
                :S43 :σh :S41 :i :C43 :E :C41 :C21]
        
        elseif N == 5
            els = LittleDict(
                :E => :E,
                :C51 => :C54,
                :C52 => :C53,
                :C53 => :C52,
                :C54 => :C51,
                :σh => :σh,
                :S51 => :S54,
                :S52 => :S53,
                :S53 => :S52,
                :S54 => :S51
            )
            M = [ :E :C51 :C52 :C53 :C54 :σh :S51 :S52 :S53 :S54 ;
                :C51 :C52 :C53 :C54 :E :S51 :S52 :S53 :S54 :σh ;
                :C52 :C53 :C54 :E :C51 :S52 :S53 :S54 :σh :S51 ;
                :C53 :C54 :E :C51 :C52 :S53 :S54 :σh :S51 :S52 ;
                :C54 :E :C51 :C52 :C53 :S54 :σh :S51 :S52 :S53 ;
                :σh :S51 :S52 :S53 :S54 :E :C51 :C52 :C53 :C54 ;
                :S51 :S52 :S53 :S54 :σh :C51 :C52 :C53 :C54 :E ;
                :S52 :S53 :S54 :σh :S51 :C52 :C53 :C54 :E :C51 ;
                :S53 :S54 :σh :S51 :S52 :C53 :C54 :E :C51 :C52 ;
                :S54 :σh :S51 :S52 :S53 :C54 :E :C51 :C52 :C53]
        elseif N == 6
            els = LittleDict(
                :E => :E,
                :C61 => :C65,
                :C31 => :C32,
                :C21 => :C21,
                :C32 => :C31,
                :C65 => :C61,
                :σh => :σh,
                :S61 => :S65,
                :S31 => :S32,
                :i => :i,
                :S32 => :S31,
                :S65 => :S61
            )
            M = [ :E :C61 :C31 :C21 :C32 :C65 :σh :S61 :S31 :i :S32 :S65 ;
                :C61 :C31 :C21 :C32 :C65 :E :S61 :S31 :i :S32 :S65 :σh ;
                :C31 :C21 :C32 :C65 :E :C61 :S31 :i :S32 :S65 :σh :S61 ;
                :C21 :C32 :C65 :E :C61 :C31 :i :S32 :S65 :σh :S61 :S31 ;
                :C32 :C65 :E :C61 :C31 :C21 :S32 :S65 :σh :S61 :S31 :i ;
                :C65 :E :C61 :C31 :C21 :C32 :S65 :σh :S61 :S31 :i :S32 ;
                :σh :S61 :S31 :i :S32 :S65 :E :C61 :C31 :C21 :C32 :C65 ;
                :S61 :S31 :i :S32 :S65 :σh :C61 :C31 :C21 :C32 :C65 :E ;
                :S31 :i :S32 :S65 :σh :S61 :C31 :C21 :C32 :C65 :E :C61 ;
                :i :S32 :S65 :σh :S61 :S31 :C21 :C32 :C65 :E :C61 :C31 ;
                :S32 :S65 :σh :S61 :S31 :i :C32 :C65 :E :C61 :C31 :C21 ;
                :S65 :σh :S61 :S31 :i :S32 :C65 :E :C61 :C31 :C21 :C32]
        end

        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new{N}(Symbol("C$(N)h"), els, _idd, M)
    end

end

ChGroup(N) = ChGroup{N}()

function (p::ChGroup{N})(s::Symbol) where N
    return ChGroupElement{N}(s, p.elements[s], p.sym)
end
