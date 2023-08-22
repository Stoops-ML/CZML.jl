# Circles and Ellipses

## CZML File

This example was taken from Cesium Sandcastle [here](#https://sandcastle.cesium.com/?src=CZML%20Circles%20and%20Ellipses.html&label=CZML).

```
[
{
  id: "document",
  name: "CZML Geometries: Circles and Ellipses",
  version: "1.0",
},
{
  id: "shape1",
  name: "Green circle at height",
  position: {
    cartographicDegrees: [-111.0, 40.0, 150000.0],
  },
  ellipse: {
    semiMinorAxis: 300000.0,
    semiMajorAxis: 300000.0,
    height: 200000.0,
    material: {
      solidColor: {
        color: {
          rgba: [0, 255, 0, 255],
        },
      },
    },
  },
},
{
  id: "shape2",
  name: "Red ellipse with white outline on surface",
  position: {
    cartographicDegrees: [-103.0, 40.0, 0],
  },
  ellipse: {
    semiMinorAxis: 250000.0,
    semiMajorAxis: 400000.0,
    height: 0,
    material: {
      solidColor: {
        color: {
          rgba: [255, 0, 0, 127],
        },
      },
    },
    outline: true, // height must be set for outlines to display
    outlineColor: {
      rgba: [255, 255, 255, 255],
    },
  },
},
{
  id: "shape3",
  name:
    "Blue translucent, rotated, and extruded ellipse with outline",
  position: {
    cartographicDegrees: [-95.0, 40.0, 100000.0],
  },
  ellipse: {
    semiMinorAxis: 150000.0,
    semiMajorAxis: 300000.0,
    extrudedHeight: 200000.0,
    rotation: 0.78539,
    material: {
      solidColor: {
        color: {
          rgba: [0, 0, 255, 127],
        },
      },
    },
    outline: true,
  },
},          ]
```

# Julia Code

The above can be created using CZML in julia:

```julia

p0 = Preamble(; name = "CZML Geometries: Circles and Ellipses")

p1 = Packet(; id = "shape1", name = "Green circle at height",
    position = Position(; cartographicDegrees = [-111.0, 40.0, 150000.0]),
    ellipse = Ellipse(; semiMinorAxis = 300000.0, semiMajorAxis = 300000.0,
        height = 200000.0,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 255, 0, 255])
            ))))

p2 = Packet(; id = "shape2", name = "Red ellipse with white outline on surface",
    position = Position(; cartographicDegrees = [-103.0, 40.0, 0.0]),
    ellipse = Ellipse(; semiMinorAxis = 250000.0, semiMajorAxis = 400000.0,
        height = 0.0,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [255, 0, 0, 127])
            )), outline = true, outlineColor = Color(; rgba = [255, 255, 255, 255])))

p3 = Packet(; id = "shape3",
    name = "Blue translucent, rotated, and extruded ellipse with outline",
    position = Position(; cartographicDegrees = [-95.0, 40.0, 100000.0]),
    ellipse = Ellipse(; semiMinorAxis = 150000.0, semiMajorAxis = 300000.0,
        extrudedHeight = 200000.0, rotation = 0.78539,
        material = Material(;
            solidColor = SolidColorMaterial(; color = Color(; rgba = [0, 0, 255, 127])
            )), outline = true))

d = Document(; preamble = p0, packets = [p1, p2, p3])

fileName = tempname() * ".czml"

printCZML(d, fileName)
```
