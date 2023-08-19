using UUIDs
using Dates
using Parameters
using URIs
include("enums.jl")
include("types.jl")

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/DeletableProperty")
@with_kw struct Deletable
    delete::Union{Nothing,Bool} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/InterpolatableProperty",
)
@with_kw struct Interpolatable
    epoch::DateTime
    interpolationAlgorithm::Union{Nothing,InterpolationAlgorithms.T} = nothing
    interpolationDegree::Union{Nothing,Integer} = nothing
    forwardExtrapolationType::Union{Nothing,ExtrapolationTypes.T} = nothing
    forwardExtrapolationDuration::Union{Nothing,Real} = nothing
    backwardExtrapolationType::Union{Nothing,ExtrapolationTypes.T} = nothing
    backwardExtrapolationDuration::Union{Nothing,Real} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Orientation")
struct Orientation
    unitQuaternion::Vector{<:Real}
    reference::Union{Nothing,String}
    velocityreference::Union{Nothing,String}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function Orientation(;
    unitQuaternion::Vector{<:Real},
    reference::Union{Nothing,String} = nothing,
    velocityreference::Union{Nothing,String} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::Orientation
    if !(length(unitQuaternion) == 4 || mod(length(unitQuaternion), 5) == 0)
        error(
            "Input values must have either 4 or N * 5 values, where N is the number of time-tagged samples.",
        )
    end
    return Orientation(unitQuaternion,
        reference,
        velocityreference,
        interpolatable,
        deletable)
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/NearFarScalar")
@with_kw struct NearFarScalar
    nearFarScalar::Vector{<:Real}
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Font")
@with_kw struct Font
    font::String
    reference::Union{Nothing,String} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/RectangleCoordinates",
)
struct RectangleCoordinates
    reference::Union{Nothing,String}
    wsen::Union{Nothing,Vector{<:Real}}
    wsenDegrees::Union{Nothing,Vector{<:Real}}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function RectangleCoordinates(;
    reference::Union{Nothing,String} = nothing,
    wsen::Union{Nothing,Vector{<:Real}} = nothing,
    wsenDegrees::Union{Nothing,Vector{<:Real}} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::RectangleCoordinates
    if 1 != sum(
        map(
            !isnothing,
            [wsen, wsenDegrees],
        ),
    )
        error(
            "One and only one of wsen or wsenDegrees must be given",
        )
    end
    if !isnothing(wsen)
        if !(length(wsen) == 4 || mod(length(wsen), 5) == 0)
            error(
                "wsen must have either 4 or N * 5 values, where N is the number of time-tagged samples.",
            )
        end
    elseif !(length(wsenDegrees) == 4 || mod(length(wsenDegrees), 5) == 0)
        error(
            "wsenDegrees must have either 4 or N * 5 values, where N is the number of time-tagged samples.",
        )
    end
    return RectangleCoordinates(
        reference,
        wsen,
        wsenDegrees,
        interpolatable,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/BoxDimensions")
struct BoxDimensions
    cartesian::Vector{<:Real}
    reference::Union{Nothing,String}
    interpolatable::Union{Nothing,Interpolatable}
end
function BoxDimensions(;
    cartesian::Vector{<:Real},
    reference::Union{Nothing,String} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
)::BoxDimensions
    if !(length(cartesian) == 3 || mod(length(cartesian), 4) == 0)
        error(
            "cartesian must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
        )
    end

    if !(length(cartesian) == 3 || mod(length(cartesian), 4) == 0)
        error(
            "cartesian must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
        )
    end
    return BoxDimensions(cartesian, reference, interpolatable)
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/HeightReference")
@with_kw struct HeightReference
    heightreference::HeightReferences.T
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ClassificationType")
@with_kw struct ClassificationType
    classificationType::ClassificationTypes.T
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/DistanceDisplayCondition",
)
struct DistanceDisplayCondition
    distanceDisplayCondition::Union{Nothing,Vector{<:Real}}
    reference::Union{Nothing,String}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function DistanceDisplayCondition(;
    distanceDisplayCondition::Union{Nothing,Vector{<:Real}} = nothing,
    reference::Union{Nothing,String} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::DistanceDisplayCondition
    if length(distanceDisplayCondition) != 2
        error(
            "distanceDisplayCondition must have 2 values",
        )
    end
    return DistanceDisplayCondition(
        distanceDisplayCondition,
        reference,
        interpolatable,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PositionList")
struct PositionList
    referenceFrame::Union{Nothing,ReferenceFrames.T}
    cartesian::Union{Nothing,Vector{<:Real}}
    cartographicRadians::Union{Nothing,Vector{<:Real}}
    cartographicDegrees::Union{Nothing,Vector{<:Real}}
    references::Union{Nothing,Vector{String}}
    deletable::Union{Nothing,Deletable}
end
function PositionList(;
    referenceFrame::Union{Nothing,ReferenceFrames.T} = nothing,
    cartesian::Union{Nothing,Vector{<:Real}} = nothing,
    cartographicRadians::Union{Nothing,Vector{<:Real}} = nothing,
    cartographicDegrees::Union{Nothing,Vector{<:Real}} = nothing,
    references::Union{Nothing,Vector{String}} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::PositionList
    if 1 != sum(
        map(
            !isnothing,
            [cartesian, cartographicDegrees, cartographicRadians, references],
        ),
    )
        error(
            "One and only one of cartesian, cartographicDegrees, cartographicRadians or references must be given",
        )
    end
    if !isnothing(cartographicDegrees)
        if !(
            mod(length(cartographicDegrees), 3) == 0 ||
            mod(length(cartographicDegrees), 4) == 0
        )
            error(
                "cartographicDegrees must have either M * 3 or N * 4 values, where M is the number of positions and N is the number of time-tagged samples.",
            )
        end
    elseif !isnothing(cartographicRadians)
        if !(
            mod(length(cartographicRadians), 3) == 0 ||
            mod(length(cartographicRadians), 4) == 0
        )
            error(
                "cartographicRadians must have either M * 3 or N * 4 values, where M is the number of positions and N is the number of time-tagged samples.",
            )
        end
    else
        !(
            length(cartesian) == 3 || mod(length(cartesian), 3) == 0 ||
            mod(length(cartesian), 4) == 0
        )
        error(
            "cartesian must have either 3, M * 3 or N * 4 values, where M is the number of positions and N is the number of time-tagged samples.",
        )
    end
    return PositionList(
        referenceFrame,
        cartesian,
        cartographicRadians,
        cartographicDegrees,
        references,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Uri")
struct Uri
    uri::String
    reference::Union{Nothing,String}
    deletable::Union{Nothing,Deletable}
end
function Uri(;
    uri::String = nothing,
    reference::Union{Nothing,String} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::Uri
    if !isvalid(uri)
        error("uri must be a URL or a data URI")
    end
    return Uri(uri,
        reference,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Color")
struct Color
    rgba::Union{Nothing,Vector{<:Real}}
    rgbaf::Union{Nothing,Vector{<:Real}}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function Color(;
    rgba::Union{Nothing,Vector{<:Real}} = nothing,
    rgbaf::Union{Nothing,Vector{<:Real}} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::Color
    if 1 != sum(map(!isnothing, [rgba, rgbaf]))
        error("One and only one of rgba or rgbaf must be given.")
    end

    color_chosen = !isnothing(rgba) ? rgba : rgbaf
    if length(color_chosen) == 4
        for n in color_chosen
            if !(0 ≤ n ≤ 255)
                error("rgba / rgbaf values must be between zero and one.")
            end
        end
    elseif mod(length(color_chosen), 5) == 0
        for i in 1:5:length(color_chosen)-1
            values = color_chosen[i+1:i+4]
            for n in values
                if !(0 ≤ n ≤ 255)
                    error("rgba / rgbaf values must be between zero and one.")
                end
            end
        end
    else
        error(
            "rgba / rgbaf must have either 4 or N * 5 values, where N is the number of time-tagged samples.",
        )
    end
    return Color(
        rgba,
        rgbaf,
        interpolatable,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ImageMaterial")
struct ImageMaterial
    image::Uri
    repeat::Union{Nothing,Vector{Integer}}
    color::Union{Nothing,Color}
    transparent::Union{Nothing,Bool}
end
function ImageMaterial(;
    image::Uri,
    repeat::Union{Nothing,Vector{Integer}} = nothing,
    color::Union{Nothing,Color} = nothing,
    transparent::Union{Nothing,Bool} = nothing,
)::ImageMaterial
    if length(repeat) != 2
        error(
            "repeat must have 2 values",
        )
    end
    return ImageMaterial(image,
        repeat,
        color,
        transparent)
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/SolidColorMaterial")
@with_kw struct SolidColorMaterial
    color::Union{Nothing,Color} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineOutlineMaterial",
)
@with_kw struct PolylineOutlineMaterial
    color::Union{Nothing,Color} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineGlowMaterial",
)
@with_kw struct PolylineGlowMaterial
    color::Union{Nothing,Color} = nothing
    glowPower::Union{Nothing,Real} = nothing
    taperPower::Union{Nothing,Real} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineArrowMaterial",
)
@with_kw struct PolylineArrowMaterial
    color::Union{Nothing,Color} = nothing
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineDashMaterial",
)
@with_kw struct PolylineDashMaterial
    color::Union{Nothing,Color} = nothing
    gapColor::Union{Nothing,Color} = nothing
    dashLength::Union{Nothing,Real} = nothing
    dashPattern::Union{Nothing,Integer} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/GridMaterial")
struct GridMaterial
    color::Union{Nothing,Color}
    cellAlpha::Union{Nothing,Real}
    lineCount::Union{Nothing,Vector{Integer}}
    lineThickness::Union{Nothing,Vector{<:Real}}
    lineOffset::Union{Nothing,Vector{<:Real}}
end
function GridMaterial(;
    color::Union{Nothing,Color} = nothing,
    cellAlpha::Union{Nothing,Real} = nothing,
    lineCount::Union{Nothing,Vector{Integer}} = nothing,
    lineThickness::Union{Nothing,Vector{<:Real}} = nothing,
    lineOffset::Union{Nothing,Vector{<:Real}} = nothing,
)::GridMaterial
    if !isnothing(lineThickness) & length(coords) != 2
        error(
            "lineThickness values must have 2 values",
        )
    end

    if !isnothing(lineOffset) & length(coords) != 2
        error(
            "lineOffset values must have 2 values",
        )
    end
    if !isnothing(lineCount) & length(lineCount) != 2
        error(
            "lineCount must have 2 values",
        )
    end
    return GridMaterial(color,
        cellAlpha,
        lineCount,
        lineThickness,
        lineOffset)
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/StripeMaterial")
struct StripeMaterial
    orientation::Union{Nothing,StripeOrientations.T}
    evenColor::Union{Nothing,Color}
    oddColor::Union{Nothing,Color}
    offset::Union{Nothing,Real}
    repeat::Union{Nothing,Real}
end
function StripeMaterial(;
    orientation::Union{Nothing,StripeOrientations.T} = nothing,
    evenColor::Union{Nothing,Color} = nothing,
    oddColor::Union{Nothing,Color} = nothing,
    offset::Union{Nothing,Real} = nothing,
    repeat::Union{Nothing,Real} = nothing)::StripeMaterial
    if length(repeat) != 2
        error(
            "repeat must have 2 values",
        )
    end
    return StripeMaterial(
        orientation,
        evenColor,
        oddColor,
        offset,
        repeat,
    )
end

@doc makedoc(
    "https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/CheckerboardMaterial",
)
struct CheckerboardMaterial
    evenColor::Union{Nothing,Color}
    oddColor::Union{Nothing,Color}
    repeat::Union{Nothing,Vector{Integer}}
end
function CheckerboardMaterial(;
    evenColor,
    oddColor,
    repeat,
)::CheckerboardMaterial
    if length(repeat) != 2
        error(
            "repeat must have 2 values",
        )
    end
    return CheckerboardMaterial(
        evenColor,
        oddColor,
        repeat,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Material")
@with_kw struct Material
    solidColor::Union{Nothing,SolidColorMaterial} = nothing
    image::Union{Nothing,ImageMaterial} = nothing
    grid::Union{Nothing,GridMaterial} = nothing
    stripe::Union{Nothing,StripeMaterial} = nothing
    checkerboard::Union{Nothing,CheckerboardMaterial} = nothing
    polylineOutline::Union{Nothing,PolylineOutlineMaterial} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineMaterial")
@with_kw struct PolylineMaterial
    solidColor::Union{Nothing,SolidColorMaterial} = nothing
    image::Union{Nothing,ImageMaterial} = nothing
    grid::Union{Nothing,GridMaterial} = nothing
    stripe::Union{Nothing,StripeMaterial} = nothing
    checkerboard::Union{Nothing,CheckerboardMaterial} = nothing
    polylineDash::Union{Nothing,PolylineDashMaterial} = nothing
    polylineArrow::Union{Nothing,PolylineArrowMaterial} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Position")
struct Position
    referenceFrame::Union{Nothing,ReferenceFrames.T}
    cartesian::Union{Nothing,Vector{<:Real}}
    cartographicRadians::Union{Nothing,Vector{<:Real}}
    cartographicDegrees::Union{Nothing,Vector{<:Real}}
    cartesianVelocity::Union{Nothing,Vector{<:Real}}
    reference::Union{Nothing,String}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function Position(;
    referenceFrame::Union{Nothing,ReferenceFrames.T} = nothing,
    cartesian::Union{Nothing,Vector{<:Real}} = nothing,
    cartographicRadians::Union{Nothing,Vector{<:Real}} = nothing,
    cartographicDegrees::Union{Nothing,Vector{<:Real}} = nothing,
    cartesianVelocity::Union{Nothing,Vector{<:Real}} = nothing,
    reference::Union{Nothing,String} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::Position
    if 1 != sum(
        map(
            !isnothing,
            [
                cartesian,
                cartographicDegrees,
                cartographicRadians,
                cartesianVelocity,
                reference,
            ],
        ),
    )
        error(
            "One and only one of cartesian, cartographicDegrees, cartographicRadians, cartesianVelocity or reference must be given",
        )
    end
    if !isnothing(cartographicDegrees)
        if !(length(cartographicDegrees) == 3 || mod(length(cartographicDegrees), 4) == 0)
            error(
                "cartographicDegrees must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
            )
        end
    elseif !isnothing(cartographicRadians)
        if !(length(cartographicRadians) == 3 || mod(length(cartographicRadians), 4) == 0)
            error(
                "cartographicRadians must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
            )
        end
    elseif !isnothing(cartesian)
        if !(length(cartesian) == 3 || mod(length(cartesian), 4) == 0)
            error(
                "cartesian must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
            )
        end
    elseif !(length(cartesianVelocity) == 6 || mod(length(cartesianVelocity), 7) == 0)
        error(
            "cartesianVelocity must have either 6 or N * 7 values, where N is the number of time-tagged samples.",
        )
    end
    return Position(
        referenceFrame,
        cartesian,
        cartographicRadians,
        cartographicDegrees,
        cartesianVelocity,
        reference,
        interpolatable,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ViewFrom")
struct ViewFrom
    cartesian::Union{Nothing,Vector{<:Real}}
    reference::Union{Nothing,String}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function ViewFrom(;
    cartesian::Union{Nothing,Vector{<:Real}} = nothing,
    reference::Union{Nothing,String} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::ViewFrom
    if 1 != sum(map(!isnothing, [viewFrom.cartesian viewFrom.reference]))
        error("One and only one of cartesian or reference must be given")
    end
    if !(length(cartesian) == 3 || mod(length(cartesian), 4) == 0)
        error(
            "cartesian must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
        )
    end
    return ViewFrom(
        cartesian,
        reference,
        interpolatable,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/EllipsoidRadii")
struct EllipsoidRadii
    cartesian::Union{Nothing,Vector{<:Real}}
    reference::Union{Nothing,String}
    interpolatable::Union{Nothing,Interpolatable}
    deletable::Union{Nothing,Deletable}
end
function EllipsoidRadii(;
    cartesian::Union{Nothing,Vector{<:Real}} = nothing,
    reference::Union{Nothing,String} = nothing,
    interpolatable::Union{Nothing,Interpolatable} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::EllipsoidRadii
    if !(length(cartesian) == 3 || mod(length(cartesian), 4) == 0)
        error(
            "cartesian must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
        )
    end
    return EllipsoidRadii(
        cartesian,
        reference,
        interpolatable,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Corridor")
@with_kw struct Corridor
    positions::PositionList
    show::Union{Nothing,Bool} = nothing
    width::Union{Nothing,Real} = nothing
    height::Union{Nothing,Real} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    extrudedHeight::Union{Nothing,Real} = nothing
    extrudedHeightreference::Union{Nothing,HeightReference} = nothing
    cornerType::Union{Nothing,CornerTypes.T} = nothing
    granularity::Union{Nothing,Real} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Real} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Cylinder")
@with_kw struct Cylinder
    length::Real
    show::Union{Nothing,Bool} = nothing
    topRadius::Real
    bottomRadius::Real
    heightreference::Union{Nothing,HeightReference} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    numberOfVerticalLines::Union{Nothing,Integer} = nothing
    slices::Union{Nothing,Integer} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Ellipse")
@with_kw struct Ellipse
    semiMajorAxis::Real
    semiMinorAxis::Real
    show::Union{Nothing,Bool} = nothing
    height::Union{Nothing,Real} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    extrudedHeight::Union{Nothing,Real} = nothing
    extrudedHeightreference::Union{Nothing,HeightReference} = nothing
    rotation::Union{Nothing,Real} = nothing
    stRotation::Union{Nothing,Real} = nothing
    numberOfVerticalLines::Union{Nothing,Integer} = nothing
    granularity::Union{Nothing,Real} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Polygon")
@with_kw struct Polygon
    positions::PositionList
    show::Union{Nothing,Bool} = nothing
    arcType::Union{Nothing,ArcTypes.T} = nothing
    granularity::Union{Nothing,Real} = nothing
    material::Union{Nothing,Material} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Polyline")
@with_kw struct Polyline
    positions::PositionList
    show::Union{Nothing,Bool} = nothing
    arcType::Union{Nothing,ArcTypes.T} = nothing
    width::Union{Nothing,Real} = nothing
    granularity::Union{Nothing,Real} = nothing
    material::Union{Nothing,Material} = nothing
    followSurface::Union{Nothing,Bool} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    depthFailMaterial::Union{Nothing,PolylineMaterial} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    clampToGround::Union{Nothing,Bool} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ArcType")
@with_kw struct ArcType
    arcType::Union{Nothing,ArcTypes.T} = nothing
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ShadowMode")
@with_kw struct ShadowMode
    shadowMode::Union{Nothing,ShadowModes.T} = nothing
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Ellipsoid")
@with_kw struct Ellipsoid
    radii::EllipsoidRadii
    innerRadii::Union{Nothing,EllipsoidRadii} = nothing
    minimumClock::Union{Nothing,Real} = nothing
    maximumClock::Union{Nothing,Real} = nothing
    minimumCone::Union{Nothing,Real} = nothing
    maximumCone::Union{Nothing,Real} = nothing
    show::Union{Nothing,Bool} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    stackPartitions::Union{Nothing,Integer} = nothing
    slicePartitions::Union{Nothing,Integer} = nothing
    subdivisions::Union{Nothing,Integer} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Box")
@with_kw struct Box
    show::Union{Nothing,Bool} = nothing
    dimensions::BoxDimensions
    heightreference::Union{Nothing,HeightReference} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Rectangle")
@with_kw struct Rectangle
    coordinates::RectangleCoordinates
    show::Union{Nothing,Bool} = nothing
    height::Union{Nothing,Real} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    extrudedHeight::Union{Nothing,Real} = nothing
    extrudedHeightreference::Union{Nothing,HeightReference} = nothing
    rotation::Union{Nothing,Real} = nothing
    stRotation::Union{Nothing,Real} = nothing
    granularity::Union{Nothing,Real} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/EyeOffset")
struct EyeOffset
    cartesian::Union{Nothing,Vector{<:Real}}
    reference::Union{Nothing,String}
    deletable::Union{Nothing,Deletable}
end
function EyeOffset(;
    cartesian::Union{Nothing,Vector{<:Real}} = nothing,
    reference::Union{Nothing,String} = nothing,
    deletable::Union{Nothing,Deletable} = nothing,
)::EyeOffset
    if !(length(cartesian) == 3 || mod(length(cartesian), 4) == 0)
        error(
            "cartesian must have either 3 or N * 4 values, where N is the number of time-tagged samples.",
        )
    end
    return EyeOffset(
        cartesian,
        reference,
        deletable,
    )
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Clock")
@with_kw struct Clock
    currentTime::DateTime
    multiplier::Union{Nothing,Real} = nothing
    range::Union{Nothing,ClockRanges.T} = nothing
    step::Union{Nothing,ClockSteps.T} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Path")
@with_kw struct Path
    show::Union{Nothing,Bool} = nothing
    leadTime::Union{Nothing,Real} = nothing
    trailTime::Union{Nothing,Real} = nothing
    width::Union{Nothing,Real} = nothing
    resolution::Union{Nothing,Real} = nothing
    material::Union{Nothing,PolylineMaterial} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Point")
@with_kw struct Point
    show::Union{Nothing,Bool} = nothing
    pixelSize::Union{Nothing,Real} = nothing
    heightReference::Union{Nothing,Real} = nothing
    color::Union{Nothing,Color} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    scaleByDistance::Union{Nothing,NearFarScalar} = nothing
    translucencyByDistance::Union{Nothing,Real} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    disableDepthTestDistance::Union{Nothing,Real} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/TileSet")
@with_kw struct TileSet
    uri::Any
    show::Union{Nothing,Bool} = nothing
    maximumScreenSpaceError::Union{Nothing,Real} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Wall")
@with_kw struct Wall
    show::Union{Nothing,Bool} = nothing
    positions::PositionList
    minimumHeights::Union{Nothing,Real} = nothing
    maximumHeights::Union{Nothing,Real} = nothing
    granularity::Union{Nothing,Real} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Label")
@with_kw struct Label
    show::Union{Nothing,Bool} = nothing
    text::String = nothing
    font::Union{Nothing,String} = nothing
    style::Union{Nothing,LabelStyles.T} = nothing
    scale::Union{Nothing,Real} = nothing
    showBackground::Union{Nothing,Bool} = nothing
    backgroundColor::Union{Nothing,Color} = nothing
    fillColor::Union{Nothing,Color} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Real} = nothing
    pixelOffset::Union{Nothing,Vector{<:Real}} = nothing
    eyeOffset::Union{Nothing,Vector{<:Real}} = nothing
    horizontalOrigin::Union{Nothing,HorizontalOrigins.T} = nothing
    verticalOrigin::Union{Nothing,VerticalOrigins.T} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Billboard")
@with_kw struct Billboard
    image::String  # TODO String and/or Uri?
    show::Union{Nothing,Bool} = nothing
    scale::Union{Nothing,Real} = nothing
    eyeOffset::Union{Nothing,Vector{<:Real}} = nothing
    pixelOffset::Union{Nothing,Vector{<:Real}} = nothing
    color::Union{Nothing,Color} = nothing
    horizontalOrigin::Union{Nothing,HorizontalOrigins.T} = nothing
    verticalOrigin::Union{Nothing,VerticalOrigins.T} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/NodeTransformation")
@with_kw struct NodeTransformation
    translation::Union{Nothing,Vector{<:Real}} = nothing
    rotation::Union{Nothing,Vector{<:Real}} = nothing
    scale::Union{Nothing,Vector{<:Real}} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Model")
@with_kw struct Model
    gltf::Union{Uri,String}
    show::Union{Nothing,Bool} = nothing
    scale::Union{Nothing,Real} = nothing
    minimumPixelSize::Union{Nothing,Real} = nothing
    maximumScale::Union{Nothing,Real} = nothing
    incrementallyLoadTextures::Union{Nothing,Bool} = nothing
    runAnimations::Union{Nothing,Bool} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    heightReference::Union{Nothing,HeightReferences.T} = nothing
    silhouetteColor::Union{Nothing,Color} = nothing
    silhouetteSize::Union{Nothing,Real} = nothing
    color::Union{Nothing,Color} = nothing
    colorBlendMode::Union{Nothing,ColorBlendModes.T} = nothing
    colorBlendAmount::Union{Nothing,Real} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    nodeTransformations::Union{Nothing,NodeTransformation} = nothing
    articulations = nothing  # TODO
end

"""
# Preamble

The preamble packet.
"""
@with_kw struct Preamble
    id::String = "document"
    version::String = "1.0"
    name::Union{Nothing,String} = nothing
    description::Union{Nothing,String} = nothing
    clock::Union{Nothing,Clock} = nothing
end

@doc makedoc("https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Packet")
@with_kw struct Packet
    id::String = string(uuid4())
    delete::Union{Nothing,Deletable} = nothing
    name::Union{Nothing,String} = nothing
    parent::Union{Nothing,String} = nothing
    description::Union{Nothing,String} = nothing
    availability::Union{Nothing,TimeInterval,Vector{TimeInterval}} = nothing
    # properties::Union{Nothing,} = nothing # TODO
    position::Union{Nothing,Position,PositionList} = nothing
    orientation::Union{Nothing,Orientation} = nothing
    viewFrom::Union{Nothing,ViewFrom} = nothing
    billboard::Union{Nothing,Billboard} = nothing
    box::Union{Nothing,Box} = nothing
    corridor::Union{Nothing,Corridor} = nothing
    cylinder::Union{Nothing,Cylinder} = nothing
    ellipse::Union{Nothing,Ellipse} = nothing
    ellipsoid::Union{Nothing,Ellipsoid} = nothing
    label::Union{Nothing,Label} = nothing
    model::Union{Nothing,Model} = nothing
    path::Union{Nothing,Path} = nothing
    point::Union{Nothing,Point} = nothing
    polygon::Union{Nothing,Polygon} = nothing
    polyline::Union{Nothing,Polyline} = nothing
    rectangle::Union{Nothing,Rectangle} = nothing
    tileset::Union{Nothing,TileSet} = nothing
    wall::Union{Nothing,Wall} = nothing
end

"""
# Document

A document containing a preamble and one or more packet.
"""
struct Document
    packets::Union{Packet,Preamble,Vector{Any}}
end
