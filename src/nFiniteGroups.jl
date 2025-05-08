module nFiniteGroups

using LinearAlgebra, Printf

include("base.jl")
include("tetrahedral.jl")
include("util.jl")

export FiniteGroup, FiniteGroupElement, TetrahedralGroup, TetrahedralElement
export find_in_group_by_representation, find_class, find_class 
end # module nFiniteGroups
