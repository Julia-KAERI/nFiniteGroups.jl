module nFiniteGroups

using LinearAlgebra, Printf

include("base.jl")
include("tetrahedral.jl")
include("utils.jl")

export FiniteGroup, FiniteGroupElement, TetrahedralGroup, TetrahedralElement
export find_in_group_by_representation, classes, inv
end # module nFiniteGroups
