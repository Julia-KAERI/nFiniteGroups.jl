struct TetrahedralGroupElement <: PointGroupElement
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function TetrahedralGroupElement(sym, inv, grep)
        new(sym, inv, grep)
    end
end

struct TetrahedralGroup <:PointGroup
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function TetrahedralGroup() 
        els = LittleDict(
            :E => :E,
            :C2x => :C2x,
            :C2y => :C2y,
            :C2z => :C2z,
            :C3a => :C3a2,
            :C3a2 => :C3a,
            :C3b => :C3b2,
            :C3b2 => :C3b,
            :C3c => :C3c2,
            :C3c2 => :C3c,
            :C3d => :C3d2,
            :C3d2 => :C3d
        )
        M = [ :E :C2x :C2y :C2z :C3a :C3a2 :C3b :C3b2 :C3c :C3c2 :C3d :C3d2 ;
            :C2x :E :C2z :C2y :C3c :C3d2 :C3d :C3c2 :C3a :C3b2 :C3b :C3a2 ;
            :C2y :C2z :E :C2x :C3b :C3c2 :C3a :C3d2 :C3d :C3a2 :C3c :C3b2 ;
            :C2z :C2y :C2x :E :C3d :C3b2 :C3c :C3a2 :C3b :C3d2 :C3a :C3c2 ;
            :C3a :C3d :C3c :C3b :C3a2 :E :C3d2 :C2y :C3b2 :C2x :C3c2 :C2z ;
            :C3a2 :C3c2 :C3b2 :C3d2 :E :C3a :C2z :C3c :C2y :C3d :C2x :C3b ;
            :C3b :C3c :C3d :C3a :C3c2 :C2y :C3b2 :E :C3d2 :C2z :C3a2 :C2x ;
            :C3b2 :C3d2 :C3a2 :C3c2 :C2z :C3d :E :C3b :C2x :C3a :C2y :C3c ;
            :C3c :C3b :C3a :C3d :C3d2 :C2x :C3a2 :C2z :C3c2 :E :C3b2 :C2y ;
            :C3c2 :C3a2 :C3d2 :C3b2 :C2y :C3b :C2x :C3d :E :C3c :C2z :C3a ;
            :C3d :C3a :C3b :C3c :C3b2 :C2z :C3c2 :C2x :C3a2 :C2y :C3d2 :E ;
            :C3d2 :C3b2 :C3c2 :C3a2 :C2x :C3c :C2y :C3a :C2z :C3b :E :C3d]

        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new(:T, els, _idd, M)
    end
end

function (G::TetrahedralGroup)(s::Symbol) 
    return TetrahedralGroupElement(s, G.elements[s], G.sym)
end


struct TetrahedralDiagonalGroupElement <: PointGroupElement
    sym::Symbol
    inv::Symbol
    group_rep::Symbol

    function TetrahedralDiagonalGroupElement(sym, inv, grep)
        new(sym, inv, grep)
    end
end

struct TetrahedralDiagonalGroup <:PointGroup
    sym::Symbol
    elements::LittleDict{Symbol, Symbol}
    idxdict::Dict{Symbol, Int64}
    mtable::Matrix{Symbol}
    function TetrahedralDiagonalGroup() 
        els = LittleDict(
            :Sz1 => :Sz3,
            :σad => :σad,
            :σac => :σac,
            :C3d => :C3d2,
            :Sz3 => :Sz1,
            :C2x => :C2x,
            :Sy1 => :Sy3,
            :C3c2 => :C3c,
            :C3a => :C3a2,
            :E => :E,
            :C3c => :C3c2,
            :σcd => :σcd,
            :σab => :σab,
            :Sx3 => :Sx1,
            :σbd => :σbd,
            :C3b => :C3b2,
            :Sx1 => :Sx3,
            :C3a2 => :C3a,
            :σbc => :σbc,
            :Sy3 => :Sy1,
            :C3d2 => :C3d,
            :C3b2 => :C3b,
            :C2y => :C2y,
            :C2z => :C2z
        )
        M = [ :C2z :C3c :C2x :σbc :E :σbd :C3d :σab :Sy1 :Sz1 :Sy3 :C3b2 :C3d2 :C3c2 :C2y :σad :C3a2 :σcd :C3a :C3b :Sx3 :Sx1 :σac :Sz3 ;
            :C3b2 :E :C3a2 :σcd :C3c2 :Sy3 :C2z :Sz3 :σab :σad :Sx3 :C3d :C3a :C3c :C3d2 :Sx1 :C3b :σac :C2y :C2x :σbd :Sz1 :σbc :Sy1 ;
            :C2y :C3a :E :Sy3 :C2x :Sz3 :C3b :σcd :σad :σac :σbc :C3c2 :C3a2 :C3b2 :C2z :Sy1 :C3d2 :σab :C3c :C3d :Sx1 :Sx3 :Sz1 :σbd ;
            :σab :σbd :Sx3 :C3d2 :Sx1 :C3a :σac :C2y :C3b2 :C3d :C3a2 :σad :Sy3 :Sy1 :σcd :C3c2 :σbc :C2z :Sz3 :Sz1 :E :C2x :C3b :C3c ;
            :E :C3b :C2y :Sy1 :C2z :σac :C3a :Sx3 :σbc :Sz3 :σad :C3a2 :C3c2 :C3d2 :C2x :Sy3 :C3b2 :Sx1 :C3d :C3c :σab :σcd :σbd :Sz1 ;
            :σac :Sy1 :Sz1 :C3b :σbd :E :σad :C3b2 :C3c :C2x :C3a :σab :σcd :Sx1 :Sz3 :C3d :Sx3 :C3d2 :Sy3 :σbc :C3a2 :C3c2 :C2z :C2y ;
            :C3c2 :C2x :C3d2 :σab :C3b2 :σbc :C2y :σbd :σcd :Sy1 :Sx1 :C3b :C3c :C3a :C3a2 :Sx3 :C3d :Sz1 :C2z :E :Sz3 :σac :Sy3 :σad ;
            :σad :Sx1 :σbc :C2z :Sy1 :C3a2 :σab :C3c :C2y :C3c2 :E :σac :Sz3 :σbd :Sy3 :C2x :Sz1 :C3b :σcd :Sx3 :C3a :C3d :C3d2 :C3b2 ;
            :Sx3 :σac :σab :C3c2 :σcd :C3d :σbd :C2x :C3a2 :C3a :C3b2 :Sy3 :σad :σbc :Sx1 :C3d2 :Sy1 :E :Sz1 :Sz3 :C2z :C2y :C3c :C3b ;
            :Sz1 :σad :σac :C3d :Sz3 :C2x :Sy1 :C3c2 :C3a :E :C3c :σcd :σab :Sx3 :σbd :C3b :Sx1 :C3a2 :σbc :Sy3 :C3d2 :C3b2 :C2y :C2z ;
            :Sx1 :Sz1 :σcd :C3b2 :σab :C3b :Sz3 :E :C3d2 :C3c :C3c2 :σbc :Sy1 :Sy3 :Sx3 :C3a2 :σad :C2x :σac :σbd :C2y :C2z :C3a :C3d ;
            :C3a :C3d2 :C3c :σbd :C3b :σab :C3a2 :σbc :Sz1 :σcd :σac :E :C2x :C2z :C3d :Sz3 :C2y :Sy1 :C3c2 :C3b2 :σad :Sy3 :Sx1 :Sx3 ;
            :C3c :C3a2 :C3a :Sz3 :C3d :σcd :C3d2 :Sy3 :σac :σab :Sz1 :C2x :E :C2y :C3b :σbd :C2z :σad :C3b2 :C3c2 :Sy1 :σbc :Sx3 :Sx1 ;
            :C3b :C3b2 :C3d :Sz1 :C3a :Sx1 :C3c2 :σad :σbd :Sx3 :Sz3 :C2y :C2z :C2x :C3c :σac :E :Sy3 :C3a2 :C3d2 :σbc :Sy1 :σab :σcd ;
            :C2x :C3d :C2z :σad :C2y :Sz1 :C3c :Sx1 :Sy3 :σbd :Sy1 :C3d2 :C3b2 :C3a2 :E :σbc :C3c2 :Sx3 :C3b :C3a :σcd :σab :Sz3 :σac ;
            :σcd :Sz3 :Sx1 :C3a2 :Sx3 :C3c :Sz1 :C2z :C3c2 :C3b :C3d2 :Sy1 :σbc :σad :σab :C3b2 :Sy3 :C2y :σbd :σac :C2x :E :C3d :C3a ;
            :C3d :C3c2 :C3b :σac :C3c :Sx3 :C3b2 :Sy1 :Sz3 :Sx1 :σbd :C2z :C2y :E :C3a :Sz1 :C2x :σbc :C3d2 :C3a2 :Sy3 :σad :σcd :σab ;
            :σbc :σab :σad :C2x :Sy3 :C3c2 :Sx1 :C3d :E :C3a2 :C2y :Sz3 :σac :Sz1 :Sy1 :C2z :σbd :C3a :Sx3 :σcd :C3b :C3c :C3b2 :C3d2 ;
            :C3d2 :C2y :C3c2 :Sx3 :C3a2 :Sy1 :C2x :σac :Sx1 :σbc :σcd :C3c :C3b :C3d :C3b2 :σab :C3a :Sz3 :E :C2z :Sz1 :σbd :σad :Sy3 ;
            :C3a2 :C2z :C3b2 :Sx1 :C3d2 :σad :E :Sz1 :Sx3 :Sy3 :σab :C3a :C3d :C3b :C3c2 :σcd :C3c :σbd :C2x :C2y :σac :Sz3 :Sy1 :σbc ;
            :Sy3 :σcd :Sy1 :E :σbc :C3b2 :Sx3 :C3b :C2x :C3d2 :C2z :σbd :Sz1 :σac :σad :C2y :Sz3 :C3c :Sx1 :σab :C3d :C3a :C3c2 :C3a2 ;
            :Sy1 :Sx3 :Sy3 :C2y :σad :C3d2 :σcd :C3a :C2z :C3b2 :C2x :Sz1 :σbd :Sz3 :σbc :E :σac :C3d :σab :Sx1 :C3c :C3b :C3a2 :C3c2 ;
            :σbd :σbc :Sz3 :C3c :σac :C2z :Sy3 :C3a2 :C3b :C2y :C3d :Sx3 :Sx1 :σcd :Sz1 :C3a :σab :C3c2 :σad :Sy1 :C3b2 :C3d2 :E :C2x ;
            :Sz3 :Sy3 :σbd :C3a :Sz1 :C2y :σbc :C3d2 :C3d :C2z :C3b :Sx1 :Sx3 :σab :σac :C3c :σcd :C3b2 :Sy1 :σad :C3c2 :C3a2 :C2x :E]

        _idd = Dict([(k => id) for (id, k) in enumerate(keys(els))])
        return new(:Td, els, _idd, M)
    end
end

function (G::TetrahedralDiagonalGroup)(s::Symbol) 
    return TetrahedralDiagonalGroupElement(s, G.elements[s], G.sym)
end