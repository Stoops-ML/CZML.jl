using UUIDs
using Dates
using Parameters
using URIs
include("enums.jl")

#= A property whose value may be deleted.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/DeletableProperty
=#
@with_kw struct Deletable
    delete::Union{Nothing,Bool} = nothing
end

#=A property whose value may be determined by interpolating.
The interpolation happens over provided time-tagged samples.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/InterpolatableProperty
=#
@with_kw struct Interpolatable
    epoch::DateTime
    interpolationAlgorithm::Union{Nothing,InterpolationAlgorithms.T} = nothing
    interpolationDegree::Union{Nothing,Integer} = nothing
    forwardExtrapolationType::Union{Nothing,ExtrapolationTypes.T} = nothing
    forwardExtrapolationDuration::Union{Nothing,Number} = nothing
    backwardExtrapolationType::Union{Nothing,ExtrapolationTypes.T} = nothing
    backwardExtrapolationDuration::Union{Nothing,Number} = nothing
end

#= Defines an orientati and transforms it to the Earth fixed axes.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Orientation
=#
@with_kw struct Orientation
    unitQuaternion::Vector{Number}
    reference::Union{Nothing,String} = nothing
    velocityreference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A numeric value which will be linearly interpolated between two values based on an object's distance from camera, in eye coordinates.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/NearFarScalar
=#
@with_kw struct NearFarScalar
    #= The computed value will interpolate between the near value and the far value while the camera distance falls
    # less than the near distance or greater than the far distance, respectively
    between the near distance and the far distance, and will be clamped to the near or far value while the distance is =#
    nearFarScalar::Vector{Number}
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A font, specified using the same syntax as the CSS "font" property.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Font
=#
@with_kw struct Font
    font::String
    reference::Union{Nothing,String} = nothing
end

#= A set of coordinates describing a cartographic rectangle on the surface of the ellipsoid.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/RectangleCoordinates
=#
@with_kw struct RectangleCoordinates
    reference::Union{Nothing,String} = nothing
    wsen::Union{Nothing,Vector{Number}} = nothing
    wsenDegrees::Union{Nothing,Vector{Number}} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= The width, depth, and height of a box.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/BoxDimensions
=#
@with_kw struct BoxDimensions
    cartesian::Vector{Number}
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
end

#= The height reference of an object, which indicates if the object's position is relative to terrain or not.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/HeightReference
=#
@with_kw struct HeightReference
    heightreference::HeightReferences.T
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= Whether a classification affects terrain, 3D Tiles, or both.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ClassificationType
=#
@with_kw struct ClassificationType
    classificationType::ClassificationTypes.T
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= Indicates the visibility of an object based on the distance to the camera.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/DistanceDisplayCondition
=#
@with_kw struct DistanceDisplayCondition
    distanceDisplayCondition::Vector{Number} = nothing
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A list of positions.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PositionList
=#
@with_kw struct PositionList
    referenceFrame::Union{Nothing,ReferenceFrames.T} = nothing
    cartesian::Union{Nothing,Vector{Number}} = nothing
    cartographicRadians::Union{Nothing,Vector{Number}} = nothing
    cartographicDegrees::Union{Nothing,Vector{Number}} = nothing
    references::Vector{String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A URI val
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Uri
=#
@with_kw struct Uri
    # The URI can optionally vary with time
    uri::String = nothing
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A color. The color can optionally vary over time.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Color
=#
@with_kw struct Color
    rgba::Union{Nothing,Vector{Number}} = nothing
    rgbaf::Union{Nothing,Vector{Number}} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A material that fills the surface with an image.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ImageMaterial
=#
@with_kw struct ImageMaterial
    image::Uri
    repeat::Union{Nothing,Vector{Integer}} = nothing
    color::Union{Nothing,Color} = nothing
    transparent::Union{Nothing,Bool} = nothing
end

#= A material that fills the surface with a solid color.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/SolidColorMaterial
=#
@with_kw struct SolidColorMaterial
    color::Union{Nothing,Color} = nothing
end

#= A definition of how a surface is colored or shaded.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineOutlineMaterial
=#
@with_kw struct PolylineOutlineMaterial
    color::Union{Nothing,Color} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
end

#= A material that fills the surface of a line with a glowing color.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineGlowMaterial
=#
@with_kw struct PolylineGlowMaterial
    color::Union{Nothing,Color} = nothing
    glowPower::Union{Nothing,Number} = nothing
    taperPower::Union{Nothing,Number} = nothing
end

#= A material that fills the surface of a line with an arrow.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineArrowMaterial
=#
@with_kw struct PolylineArrowMaterial
    color::Union{Nothing,Color} = nothing
end

#= A definition of how a polyline should be dashed with two colors.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineDashMaterial
=#
@with_kw struct PolylineDashMaterial
    color::Union{Nothing,Color} = nothing
    gapColor::Union{Nothing,Color} = nothing
    dashLength::Union{Nothing,Number} = nothing
    dashPattern::Union{Nothing,Integer} = nothing
end

# @classmethod
# def from_list(cls, color):
#     return cls(color=Color.from_list(color))

#= A material that fills the surface with a two-dimensional grid.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/GridMaterial
=#
@with_kw struct GridMaterial
    color::Union{Nothing,Color} = nothing
    cellAlpha::Union{Nothing,Number} = nothing
    lineCount::Union{Nothing,Vector{Integer}} = nothing
    lineThickness::Union{Nothing,Vector{Number}} = nothing
    lineOffset::Union{Nothing,Vector{Number}} = nothing
end

#= A material that fills the surface with alternating colors.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/StripeMaterial
=#
@with_kw struct StripeMaterial
    orientation::Union{Nothing,StripeOrientations.T} = nothing
    evenColor::Union{Nothing,Color} = nothing
    oddColor::Union{Nothing,Color} = nothing
    offset::Union{Nothing,Number} = nothing
    repeat::Union{Nothing,Number} = nothing
end

#= A material that fills the surface with alternating colors.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/CheckerboardMaterial
=#
@with_kw struct CheckerboardMaterial
    evenColor::Union{Nothing,Color} = nothing
    oddColor::Union{Nothing,Color} = nothing
    repeat::Union{Nothing,Vector{Integer}} = nothing
end

# @classmethod
# # Determines if the input is a valid color
# def is_valid(cls, color):
# # [R, G, B] or [R, G, B, A]
#     if (
#         isinstance(color, (list, tuple))
#         and all([issubclass(type(v), int) for v in color])
#         and (3 <= len(color) <= 4)
#     ):
#         return all(0 <= v <= 255 for v in color)
# # [r, g, b] or [r, g, b, a] (float)
#     elif (
#         isinstance(color, (list, tuple))
#         and all([issubclass(type(v), float) for v in color])
#         and (3 <= len(color) <= 4)
#     ):
#         return all(0 <= v <= 1 for v in color)
# # Hexadecimal RGBA
#     elif issubclass(type(color), int):
#         return 0 <= color <= 0xFFFFFFFF
# # RGBA string
#     elif isinstance(color, str):
#         try:
#             n = nothing
#             return 0 <= n <= 0xFFFFFFFF
#         except ValueError:
#             return False
#     return False

# @classmethod
# def from_list(cls, color):
#     if all(issubclass(type(v), int) for v in color):
#         if len(color) == 3:
#             color = nothing
#         else:
#             color = nothing

#         return cls(rgba=RgbaValue(values=color))
#     else:
#         if len(color) == 3:
#             color = nothing
#         else:
#             color = nothing

#         return cls(rgbaf=RgbafValue(values=color))

# @classmethod
# def from_tuple(cls, color):
#     return cls.from_list(list(color))

# @classmethod
# def from_hex(cls, color):
#     if color > 0xFFFFFF:
#         values = nothing
#             (color & 0xFF000000) >> 24,
#             (color & 0x00FF0000) >> 16,
#             (color & 0x0000FF00) >> 8,
#             (color & 0x000000FF) >> 0,
#         ]
#     else:
#         values = nothing
#             (color & 0xFF0000) >> 16,
#             (color & 0x00FF00) >> 8,
#             (color & 0x0000FF) >> 0,
#             0xFF,
#         ]

#     return cls.from_list(values)

# @classmethod
# def from_str(cls, color):
#     return cls.from_hex(int(color.rsplit("#")[-1], 16))

#= A definition of how a surface is colored or shaded.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Material
=#
@with_kw struct Material
    solidColor::Union{Nothing,SolidColorMaterial} = nothing
    image::Union{Nothing,ImageMaterial} = nothing
    grid::Union{Nothing,GridMaterial} = nothing
    stripe::Union{Nothing,StripeMaterial} = nothing
    checkerboard::Union{Nothing,CheckerboardMaterial} = nothing
    polylineOutline = nothing  # not in documentation
end

#= A definition of how a surface is colored or shaded.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/PolylineMaterial
=#
@with_kw struct PolylineMaterial
    solidColor::Union{Nothing,SolidColorMaterial} = nothing
    image::Union{Nothing,ImageMaterial} = nothing
    grid::Union{Nothing,GridMaterial} = nothing
    stripe::Union{Nothing,StripeMaterial} = nothing
    checkerboard::Union{Nothing,CheckerboardMaterial} = nothing
    polylineDash::Union{Nothing,PolylineDashMaterial} = nothing
    polylineArrow::Union{Nothing,PolylineArrowMaterial} = nothing
end

#= Defines a position. The position can optionally vary over time.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Position
=#
@with_kw struct Position
    referenceFrame::Union{Nothing,ReferenceFrames.T} = nothing
    cartesian::Union{Nothing,Vector{Number}} = nothing
    cartographicRadians::Union{Nothing,Vector{Number}} = nothing
    cartographicDegrees::Union{Nothing,Vector{Number}} = nothing
    cartesianVelocity::Union{Nothing,Vector{Number}} = nothing
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= suggested initial camera position offset when tracking this obje
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ViewFrom
=#
@with_kw struct ViewFrom
    #  can optionally vary over time.
    cartesian::Union{Nothing,Vector{Number}} = nothing
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= The radii of an ellipsoid.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/EllipsoidRadii
=#
@with_kw struct EllipsoidRadii
    cartesian::Union{Nothing,Vector{Number}} = nothing
    reference::Union{Nothing,String} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A corridor , which is a shape defined by a centerline and width that conforms to 
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Corridor
=#
@with_kw struct Corridor
    #  of the body shape. It can can optionally be extruded into a volume.
    positions::PositionList
    show::Union{Nothing,Bool} = nothing
    width::Union{Nothing,Number} = nothing
    height::Union{Nothing,Number} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    extrudedHeight::Union{Nothing,Number} = nothing
    extrudedHeightreference::Union{Nothing,HeightReference} = nothing
    # cornerType::Union{Nothing,CornerTypes.T} = nothing
    granularity::Union{Nothing,Number} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Number} = nothing
end

#= A cylinder, which is a special cone defined by length, top and bottom radius.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Cylinder
=#
@with_kw struct Cylinder
    length::Number
    show::Union{Nothing,Bool} = nothing
    topRadius::Number
    bottomRadius::Number
    heightreference::Union{Nothing,HeightReference} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    numberOfVerticalLines::Union{Nothing,Integer} = nothing
    slices::Union{Nothing,Integer} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

#= An ellipse, which is a close curve, on or above Earth's surface.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Ellipse
=#
@with_kw struct Ellipse
    semiMajorAxis::Number
    semiMinorAxis::Number
    show::Union{Nothing,Bool} = nothing
    height::Union{Nothing,Number} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    extrudedHeight::Union{Nothing,Number} = nothing
    extrudedHeightreference::Union{Nothing,HeightReference} = nothing
    rotation::Union{Nothing,Number} = nothing
    stRotation::Union{Nothing,Number} = nothing
    numberOfVerticalLines::Union{Nothing,Integer} = nothing
    granularity::Union{Nothing,Number} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
end

#= A polygon, which is a closed figure on the surface of the Earth.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Polygon
=#
@with_kw struct Polygon
    positions::PositionList
    show::Union{Nothing,Bool} = nothing
    arcType::Union{Nothing,ArcTypes.T} = nothing
    granularity::Union{Nothing,Number} = nothing
    material::Union{Nothing,Material} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
end

#= A polyline, which is a line in the scene composed of multiple segments.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Polyline
=#
@with_kw struct Polyline
    positions::PositionList
    show::Union{Nothing,Bool} = nothing
    arcType::Union{Nothing,ArcTypes.T} = nothing
    width::Union{Nothing,Number} = nothing
    granularity::Union{Nothing,Number} = nothing
    material::Union{Nothing,Material} = nothing
    followSurface::Union{Nothing,Bool} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    depthFailMaterial::Union{Nothing,PolylineMaterial} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    clampToGround::Union{Nothing,Bool} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
end

#= The type of an arc.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ArcType
=#
@with_kw struct ArcType
    arcType::Union{Nothing,ArcTypes.T} = nothing
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= Whether or not an object casts or receives shadows from each light source when shadows are enabled.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/ShadowMode
=#
@with_kw struct ShadowMode
    shadowMode::Union{Nothing,ShadowModes.T} = nothing
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= A closed quadric surface that is a three-dimensional analogue of an ellipse.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Ellipsoid
=#
@with_kw struct Ellipsoid
    radii::EllipsoidRadii
    innerRadii::Union{Nothing,EllipsoidRadii} = nothing
    minimumClock::Union{Nothing,Vector{Number}} = nothing
    maximumClock::Union{Nothing,Vector{Number}} = nothing
    minimumCone::Union{Nothing,Vector{Number}} = nothing
    maximumCone::Union{Nothing,Vector{Number}} = nothing
    show::Union{Nothing,Bool} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    stackPartitions::Union{Nothing,Integer} = nothing
    slicePartitions::Union{Nothing,Integer} = nothing
    subdivisions::Union{Nothing,Integer} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

#= A box, which is a closed rectangular cuboid.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Box
=#
@with_kw struct Box
    show::Union{Nothing,Bool} = nothing
    dimensions::BoxDimensions
    heightreference::Union{Nothing,HeightReference} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

#= A cartographic rectangle, which conforms to the curvature of the globe 
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Rectangle
=#
@with_kw struct Rectangle
    #  be placed on the surface or at altitude and can optionally be extruded into a volume.
    coordinates::RectangleCoordinates
    show::Union{Nothing,Bool} = nothing
    height::Union{Nothing,Number} = nothing
    heightreference::Union{Nothing,HeightReference} = nothing
    extrudedHeight::Union{Nothing,Number} = nothing
    extrudedHeightreference::Union{Nothing,HeightReference} = nothing
    rotation::Union{Nothing,Number} = nothing
    stRotation::Union{Nothing,Number} = nothing
    granularity::Union{Nothing,Number} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    interpolatable::Union{Nothing,Interpolatable} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    classificationType::Union{Nothing,ClassificationType} = nothing
    zIndex::Union{Nothing,Integer} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= An offset in eye coordinates which can optionally vary over ti
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/EyeOffset
=#
@with_kw struct EyeOffset
    #= Eye coordinates are a left-handed coordinate system
    the Y-axis poitns up, and the Z-axis points into the screen.
    where the X-axis points toward the viewer's right, =#
    cartesian::Vector{Number} = nothing
    reference::Union{Nothing,String} = nothing
    deletable::Union{Nothing,Deletable} = nothing
end

#= Initial settings for a simulated clock when a document is load
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Clock
=#
@with_kw struct Clock
    # The start and stop time are configured using the interval property.
    currentTime::DateTime
    multiplier::Union{Nothing,Number} = nothing
    range::Union{Nothing,ClockRanges.T} = nothing
    step::Union{Nothing,ClockSteps.T} = nothing
end

#= A path, which is a polyline defined by the motion of an object over time.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Path

The possible vertices of the path are specified by the position property.
Note that because clients cannot render a truly infinite path,
the path must be limited,
or by using the leadTime and trailTime properties.
either by defining availability for this object,
=#
@with_kw struct Path
    show::Union{Nothing,Bool} = nothing
    leadTime::Union{Nothing,Number} = nothing
    trailTime::Union{Nothing,Number} = nothing
    width::Union{Nothing,Number} = nothing
    resolution::Union{Nothing,Number} = nothing
    material::Union{Nothing,PolylineMaterial} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

#= A point, or viewport-aligned circle.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Point
=#
@with_kw struct Point
    show::Union{Nothing,Bool} = nothing
    pixelSize::Union{Nothing,Number} = nothing
    heightReference::Union{Nothing,Number} = nothing
    color::Union{Nothing,Color} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    scaleByDistance::Union{Nothing,NearFarScalar} = nothing
    translucencyByDistance::Union{Nothing,Number} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    disableDepthTestDistance::Union{Nothing,Number} = nothing
end

#= A 3D Tiles tileset.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/TileSet
=#
@with_kw struct TileSet
    uri::Any
    show::Union{Nothing,Bool} = nothing
    maximumScreenSpaceError::Union{Nothing,Number} = nothing
end

#= A two-dimensional wall defined as a line strip and optional maximum and minimum heigh
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Wall
=#
@with_kw struct Wall
    #  conforms to the curvature of the globe and can be placed along the surface or at altitude.
    show::Union{Nothing,Bool} = nothing
    positions::PositionList
    minimumHeights::Union{Nothing,Number} = nothing
    maximumHeights::Union{Nothing,Number} = nothing
    granularity::Union{Nothing,Number} = nothing
    fill::Union{Nothing,Bool} = nothing
    material::Union{Nothing,Material} = nothing
    outline::Union{Nothing,Bool} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
end

#= A string of text.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Label
=#
@with_kw struct Label
    show::Union{Nothing,Bool} = nothing
    text::String = nothing
    font::Union{Nothing,String} = nothing
    style::Union{Nothing,LabelStyles.T} = nothing
    scale::Union{Nothing,Number} = nothing
    showBackground::Union{Nothing,Bool} = nothing
    backgroundColor::Union{Nothing,Color} = nothing
    fillColor::Union{Nothing,Color} = nothing
    outlineColor::Union{Nothing,Color} = nothing
    outlineWidth::Union{Nothing,Number} = nothing
    pixelOffset::Union{Nothing,Vector{Number}} = nothing
    horizontalOrigin::Union{Nothing,HorizontalOrigins.T} = nothing
    verticalOrigin::Union{Nothing,VerticalOrigins.T} = nothing
end

#= A billboard, or viewport-aligned ima
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Billboard
=#
@with_kw struct Billboard
    # A billboard is sometimes called a marker. The billboard is positioned in the scene by the position property.
    image::String  # TODO String and/or Uri?
    show::Union{Nothing,Bool} = nothing
    scale::Union{Nothing,Number} = nothing
    eyeOffset::Union{Nothing,Vector{Number}} = nothing
    color::Union{Nothing,Color} = nothing
    horizontalOrigin::Union{Nothing,HorizontalOrigins.T} = nothing
    verticalOrigin::Union{Nothing,VerticalOrigins.T} = nothing
end

#= A 3D model.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Model
=#
@with_kw struct Model
    gltf::Uri
    show::Union{Nothing,Bool} = nothing
    scale::Union{Nothing,Number} = nothing
    minimumPixelSize::Union{Nothing,Number} = nothing
    maximumScale::Union{Nothing,Number} = nothing
    incrementallyLoadTextures::Union{Nothing,Bool} = nothing
    runAnimations::Union{Nothing,Bool} = nothing
    shadows::Union{Nothing,ShadowModes.T} = nothing
    heightReference::Union{Nothing,HeightReferences.T} = nothing
    silhouetteColor::Union{Nothing,Color} = nothing
    silhouetteSize::Union{Nothing,Number} = nothing
    color::Union{Nothing,Color} = nothing
    colorBlendMode::Union{Nothing,ColorBlendModes.T} = nothing
    colorBlendAmount::Union{Nothing,Number} = nothing
    distanceDisplayCondition::Union{Nothing,DistanceDisplayCondition} = nothing
    # nodeTransformations::Union{Nothing,NodeTransformations} = nothing # TODO
    articulations = nothing  # TODO
end

# The preamble packet.
@with_kw struct Preamble
    id::String = "document"
    version::String = "1.0"
    name::Union{Nothing,String} = nothing
    description::Union{Nothing,String} = nothing
    clock::Union{Nothing,Clock} = nothing
end

#= A CZML Packet.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/Packet
=#
@with_kw struct Packet
    id::String = uuid4()
    delete::Union{Nothing,Deletable} = nothing
    name::Union{Nothing,String} = nothing
    parent::Union{Nothing,String} = nothing
    description::Union{Nothing,String} = nothing
    # availability::Union{Nothing,} = nothing # TODO
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

struct Document
    packets::Union{Packet,Preamble,Vector{Any}}
end

function check_rgba(rgba::Vector{Number})::Nothing
    if !(length(rgba) == 4 || mod(length(rgba), 5) == 0)
        error(
            "Input values must have either 4 or N * 5 values, where N is the number of time-tagged samples.",
        )
    end

    if length(rgba) == 4
        for n in rgba
            if !(0 ≤ n ≤ 255)
                error("rgba values must be between zero and one.")
            end
        end
    else
        for i in 1:5:length(rgba)-1
            values = rgba[i+1:i+4]
            for n in values
                if !(0 ≤ n ≤ 255)
                    error("rgba values must be between zero and one.")
                end
            end
        end
    end
end

function check_rgbaf(rgbaf::Vector{Number})::Nothing
    if !(length(rgbaf) == 4 || mod(length(rgbaf), 5) == 0)
        error(
            "Input values must have either 4 or N * 5 values, where N is the number of time-tagged samples.",
        )
    end

    if length(rgbaf) == 4
        for n in rgbaf
            if !(0 ≤ n ≤ 1)
                error("rgba values must be between zero and one.")
            end
        end
    else
        for i in 1:5:length(rgbaf)-1
            values = rgbaf[i+1:i+4]
            for n in values
                if !(0 ≤ n ≤ 1)
                    error("rgba values must be between zero and one.")
                end
            end
        end
    end
end

function check_Position(pos::Position)::Nothing
    if 0 ≥ sum(
        map(
            isnothing,
            [pos.cartesian pos.cartographicDegrees pos.cartographicRadians pos.cartesianVelocity pos.reference],
        ),
    )
        error(
            "One and only one of cartesian, cartographicDegrees, cartographicRadians, cartesianVelocity or reference must be given",
        )
    end
end

function check_PositionList(posList::PositionList)::Nothing
    if 0 ≥ sum(
        map(
            isnothing,
            [posList.cartesian posList.cartographicDegrees posList.cartographicRadians posList.cartesianVelocity pos.reference],
        ),
    )
        error(
            "One and only one of cartesian, cartographicDegrees, cartographicRadians, cartesianVelocity or reference must be given",
        )
    end
end

function check_Uri(uri::Uri)::Nothing
    if !isvalid(URI(uri.uri))
        error("uri must be a URL or a data URI")
    end
end

function check_ViewFrom(viewFrom::ViewFrom)::Nothing
    if 0 ≥ sum(map(isnothing, [viewFrom.cartesian viewFrom.reference]))
        error("One of cartesian or reference must be given")
    end
end
