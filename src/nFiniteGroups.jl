module nFiniteGroups

using LinearAlgebra, Printf, OrderedCollections

Mtable = LittleDict{Symbol, LittleDict{Tuple{Symbol, Symbol}, Symbol}}()



include("base/base.jl")
include("base/CnBaseGroup.jl")
include("base/CnvBaseGroup.jl")
include("base/CnhBaseGroup.jl")
include("base/SnBaseGroup.jl")
include("base/DnBaseGroup.jl")
include("base/TetrahedralBaseGroup.jl")
include("base/OctahedralBaseGroup.jl")
include("base/baseutils.jl")

include("CnGroup.jl")
include("CnvGroup.jl")
include("CnhGroup.jl")
include("DnGroup.jl")
include("DndGroup.jl")
include("DnhGroup.jl")
include("SnGroup.jl")
include("TetrahedralGroup.jl")
include("ohtable.jl")
include("OctahedralGroup.jl")

include("utils.jl")

export FiniteGroup, FiniteGroupElement, FiniteGroupClass, FiniteGroupRepresentation
export PointGroup, SpaceGroup, PointGroupElement, SpaceGroupElement
export PointGroupRepresentation, SpaceGroupRepresentation
export AbstractTetrahedraBaseGroup, AbstractTetrahedraBaseGroupElement, AbstractTetrahedraBaseGroupClass 

# export BaseGroup, BaseGroupElement
# export CBaseGroup, CBaseGroupElement, CvBaseGroup, CvBaseGroupElement, ChBaseGroup, ChBaseGroupElement
# export SBaseGroup, SBaseGroupElement
# export DBaseGroup, DBaseGroupElement, DdBaseGroup, DdBaseGroupElement, DhBaseGroup, DhBaseGroupElement
# export TetrahedralBaseGroup, TetrahedralBaseGroupElement, TetrahedralDiagonalBaseGroup, TetrahedralDiagonalBaseGroupElement
# export OctahedralBaseGroup, OctahedralBaseGroupElement, OctahedralHorizontalBaseGroup, OctahedralHorizontalBaseGroupElement
export find_in_group_by_representation, classes, inv, elements, gmul, multiplication_table, Mtable


export CGroup, CGroupElement
export CvGroup, CvGroupElement
export ChGroup, ChGroupElement
export DGroup, DGroupElement
export DdGroup, DdGroupElement
export DhGroup, DhGroupElement
export SGroup, SGroupElement
export TetrahedralGroup, TetrahedralGroupElement, TetrahedralDiagonalGroup, TetrahedralDiagonalGroupElement
export OctahedralGroup, OctahedralGroupElement, OctahedralHorizontalGroup, OctahedralHorizontalGroupElememnt
export Group, order, char2row, OhTable
end # module nFiniteGroups
