struct OctahedralBaseGroupElement <: BaseGroupElement
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group

    function OctahedralBaseGroupElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing, grp=OctahedralBaseGroup)
        mat = zeros(Int64, 6, 6) 
        for i in 1:6
            mat[:, i] = char2row(nn[i], 6)
        end
        return new(s, mat, inv, grp)
    end
end

struct OctahedralBaseGroup<:BaseGroup
    elements::LittleDict{Symbol, OctahedralBaseGroupElement}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    function OctahedralBaseGroup()
        els = LittleDict(
            :E => OctahedralBaseGroupElement(:E,        "abcdef", :E),
            :Cx41 => OctahedralBaseGroupElement(:Cx41,  "aecfdb", :Cx43),
            :Cx21 => OctahedralBaseGroupElement(:Cx21,  "adcbfe", :Cx21), 
            :Cx43 => OctahedralBaseGroupElement(:Cx43,  "afcebd", :Cx41), 
            :Cy41 => OctahedralBaseGroupElement(:Cy41,  "fbedac", :Cy43),
            :Cy21 => OctahedralBaseGroupElement(:Cy21,  "cbadfe", :Cy21),
            :Cy43 => OctahedralBaseGroupElement(:Cy43,  "ebfdca", :Cy41),
            :Cz41 => OctahedralBaseGroupElement(:Cz41,  "bcdaef", :Cz43),
            :Cz21 => OctahedralBaseGroupElement(:Cz21,  "cdabef", :Cz21),
            :Cz43 => OctahedralBaseGroupElement(:Cz43,  "dabcef", :Cz41),
            :C2ab => OctahedralBaseGroupElement(:C2ab,  "badcfe", :C2ab),
            :C2bc => OctahedralBaseGroupElement(:C2bc,  "dcbafe", :C2bc),
            :C2ae => OctahedralBaseGroupElement(:C2ae,  "edfbac", :C2ae),
            :C2be => OctahedralBaseGroupElement(:C2be,  "ceafbd", :C2be),
            :C2ce => OctahedralBaseGroupElement(:C2ce,  "fdebca", :C2ce),
            :C2de => OctahedralBaseGroupElement(:C2de,  "cfaedb", :C2de),
            :C31ade => OctahedralBaseGroupElement(:C31ade,   "ecfadb", :C32ade),
            :C32ade => OctahedralBaseGroupElement(:C32ade,   "dfbeac", :C31ade),
            :C31abe => OctahedralBaseGroupElement(:C31abe,   "bedfac", :C32abe),
            :C32abe => OctahedralBaseGroupElement(:C32abe,   "eafcbd", :C31abe),
            :C31bce => OctahedralBaseGroupElement(:C31bce,   "fceabd", :C32bce),
            :C32bce => OctahedralBaseGroupElement(:C32bce,   "debfca", :C31bce),
            :C31cde => OctahedralBaseGroupElement(:C31cde,   "bfdeca", :C32cde),
            :C32cde => OctahedralBaseGroupElement(:C32cde,   "faecdb", :C31cde),
        )
        tb = multiplication_table(els)
        return new(els, Symbol("O"), 24, tb)
    end
end

struct OctahedralHorizontalBaseGroupElement <: BaseGroupElement
    sym::Symbol
    rep::Matrix{Int64}
    inv::Union{Nothing, Symbol}
    group

    function OctahedralHorizontalBaseGroupElement(s::Symbol, nn::String, inv::Union{Nothing, Symbol} = nothing, grp=OctahedralHorizontalBaseGroup)
        mat = zeros(Int64, 6, 6) 
        for i in 1:6
            mat[:, i] = char2row(nn[i], 6)
        end
        return new(s, mat, inv, grp)
    end
end

struct OctahedralHorizontalBaseGroup <: BaseGroup
    elements::Dict{Symbol, OctahedralHorizontalBaseGroupElement}
    sym::Symbol
    order::Integer
    table::LittleDict{Tuple{Symbol, Symbol}, Symbol}  
    
    function OctahedralHorizontalBaseGroup()
        els = LittleDict(
            :E => OctahedralHorizontalBaseGroupElement(:E,        "abcdef", :E),
            :Cx41 => OctahedralHorizontalBaseGroupElement(:Cx41,  "aecfdb", :Cx43),
            :Cx21 => OctahedralHorizontalBaseGroupElement(:Cx21,  "adcbfe", :Cx21), 
            :Cx43 => OctahedralHorizontalBaseGroupElement(:Cx43,  "afcebd", :Cx41), 
            :Cy41 => OctahedralHorizontalBaseGroupElement(:Cy41,  "fbedac", :Cy43),
            :Cy21 => OctahedralHorizontalBaseGroupElement(:Cy21,  "cbadfe", :Cy21),
            :Cy43 => OctahedralHorizontalBaseGroupElement(:Cy43,  "ebfdca", :Cy41),
            :Cz41 => OctahedralHorizontalBaseGroupElement(:Cz41,  "bcdaef", :Cz43),
            :Cz21 => OctahedralHorizontalBaseGroupElement(:Cz21,  "cdabef", :Cz21),
            :Cz43 => OctahedralHorizontalBaseGroupElement(:Cz43,  "dabcef", :Cz41),
            :C2ab => OctahedralHorizontalBaseGroupElement(:C2ab,  "badcfe", :C2ab),
            :C2bc => OctahedralHorizontalBaseGroupElement(:C2bc,  "dcbafe", :C2bc),
            :C2ae => OctahedralHorizontalBaseGroupElement(:C2ae,  "edfbac", :C2ae),
            :C2be => OctahedralHorizontalBaseGroupElement(:C2be,  "ceafbd", :C2be),
            :C2ce => OctahedralHorizontalBaseGroupElement(:C2ce,  "fdebca", :C2ce),
            :C2de => OctahedralHorizontalBaseGroupElement(:C2de,  "cfaedb", :C2de),
            :C31ade => OctahedralHorizontalBaseGroupElement(:C31ade,   "ecfadb", :C32ade),
            :C32ade => OctahedralHorizontalBaseGroupElement(:C32ade,   "dfbeac", :C31ade),
            :C31abe => OctahedralHorizontalBaseGroupElement(:C31abe,   "bedfac", :C32abe),
            :C32abe => OctahedralHorizontalBaseGroupElement(:C32abe,   "eafcbd", :C31abe),
            :C31bce => OctahedralHorizontalBaseGroupElement(:C31bce,   "fceabd", :C32bce),
            :C32bce => OctahedralHorizontalBaseGroupElement(:C32bce,   "debfca", :C31bce),
            :C31cde => OctahedralHorizontalBaseGroupElement(:C31cde,   "bfdeca", :C32cde),
            :C32cde => OctahedralHorizontalBaseGroupElement(:C32cde,   "faecdb", :C31cde),
            :i => OctahedralHorizontalBaseGroupElement(:i,            "cdabfe", :i),
            :Cx41i => OctahedralHorizontalBaseGroupElement(:Cx41i,    "cfaebd", :Cx43i),
            :Cx21i => OctahedralHorizontalBaseGroupElement(:Cx21i,    "cbadef", :Cx21i), 
            :Cx43i => OctahedralHorizontalBaseGroupElement(:Cx43i,    "ceafdb", :Cx41i), 
            :Cy41i => OctahedralHorizontalBaseGroupElement(:Cy41i,    "edfbca", :Cy43i),
            :Cy21i => OctahedralHorizontalBaseGroupElement(:Cy21i,    "adcbef", :Cy21i),
            :Cy43i => OctahedralHorizontalBaseGroupElement(:Cy43i,    "fdebac", :Cy41i),
            :Cz41i => OctahedralHorizontalBaseGroupElement(:Cz41i,    "dabcfe", :Cz43i),
            :Cz21i => OctahedralHorizontalBaseGroupElement(:Cz21i,    "abcdfe", :Cz21i),
            :Cz43i => OctahedralHorizontalBaseGroupElement(:Cz43i,    "bcdafe", :Cz41i),
            # :C2abi => OctahedralBaseGroupElement(:C2abi,    "dabcef", :C2abi),
            :C2abi => OctahedralHorizontalBaseGroupElement(:C2abi,    "dcbaef", :C2abi),
            :C2bci => OctahedralHorizontalBaseGroupElement(:C2bci,    "badcef", :C2bci),
            :C2aei => OctahedralHorizontalBaseGroupElement(:C2aei,    "fbedca", :C2aei),
            :C2bei => OctahedralHorizontalBaseGroupElement(:C2bei,    "afcedb", :C2bei),
            :C2cei => OctahedralHorizontalBaseGroupElement(:C2cei,    "ebfdac", :C2cei),
            :C2dei => OctahedralHorizontalBaseGroupElement(:C2dei,    "aecfbd", :C2dei),
            :C31adei => OctahedralHorizontalBaseGroupElement(:C31adei,    "faecbd", :C32adei),
            :C32adei => OctahedralHorizontalBaseGroupElement(:C32adei,    "bedfca", :C31adei),
            :C31abei => OctahedralHorizontalBaseGroupElement(:C31abei,    "dfbeca", :C32abei),
            :C32abei => OctahedralHorizontalBaseGroupElement(:C32abei,    "fceadb", :C31abei),
            :C31bcei => OctahedralHorizontalBaseGroupElement(:C31bcei,    "eafcdb", :C32bcei),
            :C32bcei => OctahedralHorizontalBaseGroupElement(:C32bcei,    "bfdeac", :C31bcei),
            :C31cdei => OctahedralHorizontalBaseGroupElement(:C31cdei,    "debfac", :C32cdei),
            :C32cdei => OctahedralHorizontalBaseGroupElement(:C32cdei,    "ecfabd", :C31cdei)
        )
        tb = multiplication_table(els)
        # tb = LittleDict()
        return new(els, Symbol("Oh"), 24, tb)
    end
end
