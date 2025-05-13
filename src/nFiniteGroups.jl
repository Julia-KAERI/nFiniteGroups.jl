module nFiniteGroups

using LinearAlgebra, Printf, OrderedCollections

include("base/base.jl")
include("base/CnBaseGroup.jl")
include("base/CnvGroup.jl")
include("base/CnhGroup.jl")
include("base/SnGroup.jl")
include("base/DnGroup.jl")
include("base/tetrahedral.jl")
include("base/utils.jl")

include("CnGroup.jl")

export FiniteGroup, FiniteGroupElement, FiniteGroupClass, FiniteGroupRepresentation
export PointGroup, SpaceGroup, PointGroupElement, SpaceGroupElement
export PointGroupRepresentation, SpaceGroupRepresentation
export AbstractTetrahedraBaseGroup, AbstractTetrahedraBaseGroupElement, AbstractTetrahedraBaseGroupClass 
export CBaseGroup, CBaseGroupElement, CvBaseGroup, CvBaseGroupElement, ChBaseGroup, ChBaseGroupElement
export SBaseGroup, SBaseGroupElement
export DBaseGroup, DBaseGroupElement, DdBaseGroup, DdBaseGroupElement, DhBaseGroup, DhBaseGroupElement
export TetrahedraBaseGroup, TetrahedraBaseGroupElement, TetrahedralDiagonalGroup
export find_in_group_by_representation, classes, inv, elements, gmul


export CGroup, CGroupElement

end # module nFiniteGroups
