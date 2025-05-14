abstract type CrystalGroup end
abstract type CrystalGroupElement end
abstract type CrystalGroupClass end

abstract type BaseGroup end
abstract type BaseGroupElement end
abstract type AbstractCBaseGroup{N} <: BaseGroup end
abstract type AbstractCBaseGroupElement{N} <:BaseGroupElement end

abstract type FiniteGroup <: CrystalGroup end
abstract type FiniteGroupElement <:CrystalGroupElement end 
abstract type FintieGroupClass <: CrystalGroupClass end


abstract type PointGroup <: FiniteGroup end
abstract type SpaceGroup <: FiniteGroup end
abstract type PointGroupElement <: FiniteGroupElement end
abstract type SpaceGroupElement <: FiniteGroupElement end
abstract type PointGroupClass <: FintieGroupClass end   
abstract type SpaceGroupClass <: FintieGroupClass end


abstract type AbstractCGroup{N} <: PointGroup end
abstract type AbstractCGroupElement{N} <:PointGroupElement end
abstract type AbstractTetrahedralGroup <: PointGroup end
abstract type AbstractTetrahedralGroupElement <: PointGroupElement end
abstract type AbstractTetrahedralGroupClass <: PointGroupClass end

