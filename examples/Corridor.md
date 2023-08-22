# Corridor

## CZML File

This example was taken from Cesium Sandcastle [here](#https://sandcastle.cesium.com/?src=CZML%20Corridor.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Geometries: Polyline",
  version: "1.0",
},
{
  id: "redCorridor",
  name: "Red corridor on surface with rounded corners",
  corridor: {
    positions: {
      cartographicDegrees: [
        -100.0,
        40.0,
        0,
        -105.0,
        40.0,
        0,
        -105.0,
        35.0,
        0,
      ],
    },
    width: 200000.0,
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 127],
        },
      },
    },
  },
},
{
  id: "greenCorridor",
  name: "Green corridor at height with mitered corners and outline",
  corridor: {
    positions: {
      cartographicDegrees: [
        -90.0,
        40.0,
        0,
        -95.0,
        40.0,
        0,
        -95.0,
        35.0,
        0,
      ],
    },
    height: 100000.0,
    cornerType: "MITERED",
    width: 200000.0,
    material: {
      solidColor: {
        color: {
          rgba: [0, 255, 0, 255],
        },
      },
    },
    outline: true, // height must be set for outlines to display
    outlineColor: {
      rgba: [0, 0, 0, 255],
    },
  },
},
{
  id: "blueCorridor",
  name: "Blue extruded corridor with beveled corners and outline",
  corridor: {
    positions: {
      cartographicDegrees: [
        -80.0,
        40.0,
        0,
        -85.0,
        40.0,
        0,
        -85.0,
        35.0,
        0,
      ],
    },
    height: 200000.0,
    extrudedHeight: 100000.0,
    width: 200000.0,
    cornerType: "BEVELED",
    material: {
      solidColor: {
        color: {
          rgba: [0, 0, 255, 255],
        },
      },
    },
    outline: true,
    outlineColor: {
      rgba: [255, 255, 255, 255],
    },
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Geometries: Polyline")

p1 = Packet(; id = "redCorridor", name = "Red corridor on surface with rounded corners",
    corridor = Corridor(;
        positions = PositionList(;
            cartographicDegrees = [-100.0, 40.0, 0, -105.0, 40.0, 0, -105.0, 35.0, 0]), width = 200000.0,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 127])
            ))))

p2 = Packet(; id = "greenCorridor",
    name = "Green corridor at height with mitered corners and outline",
    corridor = Corridor(;
        positions = PositionList(;
            cartographicDegrees = [-90.0, 40.0, 0, -95.0, 40.0, 0, -95.0, 35.0, 0]), height = 100000.0, cornerType = CornerTypes.MITERED, width = 200000.0,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 255, 0, 255])
            )), outline = true, outlineColor = Color(; rgba = [0, 0, 0, 255])))

p3 = Packet(; id = "blueCorridor",
    name = "Blue extruded corridor with beveled corners and outline",
    corridor = Corridor(;
        positions = PositionList(;
            cartographicDegrees = [-80.0, 40.0, 0, -85.0, 40.0, 0, -85.0, 35.0, 0]), height = 200000.0, extrudedHeight = 100000.0, width = 200000.0,
        cornerType = CornerTypes.BEVELED,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 0, 255, 255])
            )), outline = true, outlineColor = Color(; rgba = [255, 255, 255, 255])))

d = Document(; preamble = p0, packets = [p1, p2, p3])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
