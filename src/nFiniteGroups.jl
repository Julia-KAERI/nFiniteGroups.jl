module nFiniteGroups

using LinearAlgebra, Printf, OrderedCollections

include("base.jl")
include("CnGroup.jl")
include("CnvGroup.jl")
include("CnhGroup.jl")
include("SnGroup.jl")
include("DnGroup.jl")
include("tetrahedral.jl")
include("utils.jl")

export FiniteGroup, FiniteGroupElement, FiniteGroupClass, FiniteGroupRepresentation
export PointGroup, SpaceGroup, PointGroupElement, SpaceGroupElement
export PointGroupRepresentation, SpaceGroupRepresentation
export AbstractTetrahedralGroup, AbstractTetrahedralGroupElement, AbstractTetrahedralGroupClass 
export CGroup, CGroupElement, CvGroup, CvGroupElement, ChGroup, ChGroupElement
export SGroup, SGroupElement
export DGroup, DGroupElement, DdGroup, DdGroupElement, DhGroup, DhGroupElement
export TetrahedralGroup, TetrahedralGroupElement, TetrahedralDiagonalGroup
export find_in_group_by_representation, classes, inv, elements
end # module nFiniteGroups
