struct OctahedralGroupElement <: PointGroupElement
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function OctahedralGroupElement(sym, inv, grep)
        new(sym, inv, grep)
    end
end

struct OctahedralGroup <:PointGroup
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function OctahedralGroup() 
        els = LittleDict(
            :E => :E,
            :Cx41 => :Cx43,
            :Cx21 => :Cx21,
            :Cx43 => :Cx41,
            :Cy41 => :Cy43,
            :Cy21 => :Cy21,
            :Cy43 => :Cy41,
            :Cz41 => :Cz43,
            :Cz21 => :Cz21,
            :Cz43 => :Cz41,
            :C2ab => :C2ab,
            :C2bc => :C2bc,
            :C2ae => :C2ae,
            :C2be => :C2be,
            :C2ce => :C2ce,
            :C2de => :C2de,
            :C31ade => :C32ade,
            :C32ade => :C31ade,
            :C31abe => :C32abe,
            :C32abe => :C31abe,
            :C31bce => :C32bce,
            :C32bce => :C31bce,
            :C31cde => :C32cde,
            :C32cde => :C31cde
        )
        M = [ :E :Cx41 :Cx21 :Cx43 :Cy41 :Cy21 :Cy43 :Cz41 :Cz21 :Cz43 :C2ab :C2bc :C2ae :C2be :C2ce :C2de :C31ade :C32ade :C31abe :C32abe :C31bce :C32bce :C31cde :C32cde ;
            :Cx41 :Cx21 :Cx43 :E :C32cde :C2de :C31ade :C31abe :C2be :C32bce :C31cde :C32ade :C32abe :Cy21 :C31bce :Cz21 :C2ae :Cz43 :C2ab :Cy43 :Cy41 :C2bc :Cz41 :C2ce ;
            :Cx21 :Cx43 :E :Cx41 :C2ce :Cz21 :C2ae :C2ab :Cy21 :C2bc :Cz41 :Cz43 :Cy43 :C2de :Cy41 :C2be :C32abe :C32bce :C31cde :C31ade :C32cde :C32ade :C31abe :C31bce ;
            :Cx43 :E :Cx41 :Cx21 :C31bce :C2be :C32abe :C31cde :C2de :C32ade :C31abe :C32bce :C31ade :Cz21 :C32cde :Cy21 :Cy43 :C2bc :Cz41 :C2ae :C2ce :Cz43 :C2ab :Cy41 ;
            :Cy41 :C31abe :C2ae :C32ade :Cy21 :Cy43 :E :C31bce :C2ce :C32cde :C32abe :C31ade :Cz21 :C32bce :Cx21 :C31cde :Cz41 :C2de :C2be :Cz43 :C2bc :Cx41 :Cx43 :C2ab ;
            :Cy21 :C2be :Cz21 :C2de :Cy43 :E :Cy41 :C2bc :Cx21 :C2ab :Cz43 :Cz41 :C2ce :Cx41 :C2ae :Cx43 :C31bce :C31cde :C32bce :C32cde :C31ade :C31abe :C32ade :C32abe ;
            :Cy43 :C32bce :C2ce :C31cde :E :Cy41 :Cy21 :C31ade :C2ae :C32abe :C32cde :C31bce :Cx21 :C31abe :Cz21 :C32ade :C2bc :Cx43 :Cx41 :C2ab :Cz41 :C2be :C2de :Cz43 ;
            :Cz41 :C31ade :C2bc :C31bce :C31abe :C2ab :C31cde :Cz21 :Cz43 :E :Cx21 :Cy21 :C32ade :C32abe :C32bce :C32cde :C2de :Cy41 :C2ae :Cx43 :C2be :Cy43 :C2ce :Cx41 ;
            :Cz21 :C2de :Cy21 :C2be :C2ae :Cx21 :C2ce :Cz43 :E :Cz41 :C2bc :C2ab :Cy41 :Cx43 :Cy43 :Cx41 :C32cde :C31abe :C32ade :C31bce :C32abe :C31cde :C32bce :C31ade ;
            :Cz43 :C32cde :C2ab :C32abe :C32ade :C2bc :C32bce :E :Cz41 :Cz21 :Cy21 :Cx21 :C31abe :C31bce :C31cde :C31ade :Cx41 :C2ae :Cy41 :C2be :Cx43 :C2ce :Cy43 :C2de ;
            :C2ab :C32abe :Cz43 :C32cde :C31cde :Cz41 :C31abe :Cy21 :C2bc :Cx21 :E :Cz21 :C32bce :C31ade :C32ade :C31bce :C2be :C2ce :Cy43 :Cx41 :C2de :C2ae :Cy41 :Cx43 ;
            :C2bc :C31bce :Cz41 :C31ade :C32bce :Cz43 :C32ade :Cx21 :C2ab :Cy21 :Cz21 :E :C31cde :C32cde :C31abe :C32abe :Cx43 :Cy43 :C2ce :C2de :Cx41 :Cy41 :C2ae :C2be ;
            :C2ae :C32ade :Cy41 :C31abe :Cx21 :C2ce :Cz21 :C32abe :Cy43 :C31ade :C31bce :C32cde :E :C31cde :Cy21 :C32bce :Cz43 :Cx41 :Cx43 :Cz41 :C2ab :C2de :C2be :C2bc ;
            :C2be :Cz21 :C2de :Cy21 :C32abe :Cx43 :C31bce :C32bce :Cx41 :C31abe :C32ade :C31cde :C32cde :E :C31ade :Cx21 :C2ce :C2ab :Cz43 :Cy41 :Cy43 :Cz41 :C2bc :C2ae ;
            :C2ce :C31cde :Cy43 :C32bce :Cz21 :C2ae :Cx21 :C32cde :Cy41 :C31bce :C31ade :C32abe :Cy21 :C32ade :E :C31abe :C2ab :C2be :C2de :C2bc :Cz43 :Cx43 :Cx41 :Cz41 ;
            :C2de :Cy21 :C2be :Cz21 :C31ade :Cx41 :C32cde :C32ade :Cx43 :C31cde :C32bce :C31abe :C31bce :Cx21 :C32abe :E :Cy41 :Cz41 :C2bc :C2ce :C2ae :C2ab :Cz43 :Cy43 ;
            :C31ade :C2bc :C31bce :Cz41 :Cx41 :C32cde :C2de :C2ae :C32abe :Cy43 :C2ce :Cy41 :Cx43 :C2ab :C2be :Cz43 :C32ade :E :Cx21 :C31cde :C31abe :Cy21 :Cz21 :C32bce ;
            :C32ade :Cy41 :C31abe :C2ae :C2bc :C32bce :Cz43 :Cx43 :C31cde :C2de :C2be :Cx41 :Cz41 :C2ce :C2ab :Cy43 :E :C31ade :C31bce :Cz21 :Cx21 :C32cde :C32abe :Cy21 ;
            :C31abe :C2ae :C32ade :Cy41 :C2ab :C31cde :Cz41 :C2be :C32bce :Cx41 :Cx43 :C2de :Cz43 :Cy43 :C2bc :C2ce :Cz21 :C32cde :C32abe :E :Cy21 :C31ade :C31bce :Cx21 ;
            :C32abe :Cz43 :C32cde :C2ab :Cx43 :C31bce :C2be :Cy43 :C31ade :C2ae :Cy41 :C2ce :Cx41 :Cz41 :C2de :C2bc :C32bce :Cx21 :E :C31abe :C31cde :Cz21 :Cy21 :C32ade ;
            :C31bce :Cz41 :C31ade :C2bc :C2be :C32abe :Cx43 :C2ce :C32cde :Cy41 :C2ae :Cy43 :C2de :Cz43 :Cx41 :C2ab :C31cde :Cy21 :Cz21 :C32ade :C32bce :E :Cx21 :C31abe ;
            :C32bce :C2ce :C31cde :Cy43 :Cz43 :C32ade :C2bc :Cx41 :C31abe :C2be :C2de :Cx43 :C2ab :Cy41 :Cz41 :C2ae :Cx21 :C32abe :C32cde :Cy21 :E :C31bce :C31ade :Cz21 ;
            :C31cde :Cy43 :C32bce :C2ce :Cz41 :C31abe :C2ab :C2de :C32ade :Cx43 :Cx41 :C2be :C2bc :C2ae :Cz43 :Cy41 :Cy21 :C31bce :C31ade :Cx21 :Cz21 :C32abe :C32cde :E ;
            :C32cde :C2ab :C32abe :Cz43 :C2de :C31ade :Cx41 :Cy41 :C31bce :C2ce :Cy43 :C2ae :C2be :C2bc :Cx43 :Cz41 :C31abe :Cz21 :Cy21 :C32bce :C32ade :Cx21 :E :C31cde]

        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new(:O, els, _idd, M)
    end
end

function (G::OctahedralGroup)(s::Symbol) 
    return OctahedralGroupElement(s, G.elements[s], G.sym)
end

struct OctahedralHorizontalGroupElement <: PointGroupElement
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function OctahedralHorizontalGroupElement(sym, inv, grep=OctahedralHorizontalGroup)
        new(sym, inv, grep)
    end
end

struct OctahedralHorizontalGroup <:PointGroup
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function OctahedralHorizontalGroup() 
        M = Matrix{Symbol}(undef, 48, 48)
        els = LittleDict(
            :C31cdei => :C32cdei,
            :C32adei => :C31adei,
            :C2bci => :C2bci,
            :Cz41i => :Cz43i,
            :C31bce => :C32bce,
            :C32abe => :C31abe,
            :C2bc => :C2bc,
            :C2cei => :C2cei,
            :C31adei => :C32adei,
            :C31ade => :C32ade,
            :C2de => :C2de,
            :Cy21i => :Cy21i,
            :C2aei => :C2aei,
            :C32cdei => :C31cdei,
            :C32ade => :C31ade,
            :C32bcei => :C31bcei,
            :i => :i,
            :Cz21i => :Cz21i,
            :Cy41 => :Cy43,
            :C2ce => :C2ce,
            :Cx21 => :Cx21,
            :C32bce => :C31bce,
            :Cz41 => :Cz43,
            :Cx41 => :Cx43,
            :Cx43 => :Cx41,
            :Cy43i => :Cy41i,
            :C2dei => :C2dei,
            :C2ab => :C2ab,
            :C31bcei => :C32bcei,
            :Cy21 => :Cy21,
            :Cx43i => :Cx41i,
            :C31cde => :C32cde,
            :C32cde => :C31cde,
            :E => :E,
            :C2bei => :C2bei,
            :Cz21 => :Cz21,
            :C2abi => :C2abi,
            :C2ae => :C2ae,
            :Cx41i => :Cx43i,
            :C2be => :C2be,
            :Cy43 => :Cy41,
            :C31abei => :C32abei,
            :C32abei => :C31abei,
            :Cz43 => :Cz41,
            :C31abe => :C32abe,
            :Cz43i => :Cz41i,
            :Cy41i => :Cy43i,
            :Cx21i => :Cx21i
        )
        M = OhTable

        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new(:Oh, els, _idd, M)
    end
end

function (G::OctahedralHorizontalGroup)(s::Symbol) 
    return OctahedralHorizontalGroupElement(s, G.elements[s], G.sym)
end