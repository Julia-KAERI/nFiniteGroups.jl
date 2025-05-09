module nFiniteGroups

using LinearAlgebra, Printf

include("base.jl")
include("CnGroup.jl")
include("CnvGroup.jl")
include("CnhGroup.jl")
include("tetrahedral.jl")
include("utils.jl")

export FiniteGroup, FiniteGroupElement, FiniteGroupClass, FiniteGroupRepresentation
export PointGroup, SpaceGroup, PointGroupElement, SpaceGroupElement
export PointGroupRepresentation, SpaceGroupRepresentation
export AbstractTetrahedralGroup, AbstractTetrahedralGroupElement, AbstractTetrahedralGroupClass 
export CGroup, CGroupElement, CVGroup, CVGroupElement, CHGroup, CHGroupElement
export TetrahedralGroup, TetrahedralElement, TetrahedralDiagonalGroup
export find_in_group_by_representation, classes, inv, elements
end # module nFiniteGroups
