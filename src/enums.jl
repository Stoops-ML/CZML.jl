using EnumX

# The interpolation algorithm to use when interpolating.
@enumx InterpolationAlgorithms begin
    LINEAR
    LAGRANGE
    HERMITE
end

# https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/CornerTypeValue
@enumx CornerTypes begin
    ROUNDED
    MITERED
    BEVELED
end

# The type of extrapolation to perform when a value is requested at a time after any available samples.
@enumx ExtrapolationTypes begin
    NONE
    HOLD
    EXTRAPOLATE
end

# The reference frame in which cartesian positions are specified.
@enumx ReferenceFrames begin
    FIXED
    INERTIAL
end

# The style of a label.
@enumx LabelStyles begin
    FILL
    OUTLINE
    FILL_AND_OUTLINE
end

# The behavior of a clock when its current time reaches its start or end time.
@enumx ClockRanges begin
    UNBOUNDED
    CLAMPED
    LOOP_STOP
end

@enumx ClockSteps begin
    TICK_DEPENDENT
    SYSTEM_CLOCK_MULTIPLIER
    SYSTEM_CLOCKaut
end

@enumx VerticalOrigins begin
    BASELINE
    BOTTOM
    CENTER
    TOP
end

# https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/HorizontalOriginValue
@enumx HorizontalOrigins begin
    LEFT
    CENTER
    RIGHT
end

@enumx HeightReferences begin
    NONE
    CLAMP_TO_GROUND
    RELATIVE_TO_GROUND
end

@enumx ColorBlendModes begin
    HIGHLIGHT
    REPLACE
    MIX
end

@enumx ShadowModes begin
    DISABLED
    ENABLED
    CAST_ONLY
    RECEIVE_ONLY
end

@enumx ClassificationTypes begin
    TERRAIN
    CESIUM_3D_TILE
    BOTH
end

@enumx ArcTypes begin
    NONE
    GEODESIC
    RHUMB
end

@enumx StripeOrientations begin
    HORIZONTAL
    VERTICAL
end
