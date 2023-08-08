module CZML

export InterpolationAlgorithms,
    ExtrapolationTypes,
    ReferenceFrames,
    LabelStyles,
    ClockRanges,
    ClockSteps,
    VerticalOrigins,
    HorizontalOrigins,
    HeightReferences,
    ColorBlendModes,
    ShadowModes,
    ClassificationTypes,
    ArcTypes,
    StripeOrientations,
    Material,
    PolylineOutlineMaterial,
    PolylineGlowMaterial,
    PolylineArrowMaterial,
    PolylineDashMaterial,
    PolylineMaterial,
    SolidColorMaterial,
    GridMaterial,
    StripeMaterial,
    CheckerboardMaterial,
    ImageMaterial,
    Color,
    Position,
    ViewFrom,
    Billboard,
    EllipsoidRadii,
    Corridor,
    Cylinder,
    Ellipse,
    Polygon,
    Polyline,
    ArcType,
    ShadowMode,
    ClassificationType,
    DistanceDisplayCondition,
    PositionList,
    Ellipsoid,
    Box,
    BoxDimensions,
    Rectangle,
    RectangleCoordinates,
    EyeOffset,
    HeightReference,
    Clock,
    Path,
    Point,
    TileSet,
    Wall,
    NearFarScalar,
    Label,
    Orientation,
    Model,
    Uri,
    Font,
    Interpolatable,
    Deletable,
    CZML_TYPES_ENUMS,
    CZML_TYPES_PROPERTIES,
    ISO8601_FORMAT_Z,
    check_rgba,
    check_rgbaf,
    check_Position,
    check_PositionList,
    check_Uri,
    check_ViewFrom,
    Preamble,
    Packet,
    Document
include("properties.jl")

CZML_TYPES_PROPERTIES = Union{
    Material,
    PolylineOutlineMaterial,
    PolylineGlowMaterial,
    PolylineArrowMaterial,
    PolylineDashMaterial,
    PolylineMaterial,
    SolidColorMaterial,
    GridMaterial,
    StripeMaterial,
    CheckerboardMaterial,
    ImageMaterial,
    Color,
    Position,
    ViewFrom,
    Billboard,
    EllipsoidRadii,
    Corridor,
    Cylinder,
    Ellipse,
    Polygon,
    Polyline,
    ArcType,
    ShadowMode,
    ClassificationType,
    DistanceDisplayCondition,
    PositionList,
    Ellipsoid,
    Box,
    BoxDimensions,
    Rectangle,
    RectangleCoordinates,
    EyeOffset,
    HeightReference,
    Clock,
    Path,
    Point,
    TileSet,
    Wall,
    NearFarScalar,
    Label,
    Orientation,
    Model,
    Uri,
    Font,
    Preamble,
    Packet,
}
CZML_TYPES_ENUMS = Union{
    InterpolationAlgorithms.T,
    ExtrapolationTypes.T,
    ReferenceFrames.T,
    LabelStyles.T,
    ClockRanges.T,
    ClockSteps.T,
    VerticalOrigins.T,
    HorizontalOrigins.T,
    HeightReferences.T,
    ColorBlendModes.T,
    ShadowModes.T,
    ClassificationTypes.T,
    ArcTypes.T,
    StripeOrientations.T,
}
ISO8601_FORMAT_Z = "yyyy-mm-ddTHH:M:S.sZ"

using JSON

function encodeProperties(property::CZML_TYPES_PROPERTIES)::Dict{String,Any}
    out::Dict{String,Any} = Dict()
    for n in fieldnames(typeof(property))
        result = getfield(property, n)
        if isnothing(result)
            continue
        end
        result_type = typeof(result)

        # checks
        check_function_name = Symbol("check_" * string(n))
        if isdefined(CZML, check_function_name)
            getfield(CZML, check_function_name)(result)
        end

        # add to packet
        if result_type <: CZML_TYPES_PROPERTIES
            new_result = encodeProperties(result)
            if isempty(new_result)
                continue
            end
            out[string(n)] = new_result
        elseif result_type <: CZML_TYPES_ENUMS
            out[string(n)] = string(Symbol(result))
        elseif result_type isa DateTime
            out[string(n)] = Dates.format(result, ISO8601_FORMAT_Z)  # TODO from UTC?
        elseif result_type <: Union{Interpolatable,Deletable}
            new_result = encodeProperties(result)
            if isempty(new_result)
                continue
            end
            merge!(out[string(n)], new_result)
        else
            out[string(n)] = result
        end
    end
    return out
end

function encodeDocument(document::Document)::Vector{Dict{String,Any}}
    if document.packets isa Packet
        packets = [document.packets]
    else
        packets = document.packets
    end

    preamble_found = false
    for packet in packets
        if packet isa Preamble
            preamble_found = true
            break
        end
    end
    if !preamble_found
        error("Preamble not found in document.")
    end

    out = Vector{Dict{String,Any}}()
    for packet in packets
        push!(out, encodeProperties(packet))
    end
    return out
end

function printCZML(document::Document, filePath::String, exist_okay::Bool = false)::Nothing
    suffix = split(filePath, ".")[2]
    if cmp(lowercase(suffix), "czml") != 0
        error("Suffix must be `.czml``.")
    end

    if !exist_okay && isfile(filePath)
        error("$filePath exists. To overwrite the file set `exist_okay` to true.")
    elseif isfile(filePath)
        rm(filePath)
    end

    open(filePath, "w") do f
        JSON.print(f, encodeDocument(document))
    end
end

export encodeDocument, encodeProperties, printCZML

export srrm2sddm, sddm2srrm, rrm2ddm, ddm2rrm
include("conversions.jl")

end
