abstract type FiniteGroup end
abstract type FiniteGroupElement end 
abstract type FintieGroupClass end
abstract type FiniteGroupRepresentation end

abstract type PointGroup <: FiniteGroup end
abstract type SpaceGroup <: FiniteGroup end
abstract type PointGroupElement <: FiniteGroupElement end
abstract type SpaceGroupElement <: FiniteGroupElement end
abstract type PointGroupRepresentation <: FiniteGroupRepresentation end
abstract type SpaceGroupRepresentation <: FiniteGroupRepresentation end
abstract type PointGroupClass <: FintieGroupClass end   
abstract type SpaceGroupClass <: FintieGroupClass end

abstract type AbstractTetrahedralGroup <: PointGroup end
abstract type AbstractTetrahedralGroupElement <: PointGroupElement end
abstract type AbstractTetrahedralGroupClass <: PointGroupClass end